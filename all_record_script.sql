USE [siyenza_db]
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Olabode Ajayi>
-- Create date: <Create Date,,20201203>
-- Description:	<Description,,validate ID>
-- =============================================
/*

1. procedure takes in ID  @IDNumber
2. check if ID is 13 chars if not exit  (if len(@IDNumber) != 13)

Declare @Dateofbirth datetime
Declare @Gender int
Declare @Sequence vachar(3)
Declare @Citizenship int
Declare @RandomVal int
Declare @Control int

--- set the local variables

select  @Dateofbirth = cast(substring(@IDNumber,1,6) as date)
select  @Gender = substring(@IDNumber,7,1)
select  @Sequence
select  @Citizenship 
select  @RandomVal
select  @Control

---validation 

a) check if @Dateofbirth is a valid date, check that 


*/

GO

/****** Object:  StoredProcedure [dbo].[Id_Validation]    Script Date: 2020/12/03 2:22:49 AM ******/
/*DROP PROCEDURE [dbo].[Id_Validation]*/
GO

/****** Object:  StoredProcedure [dbo].[Id_Validation]    Script Date: 2020/12/03 2:22:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vIdValidationData]
	@Idnumber VARCHAR(13),
	@FirstName varchar(50),
	@Surname varchar(50),
	@DateOfBirth DATE,
	@Sequence VARCHAR(20),
	@Gender varchar(1),
	@Citizenship int,
	@RandomVal int,
	@Control int,
	@err_msg  NVARCHAR(1000) OUT

AS

	--   ___________________________________________________________________________
	-- / \                                                                          \
	--|   |            Stored Procedure: [dbo].[vIdValidationData]                   |
	-- \_ | ======================================================================== |
	--    | PURPOSE: List the client data associated with the date provided.         |
	--    |                                                                          |
	--    | USE: EXEC [dbo].[vIdValidationData]                                      |
	--    |          @@Idnumber = VARCHAR(13) [Required] :  Any valid id number      |
	--    |          @FirstName = VARCHAR(13) [Required] : Any valid firstname       |
	--    |          @FirstName = VARCHAR(13) [Required] : Any valid surname		 |
	--    |		     @DateOfBirth DATE,												 |
	--    |			 @FolderNumber VARCHAR(20),										 |
	--    |			 @Gender varchar(1),											 |
	--    |			 @Citizenship int,												 |
	--    |			 @RandomVal int,												 |	         
	--    |          @err_msg = NVARCHAR(1000) : Provides error messages             |
	--    |                                                                          |
	--    | AUTHOR: Ajayi Olabode                                                    |
	--    | CREATION DATE: 02 December 2020                                          |
	--    | UPDATED BY:                                                              |
	--    | LAST UPDATE DATE:                                                        |
	--    |   _______________________________________________________________________|___
	--    |  /                                                                          /
	--    \_/__________________________________________________________________________/



	-- SET @Idnumber = substring(@IDNumber,1,6)
	-- SET @FirstName = 'Olabode'
	-- SET @Surname = 'Ajayi'
	-- SET @DateOfBirth = substring(@IDNumber,1,6)
	-- SET @Sequence = substring(@IDNumber,8,3)
	-- SET @Gender = substring(@IDNumber,7,1) 
	-- SET @Citizenship =substring(@IDNumber,11,1) 
	-- SET @RandomVal =substring(@IDNumber,12,1) 
	-- SET @Control =substring(@IDNumber,13,1) 

	DECLARE @is_null_or_empty bit
	DECLARE @query VARCHAR(MAX) = ''
	DECLARE @table_name VARCHAR(MAX) = ''
	DECLARE @red_flag_filter VARCHAR(200) = ''

	-- VALIDATE: CHECK THAT PERIOD TYPE IS SET
	IF @Idnumber IS NULL 
	BEGIN
		SET @err_msg =  'Error: @Idnumber is a required variable.'
		SET  @is_null_or_empty = 0  --invalid input
		RAISERROR (@err_msg, 16, 1) 
		RETURN
	END

	-- TASK: SELECT THE CORRECT TABLE BASED ON THE ID NUMBER
	IF (@Idnumber IS NOT NULL) AND (LEN(LTRIM(@Idnumber)) = 13)  AND (ISNUMERIC(LTRIM(@Idnumber)) = 1)
	BEGIN
		SET @is_null_or_empty = 1 --valid input
		SET @table_name = '[siyenza_db].[dbo].[clientdataset]'
		SET @red_flag_filter = 'drd.[RedFlag]'
	END

	--Check the validity of the id
	IF (@is_null_or_empty = 1)
	BEGIN
		/*
		SET @Idnumber = substring(@IDNumber,1,6)
		SET @FirstName = 'Olabode'
		SET @Surname = 'Ajayi'
		SET @DateOfBirth = substring(@IDNumber,1,6)
		SET @Sequence = substring(@IDNumber,8,3)
		SET @Gender = substring(@IDNumber,7,1) 
		SET @Citizenship =substring(@IDNumber,11,1) 
		SET @RandomVal =substring(@IDNumber,12,1) 
		SET @Control =substring(@IDNumber,13,1) 
		*/

		select  @Dateofbirth =substring(@IDNumber,1,6) 
		select  @Gender =substring(@IDNumber,7,1) 
		select  @Sequence =substring(@IDNumber,8,3) 
		select  @Citizenship =substring(@IDNumber,11,1) 
		select  @RandomVal =substring(@IDNumber,12,1) 
		select  @Control =substring(@IDNumber,13,1) 
		
		select @Dateofbirth,@Gender,@Sequence,@Citizenship,@RandomVal,@Control
	

		/*
		WITH id_number_split(DateOfBirth,Gender, [Sequence], Citizenship,Usually,CalculatedControl) AS (
		SELECT CONVERT(date,SUBSTRING(@Idnumber, 1,6)),
		CASE
		WHEN SUBSTRING(@Idnumber, 7,1) >=0 AND SUBSTRING(@Idnumber, 7,1) <= 4
		THEN 'Female'
		ELSE 'Male' END
		  ,
		  SUBSTRING(@Idnumber, 8,3),
		  CASE
		  WHEN SUBSTRING(@Idnumber, 11,1) = 0
		  THEN 'South African'
		  ELSE 'Other'
		  END
		  ,
		  SUBSTRING(@Idnumber, 12,1),
		  SUBSTRING(@Idnumber, 13,1)
		)

		-- SELECT ALL THE VALUES OF 
		SET @query = '
				SELECT 
					drd.[Idnumber],
					drd.[FirstName],
					drd.[Surname],
					drd.[DateOfBirth],
					drd.[Sequence],
					drd.[Gender],
					drd.[Citizenship],
					drd.[RandomVal],
					drd.[Control]
				FROM 
					' + @table_name + ' drd'

		SELECT * FROM id_number_split;
		ELSE
		PRINT 'This is an invalid input'
		*/
   
	END

GO
 