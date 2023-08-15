USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[VEHICLE_Upd]
--
GO
PRINT (N'Create or alter procedure [dbo].[VEHICLE_Upd]')
GO
CREATE OR ALTER PROCEDURE dbo.VEHICLE_Upd
@p_CAR_ID VARCHAR(20) = NULL,
@p_CAR_TYPE_ID NVARCHAR(200) = NULL,
@p_NAME NVARCHAR(200) = NULL,
@p_OG_COUNTRY NVARCHAR(200) = NULL,
@p_BRAND NVARCHAR(200) = NULL,
@p_MANAGING_UNIT NVARCHAR(200) = NULL,
@p_FUEL NVARCHAR(200) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL,
@p_FUEL_ID NVARCHAR(20) = NULL,
@p_DRIVER_ID NVARCHAR(30) = NULL

AS

DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM VEHICLE v WHERE v.CAR_ID = @p_CAR_ID))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END

  BEGIN TRANSACTION
  UPDATE VEHICLE SET [CAR_TYPE_ID] = @p_CAR_TYPE_ID,[NAME] = @p_NAME,[OG_COUNTRY] = @p_OG_COUNTRY,[BRAND] = @p_BRAND,[MANAGING_UNIT] = @p_MANAGING_UNIT,[FUEL] = @p_FUEL,[CONSUMPTION] = @p_CONSUMPTION, [FUEL_ID] = @p_FUEL_ID, [DRIVER_ID] = @p_DRIVER_ID
  WHERE CAR_ID = @p_CAR_ID
 IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_CAR_ID CAR_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' CAR_ID
    RETURN '-1'
  END
GO

--
-- Create or alter procedure [dbo].[VEHICLE_Search]
--
GO
PRINT (N'Create or alter procedure [dbo].[VEHICLE_Search]')
GO
CREATE OR ALTER PROCEDURE dbo.VEHICLE_Search @p_TOP INT = 500,
@p_CAR_ID VARCHAR(20) = NULL,
@p_CAR_TYPE_ID NVARCHAR(200) = NULL,
@p_NAME NVARCHAR(200) = NULL,
@p_OG_COUNTRY NVARCHAR(200) = NULL,
@p_BRAND NVARCHAR(200) = NULL,
@p_MANAGING_UNIT NVARCHAR(200) = NULL,
@p_FUEL NVARCHAR(200) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL,
@p_USER_ID NVARCHAR(30) = NULL

