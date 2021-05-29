/*-------------------------------------------------------------------*/
/*  Program Name: DESYNPUF_IP_READIN.SAS                             */
/*  SAS Version:  Tested under SAS 9.3 Windows XP                    */
/*  Purpose:      Create SAS data sets from IP synthetic PUF CSV     */
/*                files.                                             */
/*                                                                   */
/*  BACKGROUND:   Each data type in the CMS Linkable 2008-2010       */
/*  Medicare DE-SynPUFs was released in 20 separate subsamples. The  */
/*  same group of beneficiary IDs are in subsamples with the same    */
/*  number. The suffix of each CSV filename contains the subsample   */
/*  number. This design allows DE-SynPUFs users who do not need the  */
/*  entire synthetic population of DE-SynPUFs to read in only as many*/
/*  subsamples as they desire. This read-in program allows users to  */
/*  specify which IP subsamples to read in and to combine.           */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*  USER INSTRUCTIONS: Modify the following as necessary.            */
/*  1. Assign to macro variable INFILEPATH the path where the CSV    */
/*     files are stored.                                             */
/*  2. Assign to macro variable INFILENAME the filename of the CSV   */
/*     file without the subsample number suffix and without the CSV  */
/*     extension. The program will add the numeric suffix and it will*/
/*     add the CSV extension.                                        */
/*  3. Specify path for DESYNPUF LIBNAME. This is the location where */
/*     the SAS data sets created by this program will be stored.     */
/*  4. Assign to macro variable OUTDSNAME the name you want to assign*/
/*     to the SAS data set created from the CSV file. Do not include */
/*     the subsample number suffix since the program will add that to*/
/*     the data set name. The name must conform to SAS naming rules  */
/*     and be 30 characters or less in length. The 30 characters     */
/*     limit allows for the addition of the subsample number to the  */
/*     name.                                                         */
/*  5. Set parameters on calls to macro program DESYNPUF_IP_READIN.  */
/*     Keep only the calls to macro program DESYNPUF_IP_READIN for   */
/*     the subsamples that you want to process. Comment out the calls*/
/*     to DESYNPUF_IP_READIN for the subsamples that you do not want */
/*     to process (or delete the calls).                             */
/*     This macro has two parameters and both are required:          */
/*     FILENUMBER= and SORTDS=.                                      */
/*     - Set the FILENUMBER= parameter value to the subsample number */
/*       suffix of the CSV file that you want to read in. The SAS    */
/*       data set that is created will have the same numeric suffix. */
/*     - The SORTDS= parameter specifies whether you want to sort the*/
/*       new data set by DESYNPUF_ID. The CSV files are saved in     */
/*       ASCII DESYNPUF_ID order and so you may not need to sort the */
/*       files if you intend to use them in ASCII DESYNPUF_ID order. */
/*  6. Optionally, call macro program DESYNPUF_IP_COMBINE if you     */
/*     want to combine the new IP data sets into one data set. This  */
/*     code requires that the data sets you want to combine are      */
/*     consecutively numbered subsamples.                            */
/*       The name of the output data set created by this macro       */
/*     is the name specified by macro variable OUTDSNAME. No         */
/*     subsample numbers will be added as a suffix to the data set   */
/*     name.                                                         */
/*     NOTE: If you do not have consecutively numbered subsamples,   */
/*     you will need to write a DATA step that concatenates these    */
/*     subsample data sets.                                          */
/*       This code interleaves the data sets by DESYNPUF_ID.         */
/*     Therefore, the data sets that you want to combine must be in  */
/*     order by DESYNPUF_ID. If you do not want to call macro program*/
/*     DESYNPUF_IP_COMBINE, comment out (or delete) the call to this */
/*     macro program.                                                */
/*       This macro program has two parameters STARTNUMBER= and      */
/*     ENDNUMBER=. These parameters specify the numeric range of     */
/*     files (the subsample numbers) that you want to combine.       */
/*       If you want to combine the data sets at a later time, you   */
/*     can run this macro program by itself. Do steps 1-4. Do not do */
/*     Step 5 and remove the calls to macro program                  */
/*     DESYNPUF_IP_READIN. Depending on any post-processing that you */
/*     may have done, you might need to sort the files that you want */
/*     to combine by DESYNPUF_ID before you call DESYNPUF_IP_COMBINE.*/
/*                                                                   */
/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Date:         16 Nov 2012                                        */
/*  Last Updated: 11 Dec 2012 11:42:21                               */
/*-------------------------------------------------------------------*/

/*********************************************************************/
/* Declare global macro variables used by this program.              */
/*********************************************************************/
%symdel infilepath infilename outdsname;
%global infilepath infilename outdsname;

/*********************************************************************/
/* 1. Specify path of input CSV files. Do not enclose value in       */
/*    quotation marks.                                               */
/*********************************************************************/
%let infilepath= ;

