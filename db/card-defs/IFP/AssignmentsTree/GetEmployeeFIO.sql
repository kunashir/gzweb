begin

return @LastName 
+ ' ' + CASE WHEN @FirstName IS NULL THEN '' ELSE LEFT(@FirstName,1) + '.' END 
+ CASE WHEN @MiddleName IS NULL THEN '' ELSE LEFT(@MiddleName,1) + '.' END

end

/*

test

select [dbo].[GetEmployeeFIO]('FirstName', 'MiddleName', 'LastName')
select [dbo].[GetEmployeeFIO]('FirstName', '', 'LastName')
select [dbo].[GetEmployeeFIO]('FirstName', null, 'LastName')

*/


