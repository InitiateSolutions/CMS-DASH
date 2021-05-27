/********************************************************************************************************************
  AUTHOR            :  Murali H
  CREATED           :  05/26/2021
  NAME              :  02-DASH_TC1_BENEFICIARY_TableCreationScripts V1.0.sql
  PURPOSE           :  The purpose of this script is to create reference tables for CMS DASH Technical Challenge.
  PREREQUISITE      :  Execute 01-DASH_TC1_REFERENCE_TableCreationScripts V1.0.sql before executing this file.
  REVISIONS:
  Ver        Date         Author           		Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        05/26/2021  Murali H            Created the scripts.
********************************************************************************************************************/

CREATE TABLE DASH_BENEFICIARY
(
	BENE_SID             NUMBER(30) NOT NULL ,
	BENE_IDNTFR          VARCHAR2(20) NOT NULL ,
	BIRTH_DATE           DATE NULL ,
	RACE_CODE            VARCHAR2(20) NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_BENEFICIARY IS 'This table stores the master list of beneficiaries in the system.';

COMMENT ON COLUMN DASH_BENEFICIARY.BENE_SID IS 'This field stores the key to identify a unique beneficiary record';

COMMENT ON COLUMN DASH_BENEFICIARY.BENE_IDNTFR IS 'DESYNPUF: Beneficiary Code';

COMMENT ON COLUMN DASH_BENEFICIARY.BIRTH_DATE IS 'DESYNPUF: Date of birth';

COMMENT ON COLUMN DASH_BENEFICIARY.RACE_CODE IS 'DESYNPUF: Beneficiary Race Code';

COMMENT ON COLUMN DASH_BENEFICIARY.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_BENEFICIARY.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_BENEFICIARY.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_BENEFICIARY.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_BENEFICIARY.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_BENEFICIARY.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_BENEFICIARY
	ADD CONSTRAINT  XPKBENEFICIARY PRIMARY KEY (BENE_SID);

CREATE TABLE DASH_BENEFICIARY_DTL
(
	BENE_DTL_SID         NUMBER(30) NOT NULL ,
	BENE_SID             NUMBER(30) NOT NULL ,
	DEATH_DATE           DATE NULL ,
	SEX_CODE             VARCHAR2(20) NULL ,
	STATE_CODE           VARCHAR2(20) NULL ,
	COUNTY_CODE          VARCHAR2(20) NULL ,
	START_DATE           DATE NOT NULL ,
	END_DATE             DATE NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_BENEFICIARY_DTL IS 'This table stores the details of beneficiaries in the system.';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.BENE_DTL_SID IS 'This field stores the key to identify a unique beneficiary detail record';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.BENE_SID IS 'This field stores the key to identify a unique beneficiary record';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.DEATH_DATE IS 'DESYNPUF: Date of death';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.SEX_CODE IS 'DESYNPUF: Sex';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.STATE_CODE IS 'DESYNPUF: State Code';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.COUNTY_CODE IS 'DESYNPUF: County Code';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.START_DATE IS 'The start date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.END_DATE IS 'The end date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_BENEFICIARY_DTL.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_BENEFICIARY_DTL
	ADD CONSTRAINT  XPKBENEFICIARY_DTL PRIMARY KEY (BENE_DTL_SID);

CREATE INDEX XIF1BENEFICIARY_DTL ON DASH_BENEFICIARY_DTL
(BENE_SID   ASC);

CREATE TABLE DASH_BENE_X_AMT
(
	BENE_X_AMT_SID       NUMBER(30) NOT NULL ,
	BENE_SID             NUMBER(30) NOT NULL ,
	AMT_TYPE_CID         NUMBER(30) NOT NULL ,
	AMT_VALUE            NUMBER(30) NOT NULL ,
	START_DATE           DATE NOT NULL ,
	END_DATE             DATE NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_BENE_X_AMT IS 'This table stores the list of amounts associated with a beneficiary.';

COMMENT ON COLUMN DASH_BENE_X_AMT.BENE_X_AMT_SID IS 'This field stores the key to identify a unique beneficiary amount record';

COMMENT ON COLUMN DASH_BENE_X_AMT.BENE_SID IS 'This field stores the key to identify a unique beneficiary record';

COMMENT ON COLUMN DASH_BENE_X_AMT.AMT_TYPE_CID IS 'This field stores the key to identify a unique Amount type';

COMMENT ON COLUMN DASH_BENE_X_AMT.AMT_VALUE IS 'This field stores the amount value associated with the various amount types';

COMMENT ON COLUMN DASH_BENE_X_AMT.START_DATE IS 'The start date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_AMT.END_DATE IS 'The end date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_AMT.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_BENE_X_AMT.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_BENE_X_AMT.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_BENE_X_AMT.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_BENE_X_AMT.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_BENE_X_AMT.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_BENE_X_AMT
	ADD CONSTRAINT  XPKBENE_X_AMT PRIMARY KEY (BENE_X_AMT_SID);

CREATE INDEX XIF1BENE_X_AMT ON DASH_BENE_X_AMT
(BENE_SID   ASC);

CREATE INDEX XIF2BENE_X_AMT ON DASH_BENE_X_AMT
(AMT_TYPE_CID   ASC);

CREATE TABLE DASH_BENE_X_SPCLTY
(
	BENE_X_SPCLTY_SID    NUMBER(30) NOT NULL ,
	BENE_SID             NUMBER(30) NOT NULL ,
	SPCLTY_TYPE_CID      NUMBER(30) NOT NULL ,
	SPCLTY_IND           NUMBER(1) NOT NULL ,
	START_DATE           DATE NOT NULL ,
	END_DATE             DATE NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_BENE_X_SPCLTY IS 'This table stores the list of specialties associated with a beneficiary.';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.BENE_X_SPCLTY_SID IS 'This field stores the key to identify a unique beneficiary specialty record';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.BENE_SID IS 'This field stores the key to identify a unique beneficiary record';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.SPCLTY_TYPE_CID IS 'This field stores the key to identify a unique Specialty type';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.SPCLTY_IND IS 'This field indicates if there a chronic condition specialty for this beneficiary';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.START_DATE IS 'The start date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.END_DATE IS 'The end date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_BENE_X_SPCLTY.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_BENE_X_SPCLTY
	ADD CONSTRAINT  XPKBENE_X_SPCLTY PRIMARY KEY (BENE_X_SPCLTY_SID);

CREATE INDEX XIF1BENE_X_SPCLTY ON DASH_BENE_X_SPCLTY
(BENE_SID   ASC);

CREATE INDEX XIF2BENE_X_SPCLTY ON DASH_BENE_X_SPCLTY
(SPCLTY_TYPE_CID   ASC);

CREATE TABLE DASH_BENE_X_CVRG
(
	BENE_X_CVRG_SID      NUMBER(30) NOT NULL ,
	BENE_SID             NUMBER(30) NOT NULL ,
	CVRG_TYPE_CID        NUMBER(30) NOT NULL ,
	MNTH_CNT             NUMBER(30) NOT NULL ,
	START_DATE           DATE NOT NULL ,
	END_DATE             DATE NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_BENE_X_CVRG IS 'This table stores the list of coverages associated with a beneficiary.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.BENE_X_CVRG_SID IS 'This field stores the key to identify a unique beneficiary coverage record';

COMMENT ON COLUMN DASH_BENE_X_CVRG.BENE_SID IS 'This field stores the key to identify a unique beneficiary record';

COMMENT ON COLUMN DASH_BENE_X_CVRG.CVRG_TYPE_CID IS 'This field stores the key to identify a unique Coverage type';

COMMENT ON COLUMN DASH_BENE_X_CVRG.MNTH_CNT IS 'DESYNPUF: Total number of months of a coverage type for the
beneficiary.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.START_DATE IS 'The start date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_CVRG.END_DATE IS 'The end date of the date range in which the record is valid';

COMMENT ON COLUMN DASH_BENE_X_CVRG.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_BENE_X_CVRG.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_BENE_X_CVRG.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_BENE_X_CVRG
	ADD CONSTRAINT  XPKBENE_X_CVRG PRIMARY KEY (BENE_X_CVRG_SID);

CREATE INDEX XIF1BENE_X_CVRG ON DASH_BENE_X_CVRG
(BENE_SID   ASC);

CREATE INDEX XIF2BENE_X_CVRG ON DASH_BENE_X_CVRG
(CVRG_TYPE_CID   ASC);

ALTER TABLE DASH_BENEFICIARY_DTL
	ADD (CONSTRAINT XFK1_BENEFICIARY_DTL FOREIGN KEY (BENE_SID) REFERENCES DASH_BENEFICIARY (BENE_SID));

ALTER TABLE DASH_BENE_X_AMT
	ADD (CONSTRAINT XFK1_BENE_X_AMT FOREIGN KEY (BENE_SID) REFERENCES DASH_BENEFICIARY (BENE_SID));

ALTER TABLE DASH_BENE_X_AMT
	ADD (CONSTRAINT XFK2_BENE_X_AMT FOREIGN KEY (AMT_TYPE_CID) REFERENCES DASH_AMOUNT_TYPE (AMT_TYPE_CID));

ALTER TABLE DASH_BENE_X_SPCLTY
	ADD (CONSTRAINT XFK1_BENE_X_SPCLTY FOREIGN KEY (BENE_SID) REFERENCES DASH_BENEFICIARY (BENE_SID));

ALTER TABLE DASH_BENE_X_SPCLTY
	ADD (CONSTRAINT XFK2_BENE_X_SPCLTY FOREIGN KEY (SPCLTY_TYPE_CID) REFERENCES DASH_SPECIALTY_TYPE (SPCLTY_TYPE_CID));

ALTER TABLE DASH_BENE_X_CVRG
	ADD (CONSTRAINT XFK1_BENE_X_CVRG FOREIGN KEY (BENE_SID) REFERENCES DASH_BENEFICIARY (BENE_SID));

ALTER TABLE DASH_BENE_X_CVRG
	ADD (CONSTRAINT XFK2_BENE_X_CVRG FOREIGN KEY (CVRG_TYPE_CID) REFERENCES DASH_COVERAGE_TYPE (CVRG_TYPE_CID));
