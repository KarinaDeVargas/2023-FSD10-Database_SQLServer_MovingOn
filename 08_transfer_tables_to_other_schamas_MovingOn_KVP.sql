/* Purpose: Transfering tables from one schema to another in database MovingOn_KVP
Script Date: August 16, 2023
Developed by: Karina De Vargas Pereira
*/
																					  
/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the MovingOn_KVP database
-- Syntax: use database_name
use MovingOn_KVP
;
go

/* Syntax to transfer a table from one schema to another
alter schema to_schema_name TRANSFER from_schema_name.table_name
*/


/***** Table No. 1 - Sales.Customers *****/	 
/***** Table No. 2 - Sales.JobOrders *****/	 
/***** Table No. 3 - Sales.JobDetails *****/	  
/***** Table No. 4 - HumanResources.Positions *****/  
/***** Table No. 5 - Production.Warehouses *****/	 
/***** Table No. 6 - Production.Vehicles *****/	  
/***** Table No. 7 - Production.StorageUnits *****/	
/***** Table No. 8 - Production.UnitRentals *****/ 
/***** Table No. 9 - HumanResources.Employees  *****/
/***** Table No. 10 - HumanResources.Drivers  *****/