AS
  BEGIN -- PAGING
    IF (@p_TOP IS NULL OR @p_TOP = '' OR @p_TOP = 0) -- PAGING BEGIN
      SELECT       
      v.*,
      ct.CAR_TYPE_NAME,
      cd.DEP_NAME,
      e.NAME AS 'DRIVER_NAME'
      -- SELECT END
      FROM VEHICLE v
      LEFT JOIN CM_DEPARTMENT cd ON cd.DEP_ID = v.MANAGING_UNIT
      LEFT JOIN CAR_TYPE ct ON v.CAR_TYPE_ID = ct.CAR_TYPE_ID
      LEFT JOIN USER_EMPLOYEE ue ON v.DRIVER_ID = ue.EMPLOYEE_ID
      LEFT JOIN EMPLOYEEE e ON v.DRIVER_ID = e.DisplayedID
      WHERE 1 = 1 
      AND (v.CAR_ID = @p_CAR_ID OR @p_CAR_ID IS NULL OR @p_CAR_ID = '')
      AND (v.CAR_TYPE_ID = @p_CAR_TYPE_ID OR @p_CAR_TYPE_ID IS NULL OR @p_CAR_TYPE_ID = '')
      AND (v.NAME = @p_NAME OR @p_NAME IS NULL OR @p_NAME = '')
      AND (v.OG_COUNTRY = @p_OG_COUNTRY OR @p_OG_COUNTRY IS NULL OR @p_OG_COUNTRY = '')
      AND (v.BRAND = @p_BRAND OR @p_BRAND IS NULL OR @p_BRAND = '')
      AND (v.MANAGING_UNIT = @p_MANAGING_UNIT OR @p_MANAGING_UNIT IS NULL OR @p_MANAGING_UNIT = '')
      AND (EXISTS(SELECT * FROM USER_EMPLOYEE ue1 WHERE ue1.USER_ID = @p_USER_ID AND ue1.EMPLOYEE_ID = 'admin') OR (ue.USER_ID = @p_USER_ID OR @p_USER_ID IS NULL OR @p_USER_ID = ''))
      -- PAGING END
    ELSE
      -- PAGING BEGIN 
      SELECT TOP (@p_TOP) 
      v.*,
      ct.CAR_TYPE_NAME,
      cd.DEP_NAME,
      e.NAME AS 'DRIVER_NAME'
      -- SELECT END
      FROM VEHICLE v
      LEFT JOIN CM_DEPARTMENT cd ON cd.DEP_ID = v.MANAGING_UNIT
      LEFT JOIN CAR_TYPE ct ON v.CAR_TYPE_ID = ct.CAR_TYPE_ID
      LEFT JOIN USER_EMPLOYEE ue ON v.DRIVER_ID = ue.EMPLOYEE_ID
      LEFT JOIN EMPLOYEEE e ON v.DRIVER_ID = e.DisplayedID
      WHERE 1 = 1 
      AND (v.CAR_ID = @p_CAR_ID OR @p_CAR_ID IS NULL OR @p_CAR_ID = '')
      AND (v.CAR_TYPE_ID = @p_CAR_TYPE_ID OR @p_CAR_TYPE_ID IS NULL OR @p_CAR_TYPE_ID = '')
      AND (v.NAME = @p_NAME OR @p_NAME IS NULL OR @p_NAME = '')
      AND (v.OG_COUNTRY = @p_OG_COUNTRY OR @p_OG_COUNTRY IS NULL OR @p_OG_COUNTRY = '')
      AND (v.BRAND = @p_BRAND OR @p_BRAND IS NULL OR @p_BRAND = '')
      AND (v.MANAGING_UNIT = @p_MANAGING_UNIT OR @p_MANAGING_UNIT IS NULL OR @p_MANAGING_UNIT = '')
      AND (EXISTS(SELECT * FROM USER_EMPLOYEE ue1 WHERE ue1.USER_ID = @p_USER_ID AND ue1.EMPLOYEE_ID = 'admin') OR (ue.USER_ID = @p_USER_ID OR @p_USER_ID IS NULL OR @p_USER_ID = ''))
      -- PAGING END
  END -- PAGING
GO

--
-- Create or alter procedure [dbo].[VEHICLE_INS]
--
GO
PRINT (N'Create or alter procedure [dbo].[VEHICLE_INS]')
GO
CREATE OR ALTER PROCEDURE dbo.VEHICLE_INS 
@p_CAR_ID VARCHAR(20) = NULL,
@p_CAR_TYPE_ID NVARCHAR(200) = NULL,
@p_NAME NVARCHAR(200) = NULL,
@p_OG_COUNTRY NVARCHAR(200) = NULL,
@p_BRAND NVARCHAR(200) = NULL,
@p_MANAGING_UNIT NVARCHAR(200) = NULL,
@p_FUEL NVARCHAR(200) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL,
@p_FUEL_ID NVARCHAR(20) = NULL,
@p_DRIVER_ID NVARCHAR(30) = NULL

AS
BEGIN TRANSACTION
  INSERT INTO VEHICLE([CAR_ID],[CAR_TYPE_ID],[NAME],[OG_COUNTRY],[BRAND],[MANAGING_UNIT],[FUEL],[CONSUMPTION], [FUEL_ID], [DRIVER_ID])
  VALUES (@p_CAR_ID, @p_CAR_TYPE_ID, @p_NAME, @p_OG_COUNTRY, @p_BRAND, @p_MANAGING_UNIT, @p_FUEL, @p_CONSUMPTION, @p_FUEL_ID, @p_DRIVER_ID)
IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_CAR_ID CAR_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' CAR_ID
    RETURN '-1'
  END
GO

--
-- Create or alter procedure [dbo].[VEHICLE_Del]
--
GO
PRINT (N'Create or alter procedure [dbo].[VEHICLE_Del]')
GO
CREATE OR ALTER PROCEDURE dbo.VEHICLE_Del
@p_CAR_ID VARCHAR(20) = NULL

AS

DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM VEHICLE v WHERE v.CAR_ID = @p_CAR_ID))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END

  BEGIN TRANSACTION
  DELETE FROM VEHICLE WHERE CAR_ID = @p_CAR_ID
 IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_CAR_ID CAR_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' CAR_ID
    RETURN '-1'
  END
GO