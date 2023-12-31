USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Upd]
--
GO
PRINT (N'Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Upd]')
GO
CREATE OR ALTER PROCEDURE dbo.ASSIGNMENT_FUEL_Upd
@p_AS_ID VARCHAR(15) = NULL,
@p_FUEL_NAME NVARCHAR(60) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL

AS
DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM ASSIGNMENT_FUEL af WHERE af.AS_ID = @p_AS_ID AND af.FUEL_NAME = @p_FUEL_NAME))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END

  BEGIN TRANSACTION
  UPDATE ASSIGNMENT_FUEL SET [CONSUMPTION] = @p_CONSUMPTION
  WHERE AS_ID = @p_AS_ID AND FUEL_NAME = @p_FUEL_NAME
  IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_AS_ID AS_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' AS_ID
    RETURN '-1'
  END
GO

--
-- Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Search]
--
GO
PRINT (N'Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Search]')
GO
CREATE OR ALTER PROCEDURE dbo.ASSIGNMENT_FUEL_Search 
@p_TOP INT = 500,
@p_AS_ID VARCHAR(15) = NULL,
@p_FUEL_NAME NVARCHAR(60) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL

AS 
  BEGIN -- PAGING
    IF (@p_TOP IS NULL OR @p_TOP = '' OR @p_TOP = 0) -- PAGING BEGIN
      SELECT       
      af.*
      -- SELECT END
      FROM ASSIGNMENT_FUEL af
      WHERE 1 = 1 
      AND (af.AS_ID = @p_AS_ID OR @p_AS_ID IS NULL OR @p_AS_ID = '')
      AND (af.FUEL_NAME = @p_FUEL_NAME OR @p_FUEL_NAME IS NULL OR @p_FUEL_NAME = '')
      AND (af.CONSUMPTION = @p_CONSUMPTION OR @p_CONSUMPTION IS NULL OR @p_CONSUMPTION <= 0)
      -- PAGING END
    ELSE
      -- PAGING BEGIN 
      SELECT TOP (@p_TOP) 
      af.*
      -- SELECT END
      FROM ASSIGNMENT_FUEL af
      WHERE 1 = 1 
      AND (af.AS_ID = @p_AS_ID OR @p_AS_ID IS NULL OR @p_AS_ID = '')
      AND (af.FUEL_NAME = @p_FUEL_NAME OR @p_FUEL_NAME IS NULL OR @p_FUEL_NAME = '')
      AND (af.CONSUMPTION = @p_CONSUMPTION OR @p_CONSUMPTION IS NULL OR @p_CONSUMPTION <= 0)
      -- PAGING END
  END -- PAGING


GO

--
-- Create or alter procedure [dbo].[ASSIGNMENT_FUEL_INS]
--
GO
PRINT (N'Create or alter procedure [dbo].[ASSIGNMENT_FUEL_INS]')
GO
CREATE OR ALTER PROCEDURE dbo.ASSIGNMENT_FUEL_INS
@p_AS_ID VARCHAR(15) = NULL,
@p_FUEL_NAME NVARCHAR(60) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL,
@p_FUEL_ID NVARCHAR(20) = NULL


AS
BEGIN TRANSACTION
  INSERT INTO ASSIGNMENT_FUEL([AS_ID],[FUEL_NAME],[CONSUMPTION],[FUEL_ID])
  VALUES (@p_AS_ID,@p_FUEL_NAME, @p_CONSUMPTION,@p_FUEL_ID)
  IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_AS_ID AS_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' AS_ID
    RETURN '-1'
  END
GO

--
-- Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Del]
--
GO
PRINT (N'Create or alter procedure [dbo].[ASSIGNMENT_FUEL_Del]')
GO
CREATE OR ALTER PROCEDURE dbo.ASSIGNMENT_FUEL_Del
@p_AS_ID VARCHAR(15) = NULL,
@p_FUEL_NAME NVARCHAR(60) = NULL

AS

DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM ASSIGNMENT_FUEL af WHERE af.AS_ID = @p_AS_ID AND af.FUEL_NAME = @p_FUEL_NAME))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END

BEGIN TRANSACTION
  DELETE FROM ASSIGNMENT_FUEL WHERE AS_ID = @p_AS_ID AND FUEL_NAME = @p_FUEL_NAME
  IF @@Error <> 0 GOTO ABORT
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, @p_AS_ID AS_ID
  RETURN '0'

ABORT:
  BEGIN
    ROLLBACK TRANSACTION
    SELECT
      '-1' AS Result
     ,'' AS_ID
    RETURN '-1'
  END
GO