/**************************************************************************/
/* 2. Specify filename of input CSV file. Do not include the numeric      */
/*    suffix and do not include the CSV extension. The program assigns    */
/*    both of these values. Do not enclose the filename in quotation      */
/*    marks.                                                              */
/**************************************************************************/
%let infilename=DE1_0_2008_to_2010_Inpatient_Claims_Sample_;

/**************************************************/
/* 3. Specify LIBNAME of DE-SynPUF IP files.      */
/**************************************************/
libname desynpuf " ";

/**************************************************************************/
/* 4. Specify filename(30 characters or less) of SAS datasets created by  */
/*    this program. Do not include the subsample number suffix. The       */
/*    program adds that value to the end of the SAS data set name.        */
/**************************************************************************/
%let outdsname=DE1_0_2008_to_2010_IP_Sample_;

/**************************************************************************/
/* Set SAS options for this program: 11 Dec 2012 11:14:25                 */
/*   VALIDVARNAME=UPCASE: Ensure that all variable names are in uppercase.*/
/*   COMPRESS=BINARY: Compress data sets created by this program.         */
/*   MPRINT: View resolved code in SAS log (optional -- NOMPRINT turns it */
/*           off)                                                         */
/**************************************************************************/
options validvarname=upcase
        compress=binary
        mprint
        ls=100 ps=60;


/*********************************************************************************/
/*********************************************************************************/
/* START OF SECTION THAT SHOULD NOT BE MODIFIED (unless you want to sort the     */
/* data set. See instruction 5a.)                                                */
/*********************************************************************************/

%macro addseqattrib(varname=,nvars=,varlength=,varinformat=,varformat=,labeltext=);
  %******************************************************************************;
  %* This macro program is called by macro program DESYNPUF_IP_READIN. It        ;
  %* generates ATTRIB information for a series of variables. The parameters are  ;
  %*                                                                             ;
  %* The VARNAME= and NVARS= parameters are required.                            ;
  %* VARNAME=  name of series of variables (everything but the numeric suffix)   ;
  %* NVARS=    number of variables in the series                                 ;
  %*                                                                             ;
  %* The remaining parameters are optional.                                      ;
  %* VARLENGTH=  length of each variable in the series. If the series is         ;
  %*             character type, precede the length with a dollar sign ($)       ;
  %* VARINFORMAT= informat to use to read in the series. If the informat ends in ;
  %*              a period, include the period.                                  ;
  %* VARFORMAT=   format to use to display the values of the series. If the      ;
  %*              format ends in a period, include the period.                   ;
  %* LABELTEXT=   label to assing to series. The program adds the variable number;
  %*              to the end of the label. Be careful of quotation marks or other;
  %*              special characters. You may need to hardcode labels that       ;
  %*              special characters.                                            ;
  %******************************************************************************;

  %local a;

  %do a=1 %to &nvars;
     &varname&a %if &varlength ne %then %do;
                  length=&varlength
                %end;
                %if &varinformat ne %then %do;
                  informat=&varinformat
                %end;
                %if &varformat ne %then %do;
                  format=&varformat
                %end;
                %if %nrbquote(&labeltext) ne %then %do;
                  label="&labeltext &a"
                %end;
  %end;

%mend addseqattrib;


