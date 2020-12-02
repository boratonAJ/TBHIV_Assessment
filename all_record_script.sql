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

use siyenza_db;

DROP Table IF EXISTS siyenza_db.clientdataset;

CREATE TABLE `clientdataset` (
  `Idnumber` varchar(13) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `Surname` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `FolderNumber` varchar(20) DEFAULT NULL,
  `Gender` enum('Male','Female') DEFAULT NULL,
  `RecordNumber` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`RecordNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;



declare @IDNumber varchar(13), @isValid bit

set @IDNumber = '9008115811190'
set @isValid = 0 

If  (len(@IDNumber) = 13) and (ISNUMERIC(@IDNumber) = 1)
begin
    
	Declare @Dateofbirth varchar(6)
	Declare @Gender varchar(1)
	Declare @Sequence varchar(3)
	Declare @Citizenship varchar(1) --bit
	Declare @RandomVal varchar(1)
	Declare @Control varchar(1)

	select  @Dateofbirth =substring(@IDNumber,1,6) 
	select  @Gender =substring(@IDNumber,7,1) 
	select  @Sequence =substring(@IDNumber,8,3) 
	select  @Citizenship =substring(@IDNumber,11,1) 
	select  @RandomVal =substring(@IDNumber,12,1) 
	select  @Control =substring(@IDNumber,13,1) 



	select @Dateofbirth,@Gender,@Sequence,@Citizenship,@RandomVal,@Control

	--if @Dateofbirth is correct
	--begin
	-- set @isValid = 1
	--end



	select @isValid 
end

/*
CREATE PROCEDURE dbo.Id_Validation
AS
DECLARE @id_number CHAR(13) = '9210050668080',
@is_null_or_empty bit

BEGIN

IF (@id_number IS NOT NULL) AND (LEN(LTRIM(@id_number)) = 13)  AND (ISNUMERIC(LTRIM(@id_number)) = 1)
SELECT @is_null_or_empty = 1 --valid input
ELSE
SELECT  @is_null_or_empty = 0  --invalid input

--Check the validity of the id
IF (@is_null_or_empty = 1)
WITH id_number_split(DOB,Gender, [Sequence], Citizenship,Usually,CalculatedControl) AS (
SELECT CONVERT(date,SUBSTRING(@id_number, 1,6)),
CASE
WHEN SUBSTRING(@id_number, 7,1) >=0 AND SUBSTRING(@id_number, 7,1) <= 4
THEN 'Female'
ELSE 'Male' END
  ,
  SUBSTRING(@id_number, 8,3),
  CASE
  WHEN SUBSTRING(@id_number, 11,1) = 0
  THEN 'South African'
  ELSE 'Other'
  END
  ,
  SUBSTRING(@id_number, 12,1),
  SUBSTRING(@id_number, 13,1)
)
SELECT * FROM id_number_split;
ELSE
PRINT 'This is an invalid input'
   
END
GO




*/ 