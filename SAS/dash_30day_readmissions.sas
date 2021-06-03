
/************************************************************************************************************************
*                      TMF Health Quality Institute
*  Filename: dash_30day_readmissions_sas
*  Location: \user\my folder\dash_30day_readmissions_sas_final.sas
*  Deliverable #: DASH-001
*  Purpose:	Get 30-day readmission rates in DE-SynPUF data for use in Tableau and other analytics tools 
*  Created by:	Piyusha Joshi and Rob Brill
*  Date: 06/03/2021
**************************************************************************************************************************

1.	set up desynpuf and crosswalk datasets 
2.	format variables for processing, 
3.	get index and readmission claims, deduplicate and join to beneficiary geo and demo data 
4.  aggregate to county, npi, and facility level 
5.  save final tables to oracle db for use in tableau 

**************************************************************************************************************************/
/*

/* pt 1. importing database tables to sas environment for processing */

/* fips/ssa crosswalk */
FILENAME REFFILE FILESRVC FOLDERPATH='/Users/sasuser/My Folder'  FILENAME='xwalk2018.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;




/* inpatient claims and beneficiary tables from oracle */
data dash_inpatient; 
set dash.dash_claim_inpatient; 
run; 

data dash_beneficiary; 
set dash.dash_beneficiary; 
run; 


/* pt 2. variable formatting */
proc sql;
 	create table dash_inpatient1 as 
		select *, 
				case when datepart(clm_from_dt) in ('01jan1970'd '01jan2001'd) then . 
				else datepart(clm_from_dt)
					 end as clm_from format=date9.,
				case when datepart(clm_thru_dt)  in ('01jan1970'd '01jan2001'd) then . 
					else datepart(clm_thru_dt)
					 end as clm_thru format=date9., 
				case when datepart(clm_admsn_dt) in ('01jan1970'd '01jan2001'd) then . 
					else datepart(clm_admsn_dt)
					 end as clm_admsn format=date9., 
				case when datepart(nch_bene_dschrg_dt) in ('01jan1970'd '01jan2001'd) then . 
					else datepart(nch_bene_dschrg_dt) 
					end as nch_bene_dschrg format=date9.

			from 
				dash_inpatient
			order by 
					 clm_thru_dt desc ; 


/*pt 3. select key variables from claims for all admissions -- 
	note that setting and discharge codes are not available in the DESynPUF data 
		so this code is highly simplified from CDR claims readmission calculations */

/* 3a. */
proc sql;
  create table index_ip as
      select  desynpuf_id,
					 clm_id,
					 prvdr_num,
					at_physn_npi as index_npi,  
					clm_admsn as Index_admsn_dt,
            		clm_from as Index_clm_from_dt,
					 clm_thru as Index_clm_thru_dt, 
					year(clm_admsn) as index_admission_year, 
					1 as admission
      from
 			dash_inpatient1  
      where   
			segment = 1  
			and 
			clm_admsn ne . 
		order by desynpuf_id, 
				clm_admsn;
quit;

/* deduplicate claims by admission based on admssion date per beneficiary */
proc sort data=index_ip out=index1 nodupkey;
 by desynpuf_id index_admsn_dt; 
run; 

	/* 3b. find readmissions within beneficiary based on admission date being <30 days from index admission */
proc sql;
  create table readmissions as
	  select a.desynpuf_id, 
			a.prvdr_num,
			a.index_npi , 
			 a.Index_admsn_dt,
			 a.Index_clm_from_dt, 
			a.Index_clm_thru_dt, 
			b.clm_admsn as readmission_date,  
			year(a.Index_admsn_dt) as index_admission_year, 
			year(b.clm_admsn) as readmission_year, 
				1 as readmission
	    from 
			index1 a 
			left join
			dash_inpatient1 b 
		on 
			a.desynpuf_id =b.desynpuf_id 
        where b.segment = 1 
			and b.clm_admsn > a.Index_clm_thru_dt
			and b.clm_admsn ^= a.Index_admsn_dt 
			and (b.clm_admsn - a.Index_clm_thru_dt) <30 
			and b.clm_admsn ne . 
		order by a.desynpuf_id,
			 a.Index_admsn_dt;
quit;

	/* deduplicate readmissions by date */
proc sort data=readmissions out=readm2 nodupkey; 
by desynpuf_id index_admsn_dt readmission_date;
 run; 

/* 3c. join admission and readmission*/
proc sql;
  create table tableau_input as
	  select distinct a.desynpuf_id,
					 a.prvdr_num,
					 a.admission, 
					a.Index_admsn_dt,
					 a.Index_clm_thru_dt, 
					a.index_npi, 
					b.readmission_date, 
					a.index_admission_year,
					 b.readmission_year
					,readmission
	    from index1 a
			 left join 
			readm2 b
		 on 
			a.desynpuf_id =b.desynpuf_id
			 and 
			a.Index_admsn_dt = b.Index_admsn_dt
		 order by 
			a.desynpuf_id, 
			a.Index_admsn_dt, 
			b.readmission_date;
quit;

/* deduplicate readmission claims to get single row per readmission */

proc sort data=dash_beneficiary out=bene_fips nodupkey; 
by desynpuf_id sp_state_code bene_county_cd file_year; run; 

/*pt 4. assign beneficairy information to readmissions */
	/*4a. get most recent SSA county code from beneficiary table */
data bene_fips1; 
set bene_fips;
by desynpuf_id; 
if last.desynpuf_id; 
fips5=strip(left(sp_state_code))||strip(left(bene_county_cd)); 
run; 

	/* limit to key indicators */
data dash.tab_bene2; 
set bene_fips1 (keep= desynpuf_id bene_esrd_ind bene_hi_cvrage_tot_mons bene_hmo_cvrage_tot_mons bene_race_cd bene_sex_ident_cd
 sp:); 
 ; 
run; 

	/* join readmissions data and beneficiary demographic and coverage data */
proc sql; 
	create table tab1 as 
		select 
			b.fips5,
			a.*
			

	from tableau_input a 
		left join 
		bene_fips1 b 
	on
		a.desynpuf_id=b.desynpuf_id
	order by 
		fips5 asc; 


		/* aggregate to county level to save processing time in tableau */
proc sql; 
create table countylevel as 
	select 
		distinct fips5, 
				sum(admission) as den, 
				sum(readmission) as num, 
				((sum(readmission)*1000)/sum(admission)) as rate1k
			from 
				tab1
			group by 
				fips5; 

create table countylevel2 as 
	select a.*, 
			b.'FIPS County Code'n as fips_ssa, 	
			b.state 
	from 
		countylevel a 
	left join 
	import b 
on a.fips5=b.ssacd; 

	/* aggregate to NPI and facility-level (not currently used) for tableau */
create table npilevel as 
	select 
		distinct index_npi, 
				sum(admission) as den, 
				sum(readmission) as num, 
				((sum(readmission)*1000)/sum(admission)) as rate1k
			from 
				tab1
			group by 
				index_npi; 

create table faclevel as 
		select distinct prvdr_num,
					sum(admission) as den, 
					sum(readmission) as num, 
					(sum(readmission)*1000/sum(admission)) as rate1k
			from 
				tab1
			group by 
				prvdr_num; 
quit; 




/*save datasets to dash oracle db  */
data dash.tab_all;
	set tab1; 
run; 
data dash.tab_countylevel2; 
	set countylevel2; 
run; 
data dash.tab_npilevel; 
	set npilevel; 
run; 
data dash.tab_faclevel; 
	set faclevel; 
run; 

