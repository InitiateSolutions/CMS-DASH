/********************************************************************************************************************
  AUTHOR            :  Murali H
  CREATED           :  05/26/2021
  NAME              :  01-DASH_TC1_REFERENCE_TableCreationScripts V1.0.sql
  PURPOSE           :  The purpose of this script is to create reference tables for CMS DASH Technical Challenge.
  PREREQUISITE      :  <Assumptions / pre-requisites if any>
  REVISIONS:
  Ver        Date         Author           		Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        05/26/2021  Murali H            Created the scripts.
********************************************************************************************************************/

CREATE TABLE DASH_AMOUNT_TYPE
(
	AMT_TYPE_CID         NUMBER(30) NOT NULL ,
	AMT_TYPE_CODE        VARCHAR2(20) NOT NULL ,
	AMT_TYPE_NAME        VARCHAR2(200) NOT NULL ,
	AMT_TYPE_DESC        VARCHAR2(4000) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_AMOUNT_TYPE IS 'This table stores the list of amount types used in the system.';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.AMT_TYPE_CID IS 'This field stores the key to identify a unique Amount type';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.AMT_TYPE_CODE IS 'This field stores the various Amount type codes obtained from the field name in the PUF user manual';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.AMT_TYPE_NAME IS 'This field stores the various Amount type names based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.AMT_TYPE_DESC IS 'This field stores the various Amount type descriptions based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_AMOUNT_TYPE.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_AMOUNT_TYPE
	ADD CONSTRAINT  XPKAMOUNT_TYPE PRIMARY KEY (AMT_TYPE_CID);

CREATE TABLE DASH_COVERAGE_TYPE
(
	CVRG_TYPE_CID        NUMBER(30) NOT NULL ,
	CVRG_TYPE_CODE       VARCHAR2(20) NOT NULL ,
	CVRG_TYPE_NAME       VARCHAR2(200) NOT NULL ,
	CVRG_TYPE_DESC       VARCHAR2(4000) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_COVERAGE_TYPE IS 'This table stores the list of coverage types used in the system.';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CVRG_TYPE_CID IS 'This field stores the key to identify a unique Coverage type';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CVRG_TYPE_CODE IS 'This field stores the various Coverage type codes obtained from the field name in the PUF user manual';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CVRG_TYPE_NAME IS 'This field stores the various Coverage type names based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CVRG_TYPE_DESC IS 'This field stores the various Coverage type descriptions based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_COVERAGE_TYPE.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_COVERAGE_TYPE
	ADD CONSTRAINT  XPKCOVERAGE_TYPE PRIMARY KEY (CVRG_TYPE_CID);

CREATE TABLE DASH_SPECIALTY_TYPE
(
	SPCLTY_TYPE_CID      NUMBER(30) NOT NULL ,
	SPCLTY_TYPE_CODE     VARCHAR2(20) NOT NULL ,
	SPCLTY_TYPE_NAME     VARCHAR2(200) NOT NULL ,
	SPCLTY_TYPE_DESC     VARCHAR2(4000) NOT NULL ,
	DATA_SOURCE_LKPCD    VARCHAR2(20) NULL ,
	OPRTNL_FLAG          CHAR(1) NOT NULL ,
	CREATED_BY           VARCHAR2(100) NOT NULL ,
	CREATED_DATE         DATE NOT NULL ,
	MODIFIED_BY          VARCHAR2(100) NOT NULL ,
	MODIFIED_DATE        DATE NOT NULL 
);

COMMENT ON TABLE DASH_SPECIALTY_TYPE IS 'This table stores the list of specialty types used in the system.';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.SPCLTY_TYPE_CID IS 'This field stores the key to identify a unique Specialty type';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.SPCLTY_TYPE_CODE IS 'This field stores the various Specialty type codes obtained from the field name in the PUF user manual';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.SPCLTY_TYPE_NAME IS 'This field stores the various Specialty type names based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.SPCLTY_TYPE_DESC IS 'This field stores the various Specialty type descriptions based on the description obtained from the PUF user manual';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.OPRTNL_FLAG IS 'This field stores a flag that indicates the system status of the record. Valid values are A = Active (Currently in use), I = Inactive (Temporarily made inactive), D = Soft Delete (Record marked as delete), or R = Ready for Purge (Record marked as ready for purge).';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.DATA_SOURCE_LKPCD IS 'This field stores the lookup code that identifies a source of the record.';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.CREATED_BY IS 'This field stores the unique system identifier of the user who created the record.';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.CREATED_DATE IS 'This field stores the date and time when the record was created.';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.MODIFIED_BY IS 'This field stores the unique system identifier of the user who modified the record.';

COMMENT ON COLUMN DASH_SPECIALTY_TYPE.MODIFIED_DATE IS 'This field stores the date and time when the record was modified.';

ALTER TABLE DASH_SPECIALTY_TYPE
	ADD CONSTRAINT  XPKSPECIALTY_TYPE PRIMARY KEY (SPCLTY_TYPE_CID);
