USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER ON
GO

--
-- Create table [dbo].[ASSIGNMENT]
--
PRINT (N'Create table [dbo].[ASSIGNMENT]')
GO
CREATE TABLE dbo.ASSIGNMENT (
  AS_ID int IDENTITY,
  LOCATION nvarchar(200) NULL,
  POSITION_ID varchar(15) NULL,
  BROWSING_UNIT nvarchar(1) NULL,
  CREATE_DATE datetime NULL,
  FROM_DATE datetime NULL,
  TO_DATE datetime NULL,
  MISSION nvarchar(200) NULL,
  MISSION_DETAIL nvarchar(200) NULL,
  CAR_ID varchar(15) NULL,
  DRIVER_ID varchar(15) NULL,
  TIME_ARRIVE datetime NULL,
  LOCATION_ARRIVE nvarchar(200) NULL,
  EMPLOYEE_ID varchar(15) NULL,
  RECORD_STATUS varchar(1) NULL,
  AUTH_STATUS varchar(1) NULL,
  MAKER_ID varchar(15) NULL,
  CREATE_DT datetime NULL,
  CHECKER_ID varchar(15) NULL,
  APPROVE_DT datetime NULL,
  APPROVER_ID varchar(15) NULL,
  BRANCH_ID varchar(15) NULL,
  MO_ID varchar(15) NULL,
  DEP_ID varchar(15) NULL,
  INYEAR_ID int NOT NULL,
  DisplayedID AS ((right('0000'+CONVERT([varchar](4),[INYEAR_ID]),(4))+'-')+CONVERT([varchar](4),datepart(year,[CREATE_DATE]))) PERSISTED,
  PRIMARY KEY CLUSTERED (AS_ID),
  UNIQUE (DisplayedID)
)
ON [PRIMARY]
GO