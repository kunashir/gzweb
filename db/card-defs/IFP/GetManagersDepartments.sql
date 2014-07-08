-- Список подразделений, в которых руководителем назначено данное лицо
BEGIN
SELECT Name, RowID FROM [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] WHERE Manager = @managerID AND RowID is not null
END
