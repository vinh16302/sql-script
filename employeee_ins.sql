USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create procedure [dbo].[EMPLOYEEE_INS]
--
GO
PRINT (N'Create procedure [dbo].[EMPLOYEEE_INS]')
GO
CREATE PROCEDURE dbo.EMPLOYEEE_INS
@p_NAME NVARCHAR(200) = NULL,
@p_PHONE NVARCHAR(15) = NULL,
@p_POSITION NVARCHAR(1) = NULL,
@p_RANK VARCHAR(20) = NULL,
@p_DEP_ID VARCHAR(20) = NULL

AS

  BEGIN TRANSACTION
  INSERT INTO [EMPLOYEEE]([NAME],[PHONE],[POSITION],[RANK],[DEP_ID]) 
  VALUES (@p_NAME,@p_PHONE,@p_POSITION,@p_RANK,@p_DEP_ID)
  
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