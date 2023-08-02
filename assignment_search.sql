USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[ASSIGNMENT_Search]
--
GO
PRINT (N'Create or alter procedure [dbo].[ASSIGNMENT_Search]')
GO
CREATE OR ALTER PROCEDURE dbo.ASSIGNMENT_Search @p_TOP INT = 500,
@p_BROWSING_UNIT NVARCHAR(10) = NULL,
@p_MISSION NVARCHAR(200) = NULL,
@p_CAR_ID VARCHAR(15) = NULL,
@p_CAR_NAME NVARCHAR(60) = NULL,
@p_DRIVER_ID VARCHAR(15) = NULL,
@p_TIME_ARRIVE VARCHAR(20) = NULL,
@p_LOCATION_ARRIVE VARCHAR(15) = NULL,
@p_EMPLOYEE_ID VARCHAR(20) = NULL,
@p_AUTH_STATUS VARCHAR(1) = NULL,
@p_DISPLAYEDID VARCHAR(9) = NULL,
@p_CREATE_FROM VARCHAR(20) = NULL,
@p_CREATE_TO VARCHAR(20) = NULL,
@p_SEARCH_TYPE VARCHAR(1) = 'A',
@p_DEP_ID VARCHAR(15) = NULL


AS
  BEGIN -- PAGING
    IF (@p_TOP IS NULL OR @p_TOP = '' OR @p_TOP = 0) -- PAGING BEGIN
      SELECT a.DisplayedID,
      a.CREATE_DATE,
      v.NAME AS 'CAR_NAME',
      a.CAR_ID,
      v.FUEL,
      cd.DEP_NAME,
      T.GO_FROM,
      T.GO_TO,
      a.MISSION,
      T.GO_TIME,
      T.BACK_TIME,
      e.NAME AS 'DRIVER_NAME',
      IIF(a.AUTH_STATUS = '1',N'�� duy?t',IIF(a.AUTH_STATUS = '0',N'Ch? duy?t',NULL)) AS AUTH_STATUS
      -- SELECT END
      FROM ASSIGNMENT a
      LEFT JOIN VEHICLE v ON a.CAR_ID = v.CAR_ID
      LEFT JOIN CM_DEPARTMENT cd ON a.DEP_ID = cd.DEP_ID
      LEFT JOIN (SELECT T1.GO_TIME, T2.BACK_TIME, T1.GO_FROM, T1.GO_TO, T1.AS_ID
                FROM (SELECT TIME AS 'GO_TIME', AS_ID, GO_FROM, GO_TO FROM TRIP WHERE TYPE = '0') T1
                LEFT JOIN (SELECT TIME AS 'BACK_TIME', AS_ID FROM TRIP WHERE TYPE = '1') T2 ON T1.AS_ID = T2.AS_ID) T ON a.DisplayedID = T.AS_ID
      LEFT JOIN EMPLOYEEE e ON a.DRIVER_ID = e.DisplayedID
      WHERE 1 = 1
      AND (a.BROWSING_UNIT LIKE N'%' + @p_BROWSING_UNIT + N'%' OR @p_BROWSING_UNIT IS NULL OR @p_BROWSING_UNIT = '')
      AND (DATEDIFF(DAY,a.CREATE_DATE, CONVERT(DATETIME,@p_CREATE_FROM,103)) <= 0 OR @p_CREATE_FROM IS NULL OR @p_CREATE_FROM = '')
      AND (DATEDIFF(DAY,a.CREATE_DATE, CONVERT(DATETIME,@p_CREATE_TO,103)) >= 0 OR @p_CREATE_TO IS NULL OR @p_CREATE_TO = '')
      AND (a.MISSION LIKE N'%' + @p_MISSION + N'%' OR @p_MISSION IS NULL OR @p_MISSION = '')
      AND (a.CAR_ID LIKE N'%' + @p_CAR_ID + N'%' OR @p_CAR_ID IS NULL OR @p_CAR_ID = '')
      AND (a.DRIVER_ID LIKE N'%' + @p_DRIVER_ID + N'%' OR @p_DRIVER_ID IS NULL OR @p_DRIVER_ID = '')
      AND (a.LOCATION_ARRIVE LIKE N'%' + @p_LOCATION_ARRIVE + N'%' OR @p_LOCATION_ARRIVE IS NULL OR @p_LOCATION_ARRIVE = '')
      AND (a.EMPLOYEE_ID LIKE N'%' + @p_EMPLOYEE_ID + N'%' OR @p_EMPLOYEE_ID IS NULL OR @p_EMPLOYEE_ID = '')
      AND (a.AUTH_STATUS LIKE N'%' + @p_AUTH_STATUS + N'%' OR @p_AUTH_STATUS IS NULL OR @p_AUTH_STATUS = '')
      AND (a.DISPLAYEDID LIKE N'%' + @p_DISPLAYEDID + N'%' OR @p_DISPLAYEDID IS NULL OR @p_DISPLAYEDID = '')
      -- PAGING END
    ELSE
      -- PAGING BEGIN 
      SELECT TOP (@p_TOP) a.DisplayedID,
      a.CREATE_DATE,
      v.NAME AS 'CAR_NAME',
      a.CAR_ID,
      v.FUEL,
      cd.DEP_NAME,
      T.GO_FROM,
      T.GO_TO,
      a.MISSION,
      T.GO_TIME,
      T.BACK_TIME,
      e.NAME AS 'DRIVER_NAME',
      IIF(a.AUTH_STATUS = '1',N'�� duy?t',IIF(a.AUTH_STATUS = '0',N'Ch? duy?t',NULL)) AS AUTH_STATUS
      -- SELECT END
      FROM ASSIGNMENT a
      LEFT JOIN VEHICLE v ON a.CAR_ID = v.CAR_ID
      LEFT JOIN CM_DEPARTMENT cd ON a.DEP_ID = cd.DEP_ID
      LEFT JOIN (SELECT T1.GO_TIME, T2.BACK_TIME, T1.GO_FROM, T1.GO_TO, T1.AS_ID
                FROM (SELECT TIME AS 'GO_TIME', AS_ID, GO_FROM, GO_TO FROM TRIP WHERE TYPE = '0') T1
                LEFT JOIN (SELECT TIME AS 'BACK_TIME', AS_ID FROM TRIP WHERE TYPE = '1') T2 ON T1.AS_ID = T2.AS_ID) T ON a.DisplayedID = T.AS_ID
      LEFT JOIN EMPLOYEEE e ON a.DRIVER_ID = e.DisplayedID
      WHERE 1 = 1
      AND (a.BROWSING_UNIT LIKE N'%' + @p_BROWSING_UNIT + N'%' OR @p_BROWSING_UNIT IS NULL OR @p_BROWSING_UNIT = '')
      AND (DATEDIFF(DAY,a.CREATE_DATE, CONVERT(DATETIME,@p_CREATE_FROM,103)) <= 0 OR @p_CREATE_FROM IS NULL OR @p_CREATE_FROM = '')
      AND (DATEDIFF(DAY,a.CREATE_DATE, CONVERT(DATETIME,@p_CREATE_TO,103)) >= 0 OR @p_CREATE_TO IS NULL OR @p_CREATE_TO = '')
      AND (a.MISSION LIKE N'%' + @p_MISSION + N'%' OR @p_MISSION IS NULL OR @p_MISSION = '')
      AND (a.CAR_ID LIKE N'%' + @p_CAR_ID + N'%' OR @p_CAR_ID IS NULL OR @p_CAR_ID = '')
      AND (a.DRIVER_ID LIKE N'%' + @p_DRIVER_ID + N'%' OR @p_DRIVER_ID IS NULL OR @p_DRIVER_ID = '')
      AND (a.LOCATION_ARRIVE LIKE N'%' + @p_LOCATION_ARRIVE + N'%' OR @p_LOCATION_ARRIVE IS NULL OR @p_LOCATION_ARRIVE = '')
      AND (a.EMPLOYEE_ID LIKE N'%' + @p_EMPLOYEE_ID + N'%' OR @p_EMPLOYEE_ID IS NULL OR @p_EMPLOYEE_ID = '')
      AND (a.AUTH_STATUS LIKE N'%' + @p_AUTH_STATUS + N'%' OR @p_AUTH_STATUS IS NULL OR @p_AUTH_STATUS = '')
      AND (a.DISPLAYEDID LIKE N'%' + @p_DISPLAYEDID + N'%' OR @p_DISPLAYEDID IS NULL OR @p_DISPLAYEDID = '')
      -- PAGING END
  END -- PAGING
  --endregion
GO