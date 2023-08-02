--
-- Drop table [dbo].[TRIP]
--
PRINT (N'Drop table [dbo].[TRIP]')
GO
DROP TABLE dbo.TRIP
GO

--
-- Create table [dbo].[TRIP]
--
PRINT (N'Create table [dbo].[TRIP]')
GO
CREATE TABLE dbo.TRIP (
  AS_ID varchar(15) NOT NULL,
  TYPE varchar(1) NOT NULL,
  QUANTITY decimal(18, 2) NULL,
  QUANTITY_UNIT nvarchar(20) NULL,
  QUANTITY_TRIP int NULL,
  GO_FROM nvarchar(200) NULL,
  GO_TO nvarchar(200) NULL,
  TIME datetime NULL,
  LENGTH decimal(18, 2) NULL,
  LENGTH_UNIT nvarchar(20) NULL,
  PRIMARY KEY CLUSTERED (AS_ID, TYPE)
)
ON [PRIMARY]
GO