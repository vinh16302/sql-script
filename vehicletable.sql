--
-- Drop table [dbo].[VEHICLE]
--
PRINT (N'Drop table [dbo].[VEHICLE]')
GO
DROP TABLE dbo.VEHICLE
GO

--
-- Create table [dbo].[VEHICLE]
--
PRINT (N'Create table [dbo].[VEHICLE]')
GO
CREATE TABLE dbo.VEHICLE (
  CAR_ID varchar(20) NOT NULL,
  CAR_TYPE_ID nvarchar(200) NULL,
  NAME nvarchar(200) NULL,
  OG_COUNTRY nvarchar(200) NULL,
  BRAND nvarchar(200) NULL,
  MANAGING_UNIT nvarchar(200) NULL,
  FUEL nvarchar(200) NULL,
  CONSUMPTION decimal(18, 2) NULL,
  PRIMARY KEY CLUSTERED (CAR_ID)
)
ON [PRIMARY]
GO