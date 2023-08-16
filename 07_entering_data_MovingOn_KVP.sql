/* Purpose: Inserting data into table Objects in database MovingOn_KVP
Script Date: August 16, 2023
Developed by: Karina De Vargas Pereira
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the MovingOn_KVP database
-- Syntax: use database_name
use MovingOn_KVP
;
go -- includes end of the batch marker

/* 1. using insert clause 
Syntax: 
insert [into] schema_name.table_name [(column_list)]
values (value1, value2, ...)
;
go

insert into HumanResources.Employees (FirstName, LastName, Birthdate, HireDate, Address, City, Region, PostalCode, Country, HomePhone)
values('John', 'Smith', '5/21/1999', '8/12/2018', 'some address', 'some city', 'some region', 'zipcode', 'some country', '(514) 555-5555')
;
go
*/


/* 3. Using Bulk Insert clause
Syntax:
bulk insert schema_name.table_name
from 'path/filename.extension'
with
(
	FirstRow = number_of_first_row,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go
*/


/***** Table No. 1 - Sales.Customers *****/
bulk insert Sales.Customers
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\1.Customers.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Sales.Customers
;
go

/***** Table No. 2 - Sales.JobOrders *****/
 bulk insert Sales.JobOrders
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\2.JobOrders.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Sales.JobOrders
;
go

/***** Table No. 3 - Sales.JobDetails *****/
bulk insert Sales.JobDetails
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\3.JobDetails.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Sales.JobDetails
;
go

/***** Table No. 4 - HumanResources.Positions *****/
SET IDENTITY_INSERT HumanResources.Positions ON
; 
go

insert into HumanResources.Positions (PositionID, Title)
values(1, 'Driver'), 
(2, 'Adm Assistant'),
(3, 'Driver Helper'),
(4, 'Manager'),
(5, 'Lift Driver'),
(6, 'Assistant Manager'),
(7, 'Secretary'),
(8, 'Packer'),
(9, 'Sales'),
(10, 'Supervisor')
;
go

SET IDENTITY_INSERT HumanResources.Positions OFF
; 
go

select *
from HumanResources.Positions
;
go

/***** Table No. 5 - Production.Warehouses *****/
 bulk insert Production.Warehouses
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\5.Warehouses.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Production.Warehouses
;
go

/***** Table No. 6 - Production.Vehicles *****/
bulk insert Production.Vehicles
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\6.Vehicles.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Production.Vehicles
;
go

/***** Table No. 7 - Production.StorageUnits *****/	
bulk insert Production.StorageUnits
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\7.StorageUnits.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Production.StorageUnits
;
go

/***** Table No. 8 - Production.UnitRentals *****/
bulk insert Production.UnitRentals
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\8.UnitRentals.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from Production.UnitRentals
;
go

/***** Table No. 9 - HumanResources.Employees *****/
bulk insert HumanResources.Employees
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\9.Employees.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from HumanResources.Employees
;
go

/***** Table No. 10 - HumanResources.Drivers  *****/
bulk insert HumanResources.Drivers
from 'C:\Users\Karina de V Pereira\Desktop\Karina de Vargas\00.FullStack Dev\Database\SA5_DB_Take_Home_Assignment_3_Data\movingon_data_csv\10.Drivers.csv'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
	RowTerminator = '\n'
)
;
go

select *
from HumanResources.Drivers
;
go







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