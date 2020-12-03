USE [siyenza_db]
GO

/****** Object:  Table [dbo].[clientdataset]    Script Date: 2020/12/03 1:36:09 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clientdataset]') AND type in (N'U'))
DROP TABLE [dbo].[clientdataset]
GO

/****** Object:  Table [dbo].[clientdataset]   Script Date: 2020/12/03 1:36:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[clientdataset](
	[Idnumber] varchar(13) DEFAULT NULL,
	[FirstName] varchar(50) DEFAULT NULL,
	[Surname] varchar(50) DEFAULT NULL,
	[DateOfBirth] date DEFAULT NULL,
    [FolderNumber] varchar(20) DEFAULT NULL,
	[Gender] [varchar](1) NULL,
    [RecordNumber] INT PRIMARY KEY IDENTITY (1, 1) 
	)ON [PRIMARY]
GO

ALTER TABLE [dbo].[clientdataset]
        WITH CHECK ADD  CONSTRAINT [CK_CustomerGender]
                CHECK  (([Gender]='U' OR [Gender]='F' OR [Gender]='M'))
GO




 