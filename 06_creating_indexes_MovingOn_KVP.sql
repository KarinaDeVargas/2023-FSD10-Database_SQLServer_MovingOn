/* Purpose: Creating Index Objects in database MovingOn_KVP
Script Date: August 15, 2023
Developed by: Karina De Vargas Pereira
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the MovingOn_KVP database
-- Syntax: use database_name
use MovingOn_KVP
;
go -- includes end of the batch marker

/* Creating index - Syntax
1.	create a clustered index on a table
	create object_type object_name on table_name (column_name)
	create clustered index index_name on table_name (column_name)

	
2. Create a non-clustered index on a table (base table) or a view (virtual table)
	create nonclustered index index_name on table_name (column_name)
*/

/* SQL Server Index Architecture and Design Guide
https://docs.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver15
*/




/***** Table No. 1 -  Sales.Customers table *****/
-- retrieve information on table Sales.Customers
execute sp_help 'Sales.Customers'
;
go

-- retrieve index information on table Sales.Customers
execute sp_helpindex 'Sales.Customers'
;
go
		 

/***** Table No. 2 - Sales.JobOrders *****/
-- retrieve information on table Sales.JobOrders
execute sp_help 'Sales.JobOrders'
;
go

-- retrieve index information on table Sales.JobOrders
execute sp_helpindex 'Sales.JobOrders'
;
go


/***** Table No. 3 - Sales.JobDetails *****/
-- retrieve information on table Sales.JobDetails
execute sp_help 'Sales.JobDetails'
;
go

-- retrieve index information on table Sales.JobDetails
execute sp_helpindex 'Sales.JobDetails'
;
go


/***** Table No. 4 - HumanResources.Positions *****/
 -- retrieve information on table HumanResources.Positions
execute sp_help 'HumanResources.Positions'
;
go

-- retrieve index information on table HumanResources.Positions
execute sp_helpindex 'HumanResources.Positions'
;
go


/***** Table No. 5 - Production.Warehouses *****/
  -- retrieve information on table Production.Warehouses
execute sp_help 'Production.Warehouses'
;
go

-- retrieve index information on table Production.Warehouses
execute sp_helpindex 'Production.Warehouses'
;
go


/***** Table No. 6 - Production.Vehicles *****/
-- retrieve information on table Production.Vehicles
execute sp_help 'Production.Vehicles'
;
go

-- retrieve index information on table Production.Vehicles
execute sp_helpindex 'Production.Vehicles'
;
go


/***** Table No. 7 - Production.StorageUnits *****/
-- retrieve information on table Production.StorageUnits
execute sp_help 'Production.StorageUnits'
;
go

-- retrieve index information on table Production.StorageUnits
execute sp_helpindex 'Production.StorageUnits'
;
go


/***** Table No. 8 - Production.UnitRentals *****/
-- retrieve information on table Production.UnitRentals
execute sp_help 'Production.UnitRentals'
;
go

-- retrieve index information on table Production.UnitRentals
execute sp_helpindex 'Production.UnitRentals'
;
go


/***** Table No. 9 - HumanResources.Employees *****/
 -- retrieve information on table HumanResources.Employees
execute sp_help 'HumanResources.Employees'
;
go

-- retrieve index information on table HumanResources.Employees
execute sp_helpindex 'HumanResources.Employees'
;
go


/***** Table No. 10 - HumanResources.Drivers *****/
 -- retrieve information on table HumanResources.Drivers
execute sp_help 'HumanResources.Drivers'
;
go

-- retrieve index information on table HumanResources.Drivers
execute sp_helpindex 'HumanResources.Drivers'
;
go


/*
/* create a nonclustered insex, ncl_City, on the customer city column */
create nonclustered index ncl_City on Sales.Customers (City)
;
go
*/




