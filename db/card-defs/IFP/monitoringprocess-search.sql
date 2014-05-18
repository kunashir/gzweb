CREATE PROCEDURE [dbo].[dvreport_get_data_{F3143A87-9CA8-4297-84A6-9F48988497D3}]
AS
BEGIN

  SELECT DISTINCT
	     process_maininfo.InstanceID
  FROM   [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] process_function,
         [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] process_maininfo
  WHERE  process_function.Caption = '1. Поиск'
         AND process_function.ID = '{93BB5165-E441-4AA3-9FF4-2E345A1D1918}'
         AND process_maininfo.InstanceID = process_function.InstanceID
         AND process_maininfo.State = 1
  FOR BROWSE
END