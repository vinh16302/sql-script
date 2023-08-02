USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[TRIP_Upd]
--
GO
PRINT (N'Create or alter procedure [dbo].[TRIP_Upd]')
GO
 CREATE OR ALTER PROCEDURE dbo.TRIP_Upd @p_TOP INT = 500,
@p_AS_ID NVARCHAR(20) = NULL,
@p_TYPE VARCHAR(1) = NULL,
@p_QUANTITY DECIMAL(18,2) = NULL,
@p_QUANTITY_UNIT NVARCHAR(20) = NULL,
@p_QUANTITY_TRIP int = NULL,
@p_GO_FROM NVARCHAR(200) = NULL,
@p_GO_TO NVARCHAR(200) = NULL,
@p_TIME VARCHAR(20) = NULL,
@p_LENGTH DECIMAL(18,2) = NULL,
@p_LENGTH_UNIT NVARCHAR(20) = NULL 

AS
DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM TRIP t WHERE t.AS_ID= @p_AS_ID AND t.TYPE = @p_TYPE))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END
  BEGIN TRANSACTION
  UPDATE TRIP
  SET [QUANTITY] = @p_QUANTITY,[QUANTITY_UNIT] = @p_QUANTITY_UNIT,[QUANTITY_TRIP] =@p_QUANTITY_TRIP,[GO_FROM] = @p_GO_FROM,[GO_TO]= @p_GO_TO,[TIME] = @p_TIME,[LENGTH] = @p_LENGTH,[LENGTH_UNIT] = @p_LENGTH_UNIT
  WHERE AS_ID = @p_AS_ID AND TYPE = @p_TYPE  
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