%macro desynpuf_ip_readin(filenumber=,sortds=);
  %******************************************************************************;
  %* Macro program DESYNPUF_IP_READIN creates a data set by reading a single     ;
  %* Synthetic PUF IP CSV file. The required FILENUMBER= parameter identifies    ;
  %* which IP CSV file to read in. The CSV files are stored with a numeric       ;
  %* suffix, which is the subsample number. If you want to read in multiple      ;
  %* subsamples, you must call DESYNPUF_IP_READIN once for each subsample.       ;
  %*                                                                             ;
  %* The input path and input filename are determined by the values of global    ;
  %* macro variables that are defined at the top of this program.                ;
  %*                                                                             ;
  %* The DESYNPUF libname and output data set name are determined by the values  ;
  %* of the global macro variables that are defined at the top of this program.  ;
  %*                                                                             ;
  %* See instructions at the top of this program for assign path and filename    ;
  %* values to the global macro variables.                                       ;
  %*                                                                             ;
  %* After the new data set is created, output is generated using PROCs CONTENTS,;
  %* PRINT, MEANS, and FREQ to verify the data set contents.                     ;
  %******************************************************************************;

  %let sortds=%upcase(&sortds);

  filename inip "&infilepath\&infilename.&filenumber..csv" ;

  data desynpuf.&outdsname&filenumber(label="DE1_0_2008_to_2010_Inpatient_Claims_Sample_&filenumber");
    infile inip dsd dlm=',' lrecl=1300 firstobs=2 stopover;

    attrib DESYNPUF_ID   length=$16 format=$16. label='DESYNPUF: Beneficiary Code'
           CLM_ID        length=$15 format=$15. label='DESYNPUF: Claim ID'
           SEGMENT       length=3   format=2. label='DESYNPUF: Claim Line Segment'
           CLM_FROM_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims start date'
           CLM_THRU_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims end date'
           PRVDR_NUM     length=$6  format=$6. label='DESYNPUF: Provider Institution'
           CLM_PMT_AMT   length=8   format=12.2 label='DESYNPUF: Claim Payment Amount'
           NCH_PRMRY_PYR_CLM_PD_AMT length=8 format=12.2 label='DESYNPUF: NCH Primary Payer Claim Paid Amount'
           AT_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Attending Physician - National Provider Identifier Number'
           OP_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Operating Physician - National Provider Identifier Number'
           OT_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Other Physician - - National Provider Identifier Number'
           CLM_ADMSN_DT  length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Inpatient admission date'
           ADMTNG_ICD9_DGNS_CD      length=$5 format=$5. label='DESYNPUF: Claim Admitting Diagnosis Code'
           CLM_PASS_THRU_PER_DIEM_AMT length=8 format=12.2 label='DESYNPUF: Claim Pass Thru Per Diem Amount'
           NCH_BENE_IP_DDCTBL_AMT     length=8 format=12.2 label='DESYNPUF: NCH Beneficiary Inpatient Deductible Amount'
           NCH_BENE_PTA_COINSRNC_LBLTY_AM length=8 format=12.2 label='DESYNPUF: NCH Beneficiary Part A Coinsurance Liability Amount'
           NCH_BENE_BLOOD_DDCTBL_LBLTY_AM length=8 format=12.2 label='DESYNPUF: NCH Beneficiary Blood Deductible Liability Amount'
           CLM_UTLZTN_DAY_CNT length=3 format=3. label='DESYNPUF: Claim Utilization Day Count'
           NCH_BENE_DSCHRG_DT length=4 informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Inpatient discharged date'
           CLM_DRG_CD    length=$3  format=$3. label='DESYNPUF: Claim Diagnosis Related Group Code'
           %addseqattrib(varname=ICD9_DGNS_CD_,nvars=10,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Diagnosis Code)
           %addseqattrib(varname=ICD9_PRCDR_CD_,nvars=6,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Procedure Code)
           %addseqattrib(varname=HCPCS_CD_,nvars=45,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Revenue Center HCFA Common Procedure Coding System)

           ;;

    input DESYNPUF_ID
          CLM_ID
          SEGMENT
          CLM_FROM_DT
          CLM_THRU_DT
          PRVDR_NUM
          CLM_PMT_AMT
          NCH_PRMRY_PYR_CLM_PD_AMT
          AT_PHYSN_NPI
          OP_PHYSN_NPI
          OT_PHYSN_NPI
          CLM_ADMSN_DT
          ADMTNG_ICD9_DGNS_CD
          CLM_PASS_THRU_PER_DIEM_AMT
          NCH_BENE_IP_DDCTBL_AMT
          NCH_BENE_PTA_COINSRNC_LBLTY_AM
          NCH_BENE_BLOOD_DDCTBL_LBLTY_AM
          CLM_UTLZTN_DAY_CNT
          NCH_BENE_DSCHRG_DT
          CLM_DRG_CD
          ICD9_DGNS_CD_1-ICD9_DGNS_CD_10
          ICD9_PRCDR_CD_1-ICD9_PRCDR_CD_6
          HCPCS_CD_1-HCPCS_CD_45
        ;
  run;

  filename inip clear;

  /*********************************************************************/
  /* Sort the data set if SORTDS=Y or SORTDS=YES.                      */
  /*********************************************************************/
  %if &sortds=Y or &sortds=YES %then %do;
    proc sort data=desynpuf.&outdsname&filenumber;
      by desynpuf_id;
    run;
  %end;

  /*********************************************************************/
  /* Examine new data set                                              */
  /*********************************************************************/
  title "Processing DE1_0_2008_to_2010_Inpatient_Claims_Sample_&filenumber";
  proc contents data=desynpuf.&outdsname&filenumber varnum;
  run;
  proc print data=desynpuf.&outdsname&filenumber(obs=5);
    title2 'Subsample Listing - First 5 Rows';
  run;
  proc means data=desynpuf.&outdsname&filenumber;
    title2 'Simple Means';
  run;
  proc freq data=desynpuf.&outdsname&filenumber;
    title2 'Simple Frequencies';
    table clm_from_dt clm_thru_dt clm_admsn_dt nch_bene_dschrg_dt / missing;
    format clm_from_dt clm_thru_dt clm_admsn_dt nch_bene_dschrg_dt year4.;
  run;

