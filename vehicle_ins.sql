USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[VEHICLE_INS]
--
GO
PRINT (N'Create or alter procedure [dbo].[VEHICLE_INS]')
GO
CREATE OR ALTER PROCEDURE dbo.VEHICLE_INS 
@p_CAR_ID VARCHAR(20) = NULL,
@p_TYPE NVARCHAR(200) = NULL,
@p_NAME NVARCHAR(200) = NULL,
@p_OG_COUNTRY NVARCHAR(200) = NULL,
@p_BRAND NVARCHAR(200) = NULL,
@p_MANAGING_UNIT NVARCHAR(200) = NULL,
@p_FUEL NVARCHAR(200) = NULL,
@p_CONSUMPTION DECIMAL(18,2) = NULL

AS
BEGIN TRANSACTION
  INSERT INTO VEHICLE([CAR_ID],[TYPE],[NAME],[OG_COUNTRY],[BRAND],[MANAGING_UNIT],[FUEL],[CONSUMPTION])
  VALUES (@p_CAR_ID, @p_TYPE, @p_NAME, @p_OG_COUNTRY, @p_BRAND, @p_MANAGING_UNIT, @p_FUEL, @p_CONSUMPTION)
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