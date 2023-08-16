/* Purpose: Applying Data Integrity in database MovingOn_KVP
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


/* Integrity Types:
	1. Domain (column)
	2. Entity (row)
	3. Referential (between two columns or tables)

	
Constraint Types:
1. Primary Key (pk_)
	alter table schema_name.table_name
		add constraint pk_table_name primary key clustered (column_name asc)

		
2. Foreign key (fk_)
	alter table schema_name.table_name
		add constraint fk_first_table_name_second_table_name foreign key (fk_column_name) references second_table_name (pk_column_name)

		
3. Default (df_)
	alter table schema_name.table_name
		add constraint df_column_name_table_name default (value) for column_name


4. Check (ck_)
	alter table schema_name.table_name
		add constraint ck_column_name_table_name check (condition)


5. Unique (uq_)
alter table schema_name.table_name
		add constraint uq_column_name_table_name unique (column_name)
*/	  

/***** Table No. 1 - Sales.Customers *****/
-- No extra constraints (only one primary key)


/***** Table No. 2 - Sales.JobOrders *****/	
-- Foreign key constraints
/* 1) Between Sales.JobOrders and Sales.Customers */
-- constraint constraint_name constraint_type
alter table Sales.JobOrders
	add constraint fk_JobOrders_Customers foreign key (CustomerID)
		references Sales.Customers (CustomerID)
;
go

/* 2) Between Sales.JobOrders and HumanResources.Employees */
alter table Sales.JobOrders
	add constraint fk_JobOrders_Employees foreign key (EmployeeID)
		references HumanResources.Employees (EmpID)
;
go


-- Default constraints (set DistanceEst column value to zero)

/*Default (df_)
	alter table schema_name.table_name
		add constraint df_column_name_table_name default (value) for column_name
*/
alter table Sales.JobOrders
	add constraint df_DistanceEst_JobOrders default (0) for DistanceEst
;
go

-- Default constraints (set WeightEst column value to zero)
alter table Sales.JobOrders
	add constraint df_WeightEst_JobOrders default (0) for WeightEst
;
go

/***** Table No. 3 - Sales.JobDetails *****/
-- Foreign key constraints 
/* 1) Between Sales.JobDetails and Sales.JobOrders */
alter table Sales.JobDetails
	with nocheck
	add constraint fk_JobDetails_JobOrders foreign key (JobOrderID)
		references Sales.JobOrders (JobOrderID)
;
go
		 
/* 2) Between Sales.JobDetails and HumanResources.Drivers*/
alter table Sales.JobDetails
	with nocheck
	add constraint fk_JobDetails_Drivers foreign key (DriverID)
		references HumanResources.Drivers (DriverID)
;
go

/* 3) Between Sales.JobDetails and Production.Vehicles*/
alter table Sales.JobDetails
	with nocheck
	add constraint fk_JobDetails_Vehicles foreign key (VehicleID)
		references Production.Vehicles (VehicleID)
;
go

-- Default constraints in Sales.JobDetails
/* set the default constraint value to 0 for MileageActual and 0 WeightActual column */

-- 1. set the default constraint value to 0 for MileageActual
alter table Sales.JobDetails
	add constraint df_MileageActual_JobDetails default (0) for MileageActual
;
go

-- 2. set the default constraint value to 0 for WeightActual
alter table Sales.JobDetails
	add constraint df_WeightActual_JobDetails default (0) for WeightActual
;
go
			
/***** Table No. 4 - HumanResources.Positions *****/
-- No extra constraints (only one primary key)

/***** Table No. 5 - Production.Warehouses *****/
-- No extra constraints (only one primary key)
		
/***** Table No. 6 - Production.Vehicles *****/
-- No extra constraints (only one primary key)
	   
/***** Table No. 7 - Production.StorageUnits *****/
  -- Foreign key constraints 
/* 1) Between Production.StorageUnits and Production.Warehouses */
alter table Production.StorageUnits
	add constraint fk_StorageUnits_Warehouses foreign key (WarehouseID)
		references Production.Warehouses (WarehouseID)
;
go	 

/***** Table No. 8 - Production.UnitRentals  *****/ 
/* 1) Between Production.UnitRentals and Sales.Customers */
-- constraint constraint_name constraint_type
alter table Production.UnitRentals
	add constraint fk_UnitRentals_Customers foreign key (CustomerID)
		references Sales.Customers (CustomerID)
;
go

/* 2) Between Production.UnitRentals and Production.StorageUnits */
-- constraint constraint_name constraint_type
alter table Production.UnitRentals
	add constraint fk_UnitRentals_StorageUnits foreign key (StorageUnitID)
		references Production.StorageUnits (StorageUnitID)
;
go

/***** Table No. 9 - HumanResources.Employees  *****/	
-- Foreign key constraints
/* 1) Between HumanResources.Employees and HumanResources.Positions */
alter table HumanResources.Employees 
	add constraint fk_Employees_Positions foreign key (PositionID)
		references HumanResources.Positions (PositionID)
;
go
  -- Foreign key constraints 
/* 2) Between HumanResources.Employees and Production.Warehouses */
alter table HumanResources.Employees
	add constraint fk_Employees_Warehouses foreign key (WarehouseID)
		references Production.Warehouses (WarehouseID)
;
go	

-- Check Hire Date to be less than or equal to the current date



/***** Table No.  No. 10 - HumanResources.Drivers  *****/
-- No extra constraints (only one primary key)








/* transfer a table from one schema to another 
Syntax:
alter schema to_schema_name TRANSFER from_schema_name.object_name
*/


-- Check constraint in Production.Products
/* check that the following column values in the Products table must be >= 0: UnitPrice, ReorderLevel, UnitsInStock, UnitsOnOrder 

-- 1. check that UnitPrice >= 0
alter table Production.Products
	add constraint ck_UnitPrice_Products check (UnitPrice >= 0)
;
go

-- 2. check that UnitsInStock >= 0
alter table Production.Products
	add constraint ck_UnitsInStock_Products check ([UnitsInStock] >= 0)
;
go

-- 3. check that UnitsOnOrder >= 0
alter table Production.Products
	add constraint ck_UnitsOnOrder_Products check ([UnitsOnOrder] >= 0)
;
go

-- 4. check that ReorderLevel >= 0
alter table Production.Products
	add constraint ck_ReorderLevel_Products check ([ReorderLevel] >= 0)
;
go

/* set the ProductName to be unique in the Production.Products table */
alter table Production.Products
-- add constraint uq_name unique (column_name)
	add constraint uq_ProductName_Products unique (ProductName)
;
go	*/





