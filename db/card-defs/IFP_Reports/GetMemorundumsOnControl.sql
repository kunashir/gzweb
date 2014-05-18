-------------------------------------------------------------------------------
-- dvreport_get_data_{6DB9A3F2-B672-4F85-AC17-07927B8CA08F}
-------------------------------------------------------------------------------

BEGIN

	declare @currentDate datetime
	set @currentDate = GETDATE()

	select 
	mainInfo.InstanceID,
				
	-- описание в виде (От %дата регистрации%\n%Рег. номер%\n%имя файла[1..n]%	  
   'От ' + convert(varchar, mainInfo.RegistrationDate, 104) + Char(10) + mainInfo.RegistrationNumber + Char(10) + ' ' +
   + IsNULL((select distinct [FileName] 
   + Char(10) as 'data()' 
	from [dbo].[dvtable_{E962AC85-0F53-4439-A1CD-171E46C3EF91}] filelists 
	inner join [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] files on filelists.CardFileID = files.InstanceID 
	WHERE mainInfo.FilesID = filelists.InstanceID
	for xml path('')), '') as [Description],

	-- "доп. инфа" сотрудников, указанных в "Кому"
    '' + (select Comments + '; ' as 'data()' 
	from [dbo].[dvtable_{11FFD2EB-A6E5-4303-A0F4-DE23813C7B5C}] toWhom 
	inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] employees on toWhom.ToWhomPerson = employees.RowID
	where toWhom.InstanceID = mainInfo.InstanceID 
	for xml path('')) as UnitPerformer,

	convert(nvarchar(500), mainInfo.Content) as Content,
	
	convert(varchar, DATEADD(day, 30, mainInfo.RegistrationDate), 104) as ControlDate,

	(CASE 
		WHEN @currentDate > DATEADD(day, 30, mainInfo.RegistrationDate) 
		THEN DATEDIFF(day, DATEADD(day, 30, mainInfo.RegistrationDate), @currentDate) 
		ELSE 0 END) as OverdueDuration

	from [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as mainInfo
	where mainInfo.RegistrationDate >= @regDateStart AND 
		  mainInfo.RegistrationDate <= @regDateEnd AND
		  mainInfo.ControlState = 1 AND 
		  mainInfo.RegistrationDate is not null AND
		  mainInfo.RegistrationNumber is not null AND
	      (@signedByPerson = '00000000-0000-0000-0000-000000000000' OR @signedByPerson = mainInfo.SignedBy) AND
	      (@copyToPerson = '00000000-0000-0000-0000-000000000000' OR
			EXISTS(select * from [dvtable_{54925928-17B1-4F56-8D6F-C14541B65AB1}] copyTo 
				   where copyTo.InstanceID = mainInfo.InstanceID AND copyTo.CopyToPerson = @copyToPerson))
			
END

--GO --test
--
--exec [dvreport_get_data_{6DB9A3F2-B672-4F85-AC17-07927B8CA08F}]
--'2000-01-01',
--'2020-01-01',
--'00000000-0000-0000-0000-000000000000',
--'00000000-0000-0000-0000-000000000000'