%mend desynpuf_ip_readin;

%macro desynpuf_ip_combine(startnumber=,endnumber=);
  %******************************************************************************;
  %* Macro program DESYNPUF_IP_COMBINE concatenates several IP data sets.        ;
  %* The data sets with the suffix starting with the numeric value assigned to   ;
  %* STARTNUMBER and ending with the numeric value assigned to ENDNUMBER are     ;
  %* concatenated.                                                               ;
  %*                                                                             ;
  %* Both the STARTNUMBER= and ENDNUMBER= parameters are required.               ;
  %*                                                                             ;
  %* After the new data set is created, output is generated                      ;
  %******************************************************************************;
  %local i;

  data desynpuf.&outdsname(label="DE1_0_2008_to_2010_Inpatient_Claims_Sample_&startnumber to &endnumber");
    set
    %do i=&startnumber %to &endnumber;
      desynpuf.&outdsname.&i
    %end;
    ;;;
    by desynpuf_id;
  run;

  /*********************************************************************/
  /* Examine new data set                                              */
  /*********************************************************************/
  title "Processing DE1_0_2008_to_2010_Inpatient_Claims_Sample_&startnumber to &endnumber";
  proc contents data=desynpuf.&outdsname varnum;
  run;
  proc means data=desynpuf.&outdsname;
    title2 'Simple Means';
  run;
  proc freq data=desynpuf.&outdsname;
    title2 'Simple Frequencies';
    table clm_from_dt clm_thru_dt / missing;
    format clm_from_dt clm_thru_dt year4.;
  run;

%mend desynpuf_ip_combine;

/*********************************************************************************/
/* END OF SECTION THAT SHOULD NOT BE MODIFIED.                                   */
/*********************************************************************************/
/*********************************************************************************/

/*********************************************************************************/
/* START OF SECTION THAT SHOULD BE REVIEWED AND/OR MODIFIED                      */
/*********************************************************************************/

/*********************************************************************************/
/* 5. Call macro program DESYNPUF_IP_READIN once for each IP CSV file you want to*/
/*    to read in. Assign to FILENUMBER= the numeric suffix (the subsample number)*/
/*    of the CSV file. Assign to SORTDS a value of Y, YES, N, or NO depending on */
/*    whether you want the data set that is created to be sorted by DESYNPUF_ID. */
/*    Do not terminate the macro calls with semicolons.                          */
/*********************************************************************************/
%desynpuf_ip_readin(filenumber=1,sortds=no)
%desynpuf_ip_readin(filenumber=2,sortds=no)
%desynpuf_ip_readin(filenumber=3,sortds=no)
%desynpuf_ip_readin(filenumber=4,sortds=no)
%desynpuf_ip_readin(filenumber=5,sortds=no)
%desynpuf_ip_readin(filenumber=6,sortds=no)
%desynpuf_ip_readin(filenumber=7,sortds=no)
%desynpuf_ip_readin(filenumber=8,sortds=no)
%desynpuf_ip_readin(filenumber=9,sortds=no)
%desynpuf_ip_readin(filenumber=10,sortds=no)
%desynpuf_ip_readin(filenumber=11,sortds=no)
%desynpuf_ip_readin(filenumber=12,sortds=no)
%desynpuf_ip_readin(filenumber=13,sortds=no)
%desynpuf_ip_readin(filenumber=14,sortds=no)
%desynpuf_ip_readin(filenumber=15,sortds=no)
%desynpuf_ip_readin(filenumber=16,sortds=no)
%desynpuf_ip_readin(filenumber=17,sortds=no)
%desynpuf_ip_readin(filenumber=18,sortds=no)
%desynpuf_ip_readin(filenumber=19,sortds=no)
%desynpuf_ip_readin(filenumber=20,sortds=no)

/*********************************************************************************/
/* 6. OPTIONAL: Call macro program DESYNPUF_IP_COMBINE if you want to           */
/*    concatenate the data sets created above that have consecutively numbered   */
/*    suffixes. Both STARTNUMBER= and ENDNUMBER= values must be specified.       */
/*    ENDNUMBER= must be greater than or equal to STARTNUMBER=.                  */
/*      If you want to combine data sets that are not consecutively numbered, you*/
/*    will need to write a DATA step to concatenate them.                        */
/*********************************************************************************/
%desynpuf_ip_combine(startnumber=1,endnumber=20)

/*********************************************************************************/
/* END OF SECTION THAT SHOULD BE REVIEWED AND/OR MODIFIED                        */
/*********************************************************************************/

/*********************************************************************************/
/* Clear some of the settings this program has made.                             */
/*********************************************************************************/
filename inip clear;
libname desynpuf clear;

options validvarname=v7 nomprint;

%symdel infilepath infilename outdsname;
