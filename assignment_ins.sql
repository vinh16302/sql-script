USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create procedure [dbo].[ASSIGNMENT_INS]
--
GO
PRINT (N'Create procedure [dbo].[ASSIGNMENT_INS]')
GO
CREATE PROCEDURE dbo.ASSIGNMENT_INS
@p_AS_ID NVARCHAR(20) = NULL,
@p_LOCATION NVARCHAR(200) = NULL,
@p_POSITION_ID NVARCHAR(15) = NULL,
@p_BROWSING_UNIT NVARCHAR(1) = NULL,
@p_CREATE_DATE VARCHAR(20) = NULL,
@p_FROM_DATE VARCHAR(20) = NULL,
@p_TO_DATE VARCHAR(20) = NULL,
@p_MISSION NVARCHAR(200) = NULL,
@p_MISSION_DETAIL NVARCHAR(200) = NULL,
@p_CAR_ID VARCHAR(15) = NULL,
@p_DRIVER_ID VARCHAR(15) = NULL,
@p_TIME_ARRIVE VARCHAR(20) = NULL,
@p_LOCATION_ARRIVE VARCHAR(15) = NULL,
@p_EMPLOYEE_ID VARCHAR(20) = NULL,
@p_RECORD_STATUS VARCHAR(1) = NULL,
@p_AUTH_STATUS VARCHAR(1) = NULL,
@p_MAKER_ID VARCHAR(15) = NULL,
@p_CREATE_DT VARCHAR(20) = NULL,
@p_CHECKER_ID VARCHAR(15) = NULL,
@p_APPROVE_DT VARCHAR(20) = NULL,
@p_APPROVER_ID VARCHAR(15) = NULL,
@p_BRANCH_ID VARCHAR(15) = NULL,
@p_MO_ID VARCHAR(15) = NULL,
@p_DEP_ID VARCHAR(15) = NULL


AS

  IF @p_CREATE_DATE IS NULL OR @p_CREATE_DATE = '' SET @p_CREATE_DATE = GETDATE()
  ELSE SET @p_CREATE_DATE = CONVERT(DATETIME, @p_CREATE_DATE, 103);
  SET @p_FROM_DATE = CONVERT(DATETIME, @p_FROM_DATE, 103)
  SET @p_TO_DATE = CONVERT(DATETIME, @p_TO_DATE, 103)
  SET @p_TIME_ARRIVE = CONVERT(DATETIME, @p_TIME_ARRIVE, 103)
  SET @p_CREATE_DT = CONVERT(DATETIME, @p_CREATE_DT, 103)
  SET @p_APPROVE_DT = CONVERT(DATETIME, @p_APPROVE_DT, 103)

  DECLARE  @p_INYEAR_ID INT = -1;
  IF (SELECT MAX(INYEAR_ID) FROM ASSIGNMENT WHERE YEAR(CREATE_DATE) = YEAR(@p_CREATE_DATE)) IS NOT NULL
  SET @p_INYEAR_ID =  (SELECT MAX(INYEAR_ID) FROM ASSIGNMENT WHERE YEAR(CREATE_DATE) = YEAR(@p_CREATE_DATE)) + 1;
  ELSE SET @p_INYEAR_ID = 0;


  BEGIN TRANSACTION
  INSERT INTO [ASSIGNMENT]([LOCATION],[POSITION_ID],[BROWSING_UNIT],[CREATE_DATE],[FROM_DATE],[TO_DATE],[MISSION],[MISSION_DETAIL],[CAR_ID],[DRIVER_ID],[TIME_ARRIVE],[LOCATION_ARRIVE],[EMPLOYEE_ID],[RECORD_STATUS],[AUTH_STATUS],[MAKER_ID],[CREATE_DT],[CHECKER_ID],[APPROVE_DT],[APPROVER_ID],[BRANCH_ID],[MO_ID],[DEP_ID],[INYEAR_ID]) 
  VALUES (@p_LOCATION,@p_POSITION_ID,@p_BROWSING_UNIT,@p_CREATE_DATE,@p_FROM_DATE,@p_TO_DATE,@p_MISSION,@p_MISSION_DETAIL,@p_CAR_ID,@p_DRIVER_ID,@p_TIME_ARRIVE,@p_LOCATION_ARRIVE,@p_EMPLOYEE_ID,@p_RECORD_STATUS,@p_AUTH_STATUS,@p_MAKER_ID,@p_CREATE_DT,@p_CHECKER_ID,@p_APPROVE_DT,@p_APPROVER_ID,@p_BRANCH_ID,@p_MO_ID,@p_DEP_ID,@p_INYEAR_ID)
  
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, IDENT_CURRENT('ASSIGNMENT') AS_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' ID
    RETURN '-1'
  END
GO