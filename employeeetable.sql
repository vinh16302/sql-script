USE gAMSCloud_DEMO_04
GO

IF DB_NAME() <> N'gAMSCloud_DEMO_04' SET NOEXEC ON
GO

SET QUOTED_IDENTIFIER ON
GO

--
-- Create table [dbo].[EMPLOYEEE]
--
PRINT (N'Create table [dbo].[EMPLOYEEE]')
GO
CREATE TABLE dbo.EMPLOYEEE (
  ID int IDENTITY,
  NAME nvarchar(160) NULL,
  PHONE varchar(20) NULL,
  POSITION nvarchar(30) NULL,
  RANK nvarchar(30) NULL,
  DEP_ID nvarchar(20) NULL,
  DisplayedID AS ('NV'+right('0000'+CONVERT([varchar](4),[ID]),(4))) PERSISTED NOT NULL,
  PRIMARY KEY CLUSTERED (ID)
)
ON [PRIMARY]
GO