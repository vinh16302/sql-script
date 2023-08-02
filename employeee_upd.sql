USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create procedure [dbo].[EMPLOYEEE_Upd]
--
GO
PRINT (N'Create procedure [dbo].[EMPLOYEEE_Upd]')
GO
CREATE PROCEDURE dbo.EMPLOYEEE_Upd
@p_NAME NVARCHAR(200) = NULL,
@p_PHONE NVARCHAR(15) = NULL,
@p_POSITION NVARCHAR(1) = NULL,
@p_RANK VARCHAR(20) = NULL,
@p_DEP_ID VARCHAR(20) = NULL,
@p_DISPLAYEDID NVARCHAR(20) = NULL

AS

DECLARE @ERRORSYS NVARCHAR(15) = ''
IF (NOT EXISTS (SELECT * FROM EMPLOYEEE e WHERE DisplayedID = @p_DISPLAYEDID))
  SET @ERRORSYS = 'NOT FOUND'

IF @ERRORSYS <> ''
BEGIN
	SELECT ErrorCode Result, ErrorDesc ErrorDesc FROM SYS_ERROR WHERE ErrorCode = @ERRORSYS
  RETURN '0'
END

  BEGIN TRANSACTION
  UPDATE EMPLOYEEE SET [NAME]=@p_NAME, [PHONE]=@p_PHONE,[POSITION]=@p_POSITION,[RANK]=@p_RANK,[DEP_ID] =@p_DEP_ID
  WHERE DisplayedID = @p_DISPLAYEDID
  
  COMMIT TRANSACTION

  SELECT
  '0' AS RESULT, IDENT_CURRENT('EMPLOYEEE') ID
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