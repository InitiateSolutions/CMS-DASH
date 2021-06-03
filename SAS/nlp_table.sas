**********************************************************************************
Generate random NLP scores across NPIs from sample of 99 scores 
Courtney Stowers - TMF Health Quality Institute
May 28, 2021
**********************************************************************************;

/* Load sample data from table stored in DASH library that was imported from CSV, 
create column of NPIs in character format*/
DATA NLP_SAMPLE;
set DASH.NLP_SAMPLE;
AT_PHYSN_NPI_2 = put(AT_PHYSN_NPI, 30.);
run;

/* Replace numeric AT_PHYSN_NPI field with character format NPIs */
data NLP_SAMPLE(drop=AT_PHYSN_NPI_2);
set NLP_SAMPLE(drop=AT_PHYSN_NPI);
AT_PHYSN_NPI = AT_PHYSN_NPI_2;
run;

/* Find distribution of NLP scores: 0 (47.47), 1 (35.35), 2 (17.17) */
proc freq data=NLP_SAMPLE;
table label;
run;

/* Load SYNPUF inpatient claim file from DASH library */
data DASH_CLAIM_INPATIENT;
set DASH.DASH_CLAIM_INPATIENT;
run;

/* Check that AT_PHYSN_NPI is a character field*/
proc contents data=DASH_CLAIM_INPATIENT;
proc contents data=NLP_SAMPLE;


/* Select remaining NPIs from SNYPUF inpatient claim file 
that are not already in the NPI score sample table */
proc sql;
create table NLP_SAMPLE_2 as
SELECT AT_PHYSN_NPI
FROM DASH_CLAIM_INPATIENT
WHERE AT_PHYSN_NPI NOT IN
    (SELECT AT_PHYSN_NPI
     FROM NLP_SAMPLE);
quit;

/* Combine tables  */
data NLP_SAMPLE_3;
set NLP_SAMPLE NLP_SAMPLE_2;
run;

/* Select distinct NPIs */

proc sql;
create table NLP_SAMPLE_4 as
select distinct *
from NLP_SAMPLE_3
where AT_PHYSN_NPI ne " ";
quit;

/* Create random NPI scores based on sample data distribution */

data NLP_SAMPLE_5(drop=i p1 p2 p3);
set NLP_SAMPLE_4;
call streaminit(4321);
array p[3] (0.354, 0.172, 0.474); /* probabilities */
do i = 1;
type = rand("Table", of p[*]); /* random function */
output;
end;
run;

/* Combine all scores into the label column,
recode 3 (calculated at .474 probability in previous step) to 0 */

data NLP_SAMPLE_6(drop=type);
set NLP_SAMPLE_5;
if label =. then label = type;
if label = 3 then label = 0;
run;


/* Check frequency of tables to ensure the distribution from original remains */

proc freq data=NLP_SAMPLE_6; 
table label;
run;

proc freq data=nlp_sample;
table label;
run;

/* Create provider_rating column where 0 & 2 = Positive/Neutral and 1 = Negative,
recode scores to binary 0 = Negative and 1 = Positive/Neutral nlp_recode variable */

data NLP_SAMPLE_7;
length provider_rating $180;
set NLP_SAMPLE_6;
if label = 1 then provider_rating = "Negative";
if label = 2 then provider_rating = "Positive/Neutral";
if label = 0 then provider_rating = "Positive/Neutral";
if provider_rating = "Negative" then NLP_recode = 0;
if provider_rating = "Positive/Neutral" then NLP_recode = 1;
run;

/* Check frequency of provider_rating in final table*/

proc freq data=NLP_SAMPLE_7;
table label provider_rating;
run;

/* Drop final table if previously saved, save final table to DASH library */

proc sql;
DROP TABLE DASH.NLP_SCORE_TABLE_DASH;
quit;

data DASH.NLP_SCORE_TABLE_DASH;
length AT_PHYSN_NPI $180;
set NLP_SAMPLE_7;
run;