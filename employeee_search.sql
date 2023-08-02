USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--
-- Create or alter procedure [dbo].[EMPLOYEEE_Search]
--
GO
PRINT (N'Create or alter procedure [dbo].[EMPLOYEEE_Search]')
GO
CREATE OR ALTER PROCEDURE dbo.EMPLOYEEE_Search @p_TOP INT = 500,
@p_ID NVARCHAR(20) = NULL,
@p_NAME NVARCHAR(160) = NULL,
@p_PHONE VARCHAR(20) = NULL,
@p_POSITION NVARCHAR(30) = NULL,
@p_RANK NVARCHAR(30) = NULL,
@p_DEP_ID NVARCHAR(20) = NULL,
@p_DISPLAYEDID VARCHAR(6) = NULL

AS
  BEGIN -- PAGING
    IF (@p_TOP IS NULL OR @p_TOP = '' OR @p_TOP = 0) -- PAGING BEGIN
      SELECT e.*, cd.DEP_NAME
      -- SELECT END
      FROM EMPLOYEEE e
      LEFT JOIN CM_DEPARTMENT cd ON e.DEP_ID = cd.DEP_ID
      WHERE 1 = 1 
      AND (e.NAME LIKE N'%' + @p_NAME + '%' OR @p_NAME IS NULL OR @p_NAME = '')
      AND (e.PHONE LIKE N'%' + @p_PHONE + '%' OR @p_PHONE IS NULL OR @p_PHONE = '')
      AND (e.POSITION LIKE N'%' + @p_POSITION + '%' OR @p_POSITION IS NULL OR @p_POSITION = '')
      AND (e.RANK LIKE N'%' + @p_RANK + '%' OR @p_RANK IS NULL OR @p_RANK = '')
      AND (e.DEP_ID LIKE N'%' + @p_DEP_ID + '%' OR @p_DEP_ID IS NULL OR @p_DEP_ID = '')
      AND (e.DisplayedID LIKE N'%' + @p_DISPLAYEDID + '%' OR @p_DISPLAYEDID IS NULL OR @p_DISPLAYEDID = '')
      -- PAGING END
    ELSE
      -- PAGING BEGIN 
      SELECT TOP (@p_TOP) e.* , cd.DEP_NAME
      -- SELECT END
      FROM EMPLOYEEE e
      LEFT JOIN CM_DEPARTMENT cd ON e.DEP_ID = cd.DEP_ID
      WHERE 1 = 1 
      AND (e.NAME LIKE N'%' + @p_NAME + '%' OR @p_NAME IS NULL OR @p_NAME = '')
      AND (e.PHONE LIKE N'%' + @p_PHONE + '%' OR @p_PHONE IS NULL OR @p_PHONE = '')
      AND (e.POSITION LIKE N'%' + @p_POSITION + '%' OR @p_POSITION IS NULL OR @p_POSITION = '')
      AND (e.RANK LIKE N'%' + @p_RANK + '%' OR @p_RANK IS NULL OR @p_RANK = '')
      AND (e.DEP_ID LIKE N'%' + @p_DEP_ID + '%' OR @p_DEP_ID IS NULL OR @p_DEP_ID = '')
      AND (e.DisplayedID LIKE N'%' + @p_DISPLAYEDID + '%' OR @p_DISPLAYEDID IS NULL OR @p_DISPLAYEDID = '')
      -- PAGING END
  END -- PAGING
GO