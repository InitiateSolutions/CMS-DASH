/*
--Drop order. Use if needed.

DROP TABLE DASH_PROVIDER_DRUG_UTLZTN CASCADE CONSTRAINTS PURGE;

DROP TABLE DASH_DRUG CASCADE CONSTRAINTS PURGE;

DROP TABLE DASH_SPECIALTY CASCADE CONSTRAINTS PURGE;

DROP TABLE DASH_CITY CASCADE CONSTRAINTS PURGE;

DROP TABLE DASH_STATE CASCADE CONSTRAINTS PURGE;

DROP TABLE DASH_PROVIDER CASCADE CONSTRAINTS PURGE;
*/

CREATE TABLE DASH_CITY
(
	CITY_SID             NUMBER(30) NOT NULL ,
	CITY_NAME            VARCHAR2(100) NOT NULL ,
	STATE_SID            NUMBER(30) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_CITY IS 'This table stores the master list of cities.';

COMMENT ON COLUMN DASH_CITY.CITY_SID IS 'This field stores the key to identify a unique city.';

COMMENT ON COLUMN DASH_CITY.CITY_NAME IS 'This field stores the name of the city.';

COMMENT ON COLUMN DASH_CITY.STATE_SID IS 'This field stores the key to identify a unique state.';

COMMENT ON COLUMN DASH_CITY.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_CITY.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_CITY.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_CITY.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_CITY.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_CITY.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_CITY
	ADD CONSTRAINT  XPKDASH_CITY PRIMARY KEY (CITY_SID);

CREATE INDEX XIF1DASH_CITY ON DASH_CITY
(STATE_SID   ASC);

CREATE TABLE DASH_DRUG
(
	DRUG_SID             NUMBER(30) NOT NULL ,
	DRUG_CODE            VARCHAR2(50) NULL ,
	DRUG_LABEL_NAME      VARCHAR2(100) NOT NULL ,
	DRUG_GENERIC_NAME    VARCHAR2(100) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_DRUG IS 'This table stores the master list of drugs.';

COMMENT ON COLUMN DASH_DRUG.DRUG_SID IS 'This field stores the key to identify a unique drug.';

COMMENT ON COLUMN DASH_DRUG.DRUG_CODE IS 'This field stores the National Drug Code(NDC) that uniquely identifies a drug.';

COMMENT ON COLUMN DASH_DRUG.DRUG_LABEL_NAME IS 'This field stores the name of the drug displayed in the label.';

COMMENT ON COLUMN DASH_DRUG.DRUG_GENERIC_NAME IS 'This field stores the generic name of the drug.';

COMMENT ON COLUMN DASH_DRUG.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_DRUG.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_DRUG.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_DRUG.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_DRUG.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_DRUG.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_DRUG
	ADD CONSTRAINT  XPKDASH_DRUG PRIMARY KEY (DRUG_SID);

CREATE TABLE DASH_PROVIDER
(
	PROVIDER_SID         NUMBER(30) NOT NULL ,
	NPI                  VARCHAR2(100) NOT NULL ,
	LAST_ORG_NAME        VARCHAR2(100) NOT NULL ,
	FIRST_NAME           VARCHAR2(100) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_PROVIDER IS 'This table stores the master list of providers.';

COMMENT ON COLUMN DASH_PROVIDER.PROVIDER_SID IS 'This field stores the key to identify a unique provider record.';

COMMENT ON COLUMN DASH_PROVIDER.NPI IS 'This field stores the national provider identifier assigned to the provider.';

COMMENT ON COLUMN DASH_PROVIDER.LAST_ORG_NAME IS 'This field stores the last name of an individual provider or official name of an organizational provider.';

COMMENT ON COLUMN DASH_PROVIDER.FIRST_NAME IS 'This field stores the first name of an individual provider.';

COMMENT ON COLUMN DASH_PROVIDER.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_PROVIDER.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_PROVIDER.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_PROVIDER.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_PROVIDER.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_PROVIDER.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_PROVIDER
	ADD CONSTRAINT  XPKDASH_PROVIDER PRIMARY KEY (PROVIDER_SID);

CREATE TABLE DASH_SPECIALTY
(
	SPECIALTY_SID        NUMBER(30) NOT NULL ,
	SPECIALTY_CODE       VARCHAR2(50) NULL ,
	SPECIALTY_NAME       VARCHAR2(100) NOT NULL ,
	SPECIALTY_DESC       VARCHAR2(4000) NULL ,
	SPECIALTY_DESC_FLAG  CHAR(1) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_SPECIALTY IS 'This table stores the master list of specialties.';

COMMENT ON COLUMN DASH_SPECIALTY.SPECIALTY_SID IS 'This field stores the key to identify a unique specialty.';

COMMENT ON COLUMN DASH_SPECIALTY.SPECIALTY_CODE IS 'This field stores the code that represents a specialty.';

COMMENT ON COLUMN DASH_SPECIALTY.SPECIALTY_NAME IS 'This field stores the name of the specialty.';

COMMENT ON COLUMN DASH_SPECIALTY.SPECIALTY_DESC IS 'This field stores the description of the specialty.';

COMMENT ON COLUMN DASH_SPECIALTY.SPECIALTY_DESC_FLAG IS 'This field stores the specialty description flag.';

COMMENT ON COLUMN DASH_SPECIALTY.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_SPECIALTY.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_SPECIALTY.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_SPECIALTY.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_SPECIALTY.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_SPECIALTY.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_SPECIALTY
	ADD CONSTRAINT  XPKDASH_SPECIALTY PRIMARY KEY (SPECIALTY_SID);

CREATE TABLE DASH_STATE
(
	STATE_SID            NUMBER(30) NOT NULL ,
	STATE_CODE           VARCHAR2(50) NOT NULL ,
	STATE_NAME           VARCHAR2(100) NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_STATE IS 'This table stores the master list of states.';

COMMENT ON COLUMN DASH_STATE.STATE_SID IS 'This field stores the key to identify a unique state.';

COMMENT ON COLUMN DASH_STATE.STATE_CODE IS 'This field stores the code that represents a state.';

COMMENT ON COLUMN DASH_STATE.STATE_NAME IS 'This field stores the name of the state.';

COMMENT ON COLUMN DASH_STATE.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_STATE.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_STATE.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_STATE.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_STATE.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_STATE.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_STATE
	ADD CONSTRAINT  XPKDASH_STATE PRIMARY KEY (STATE_SID);

CREATE TABLE DASH_PROVIDER_DRUG_UTLZTN
(
	PROVIDER_DRUG_UTLZTN_SID NUMBER(30) NOT NULL ,
	PROVIDER_SID         NUMBER(30) NOT NULL ,
	STATE_SID            NUMBER(30) NOT NULL ,
	CITY_SID             NUMBER(30) NOT NULL ,
	SPECIALTY_SID        NUMBER(30) NOT NULL ,
	DRUG_SID             NUMBER(30) NOT NULL ,
	GE65_BNFCRY_COUNT_SPRSS_FLAG CHAR(1) NULL ,
	GE65_ALL_COUNT_SPRSS_FLAG CHAR(1) NULL ,
	BNFCRY_COUNT         NUMBER(30) NOT NULL ,
	TOTAL_CLAIM_COUNT    NUMBER(30) NOT NULL ,
	TOTAL_30_DAY_FILL_COUNT NUMBER(30) NOT NULL ,
	TOTAL_DAY_SUPPLY_COUNT NUMBER(30) NOT NULL ,
	TOTAL_DRUG_COST      NUMBER(20,2) NOT NULL ,
	GE65_BNFCRY_COUNT    NUMBER(30) NOT NULL ,
	GE65_TOTAL_CLAIM_COUNT NUMBER(30) NOT NULL ,
	GE65_TOTAL_30_DAY_FILL_COUNT NUMBER(30) NOT NULL ,
	GE65_TOTAL_DAY_SUPPLY_COUNT NUMBER(30) NOT NULL ,
	GE65_TOTAL_DRUG_COST NUMBER(20,2) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(50) NOT NULL ,
	CREATED_BY           NUMBER(30) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          NUMBER(30) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_PROVIDER_DRUG_UTLZTN IS 'This table stores the drug quantities and costs aggregated for various dimensions.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.PROVIDER_DRUG_UTLZTN_SID IS 'This field stores the key to identify a unique drug utilization record.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.PROVIDER_SID IS 'This field stores the key to identify a unique provider record.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.CITY_SID IS 'This field stores the key to identify a unique city.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.SPECIALTY_SID IS 'This field stores the key to identify a unique specialty.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.DRUG_SID IS 'This field stores the key to identify a unique drug.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_BNFCRY_COUNT_SPRSS_FLAG IS 'This field stores the flag to indicate if beneficiary count needs to be suppressed for beneficiaries who are 65 years or older. Following logic is applied for the measures based on this flag:
# - GE65_BNFCRY_COUNT is suppressed
* - GE65_BNFCRY_COUNT and BNFCRY_COUNT are suppressed
NULL - GE65_BNFCRY_COUNT and BNFCRY_COUNT are populated.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_ALL_COUNT_SPRSS_FLAG IS 'This field stores the flag to indicate if all measures applicable for beneficiaries who are 65 years or older need to be suppressed. Following logic is applied for the measures based on this flag:
# - All GE65 summary columns are suppressed
* - All GE65 summary columns and BNFCRY_COUNT are suppressed
NULL - GE65 summary columns and BNFCRY_COUNT are populated.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.BNFCRY_COUNT IS 'This field stores the total number of beneficiaries.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.TOTAL_CLAIM_COUNT IS 'This field stores the total number of claims.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.TOTAL_30_DAY_FILL_COUNT IS 'This field stores the total number of units of the drug to be filled for 30 days.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.TOTAL_DAY_SUPPLY_COUNT IS 'This field stores the number of days worht of drug supply available.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.TOTAL_DRUG_COST IS 'This field stores the total cost of the drugs available.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_BNFCRY_COUNT IS 'This field stores the total number of beneficiaries who are 65 years or older.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_TOTAL_CLAIM_COUNT IS 'This field stores the total number of claims for beneficiaries who are 65 years or older.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_TOTAL_30_DAY_FILL_COUNT IS 'This field stores the total number of units of the drug to be filled for 30 days for beneficiaries who are 65 years or older.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_TOTAL_DAY_SUPPLY_COUNT IS 'This field stores the number of days worht of drug supply available for beneficiaries who are 65 years or older.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.GE65_TOTAL_DRUG_COST IS 'This field stores the total cost of the drugs available for beneficiaries who are 65 years or older.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

COMMENT ON COLUMN DASH_PROVIDER_DRUG_UTLZTN.STATE_SID IS 'This field stores the key to identify a unique state.';

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD CONSTRAINT  XPKDASH_PROVIDER_DRUG_UTLZTN PRIMARY KEY (PROVIDER_DRUG_UTLZTN_SID);

CREATE INDEX XIF1DASH_PROVIDER_DRUG_UTLZTN ON DASH_PROVIDER_DRUG_UTLZTN
(PROVIDER_SID   ASC);

CREATE INDEX XIF2DASH_PROVIDER_DRUG_UTLZTN ON DASH_PROVIDER_DRUG_UTLZTN
(STATE_SID   ASC);

CREATE INDEX XIF3DASH_PROVIDER_DRUG_UTLZTN ON DASH_PROVIDER_DRUG_UTLZTN
(CITY_SID   ASC);

CREATE INDEX XIF4DASH_PROVIDER_DRUG_UTLZTN ON DASH_PROVIDER_DRUG_UTLZTN
(SPECIALTY_SID   ASC);

CREATE INDEX XIF5DASH_PROVIDER_DRUG_UTLZTN ON DASH_PROVIDER_DRUG_UTLZTN
(DRUG_SID   ASC);

ALTER TABLE DASH_CITY
	ADD (CONSTRAINT XFK1_DASH_CITY FOREIGN KEY (STATE_SID) REFERENCES DASH_STATE (STATE_SID));

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD (CONSTRAINT XFK1_DASH_PROVIDER_DRUG_UTLZTN FOREIGN KEY (PROVIDER_SID) REFERENCES DASH_PROVIDER (PROVIDER_SID));

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD (CONSTRAINT XFK2_DASH_PROVIDER_DRUG_UTLZTN FOREIGN KEY (STATE_SID) REFERENCES DASH_STATE (STATE_SID));

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD (CONSTRAINT XFK3_DASH_PROVIDER_DRUG_UTLZTN FOREIGN KEY (CITY_SID) REFERENCES DASH_CITY (CITY_SID));

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD (CONSTRAINT XFK4_DASH_PROVIDER_DRUG_UTLZTN FOREIGN KEY (SPECIALTY_SID) REFERENCES DASH_SPECIALTY (SPECIALTY_SID));

ALTER TABLE DASH_PROVIDER_DRUG_UTLZTN
	ADD (CONSTRAINT XFK5_DASH_PROVIDER_DRUG_UTLZTN FOREIGN KEY (DRUG_SID) REFERENCES DASH_DRUG (DRUG_SID));
