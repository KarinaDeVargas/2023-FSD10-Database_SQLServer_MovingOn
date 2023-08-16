/* Purpose: Creating Table objects in the database MovingOn_KVP
Script Date: August 15, 2023
Developed by: Karina De Vargas Pereira
*/

/* add a statement that specifies the script 
runs in the context of the master database */

-- switch to the current database 
-- syntax: use database_name

use MovingOn_KVP
;
go 	-- includes end of the batch marker


/* Consider the following facts when you create tables in SQL Server. You can have up to:
	? two billions tables per database
	? 1024 columns per table
	? 8092 bytes per row (this does not apply to image and text data types)
*/

/* The following script must be used only during the development process and NOT on the production database. */
select *
from sys.all_objects
;
go

/* ONLY in the development environment, NOT in the production database, check if an object exists by verifying the object id. If the table exists, delete it using the drop command. If the table does not exist, it will be created
*/
/* ***** 1. Sales.Customers table ***** */
if OBJECT_ID('Sales.Customers', 'U') is not null
	drop table Sales.Customers
;
go

create table Sales.Customers
(
	-- column_name data_type constraint(s)
	CustomerID int identity(1, 1) not null,	-- auto-generated number assigned to a new Customer
    CompanyName varchar(50) null,
    CustFN varchar(30) not null,
    CustLN varchar(30) not null,
    Address varchar(40) not null,
    City varchar(30) not null,
    State varchar(2) not null,
    ZIP varchar(10) not null,
    Phone varchar(15) not null,
    Balance decimal(19,4) null,
	Fax nvarchar(24) null,		-- Fax number includes country code and / or area code
	Email nvarchar(60) not null,
	Website nvarchar(60) null,	-- Customer URL	
	constraint pk_Customers primary key clustered (CustomerID asc)
	
)
;
go

/* return the definition of the database */
execute sp_helpdb 'MovingOn_KVP'
;
go

/* return the definition of the table Sales.Customers */
execute sp_help 'Sales.Customers'
;
go


/* Creates an identity column in a table. The IDENTITY property has the following syntax:
	IDENTITY [ (seed , increment) ]  

	where 
	? seed Is the value that is used for the very first row loaded into the table
	? increment Is the incremental value that is added to the identity value of the previous row that was loaded.
	You must specify both the seed and increment or neither. If neither is specified, the default is (1,1).


	SET IDENTITY_INSERT [ [ database_name . ] schema_name . ] table_name { ON | OFF }

For example, set identity_insert Sales.Shippers2 on 
;
*/

/* ***** Table No. 2 - Sales.JobOrders ***** */
if OBJECT_ID('Sales.JobOrders', 'U') is not null
	drop table Sales.JobOrders
;
go

create table Sales.JobOrders 
(
	JobOrderID int identity(1, 1) not null,	-- auto-generated number assigned to a new JobOrder
	CustomerID int not null,	-- Foreign key (CustomerID in Sales.Customers)
	EmployeeID int not null,	-- Foreign key (EmployeeID in HumanResources.Employees)  
	OrderDate datetime not null,		   			 		  
	MoveDate datetime not null,
    FromAddress varchar(50) not null,
    FromCity varchar(30) not null,
    FromState varchar(2) not null,
    FromZIP varchar(10) not null,
	ToAddress varchar(50) not null,
    ToCity varchar(30) not null,
    ToState varchar(2) not null,
    ToZIP varchar(10) not null,
	DistanceEst int not null, 
	WeightEst int not null,
	Packing tinyint,
	Havy tinyint,
	Storage tinyint,
    constraint pk_JobOrders primary key (JobOrderID asc)
)
;
go


/***** Table No. 3 - Sales.JobDetails *****/
if OBJECT_ID('Sales.JobDetails', 'U') is not null
	drop table Sales.JobDetails
;
go

CREATE TABLE Sales.JobDetails
(
	JobDetailID int IDENTITY(1,1) not null,  -- auto-generated number assigned to each new JobDetail
    JobOrderID int not null, -- foreign key (
    VehicleID varchar(10) not null,	 -- foreign key (
    DriverID int not null, -- foreign key (
    MileageActual int not null,
    WeightActual int not null,
    constraint pk_JobDetails primary key (JobDetailID asc)
)
;
go

/***** Table No. 4 - HumanResources.Positions *****/
if OBJECT_ID('HumanResources.Positions', 'U') is not null
	drop table HumanResources.Positions
;
go

create table HumanResources.Positions
(
	PositionID int IDENTITY(1,1) not null,  -- auto-generated number assigned to each new Position
    Title varchar(30) not null,
    constraint pk_Positions primary key (PositionID asc)
)
;
go	

/***** Table No. 5 - Production.Warehouses *****/
if OBJECT_ID('Production.Warehouses', 'U') is not null
	drop table Production.Warehouses
;
go

CREATE TABLE Production.Warehouses
(
	
	WarehouseID varchar(5) not null, -- Business Rules applied to create Unique ID
    Address varchar(40) not null,
    City varchar(30) not null,
    State varchar(2) not null,
    ZIP varchar(10) not null,
    Phone varchar(15) not null,
    ClimateControl tinyint not null,
    SecurityGate tinyint not null,
	CONSTRAINT pk_Warehouses PRIMARY KEY CLUSTERED (WarehouseID ASC)
)
;
go

/***** Table No. 6 - Production.Vehicles *****/
if OBJECT_ID('Production.Vehicles', 'U') is not null
	drop table Production.Vehicles
;
go	 

CREATE TABLE Production.Vehicles
(
	VehicleID varchar(10) not null, -- Business Rules applied to create Unique ID
    LicensePlateNum varchar(7) not null,
    Axle int not null,
    Color varchar(10) not null,
    constraint pk_Vehicles primary key (VehicleID asc)
)
; 
go	   

/***** Table No. 7 - Production.StorageUnits *****/
if OBJECT_ID('Production.StorageUnits', 'U') is not null
	drop table Production.StorageUnits
;
go	 

CREATE TABLE Production.StorageUnits
(
	StorageUnitID int IDENTITY(1,1) not null, -- auto-generated number assigned to each new StorageUnit
	WarehouseID varchar(5) not null, -- foreign key (
    UnitSize varchar(10) not null,	-- foreign key (
    Rent decimal(19,4) not null,    
    constraint pk_StorageUnits primary key clustered (StorageUnitID)   	
)
;
go


/***** Table No. 8 - Production.UnitRentals *****/
if OBJECT_ID('Production.UnitRentals', 'U') is not null
	drop table Production.UnitRentals
;
go


CREATE TABLE Production.UnitRentals
(
	UnitRentalID int IDENTITY(1,1) not null, -- auto-generated number assigned to each new UnitRentals
    StorageUnitID int not null,  -- foreign key (
    CustomerID int not null, -- foreign key (
    DateIn datetime not null,
    DateOut datetime null,
    constraint pk_UnitRentals primary key clustered (UnitRentalID)
)
;
go


/***** Table No. 9 - HumanResources.Employees  *****/
if OBJECT_ID('HumanResources.Employees', 'U') is not null
	drop table HumanResources.Employees
;
go

CREATE TABLE HumanResources.Employees
(
	EmpID int IDENTITY(1,1) not null, -- auto-generated number assigned to a new employee
	TitleOfCourtesy nvarchar(25) null, -- e.g. Mr., Ms., Dr., Prof, ...
	Photo varbinary(max) null,
    EmpFN varchar(30) not null,
    EmpMN varchar(30) null,
    EmpLN varchar(30) not null,
    WarehouseID varchar(5) not null,  -- foreign key (
    SSN varchar(9) not null,
    DOB datetime not null,
    StartDate datetime not null,
    EndDate datetime null,
    Address varchar(40) not null,
    City varchar(30) not null,
    State varchar(2) not null,
    ZIP varchar(10) not null,
    PositionID int not null,  -- foreign key (
	Review datetime null,
    Phone varchar(15) null,
    Cell varchar(15) not null,
    Salary decimal(19,4) null, -- It can be null if Employee is payed by hour and it does not have a fixed salary
    HourlyRate decimal(19,4) null,  -- It can be null if Employee has a year based salary and it is not payed by hour
	Memo varchar(80) null,
	constraint pk_Employees primary key clustered (EmpID asc)
)
;
go

/***** Table No. 10 - HumanResources.Drivers  *****/
if OBJECT_ID('HumanResources.Drivers', 'U') is not null
	drop table HumanResources.Drivers
;
go

CREATE TABLE HumanResources.Drivers
(
	DriverID int IDENTITY(1,1) not null, -- auto-generated number assigned to a new employee
	TitleOfCourtesy nvarchar(25) null, -- e.g. Mr., Ms., Dr., Prof, ...
	Photo varbinary(max) null,
    DriverFN varchar(30) not null,
    DriverMN varchar(30) null,
    DriverLN varchar(30) not null,
    SSN varchar(9) not null,
    DOB datetime not null,
    StartDate datetime not null,
    EndDate datetime null,
    Address varchar(40) not null,
    City varchar(30) not null,
    State varchar(2) not null,
    ZIP varchar(10) not null,
    PositionID int default '1', -- I think it is important to create this Attribute and have it default as the position related to "Driver", then we can use it in the queries 
    Phone varchar(15) null,
    Cell varchar(15) not null,
    MileageRate decimal(19,4) not null,
    Review datetime null,
    DrivingRecord varchar(1) not null,
    constraint pk_Drivers primary key clustered (DriverID asc)
)
;
go



/* display used-defined and system tables */
-- in schema Production
execute sp_tables
@table_qualifier = 'MovingOn_KVP',
@table_owner = 'Production'
;
go

-- in schema HumanResources
execute sp_tables
@table_owner = 'HumanResources',
@table_qualifier = 'MovingOn_KVP'
;
go

-- in schema Sales 
execute sp_tables
@table_qualifier = 'MovingOn_KVP',
@table_owner = 'Sales'
;
go


/***** Table No. 1 - Sales.Customers table *****/
/***** Table No. 2 - Sales.JobOrders *****/
/***** Table No. 3 - Sales.JobDetails *****/
/***** Table No. 4 - HumanResources.Positions *****/
/***** Table No. 5 - Production.Warehouses *****/
/***** Table No. 6 - Production.Vehicles *****/
/***** Table No. 7 - Production.StorageUnits *****/
/***** Table No. 8 - Production.UnitRentals *****/
/***** Table No. 9 - HumanResources.Employees *****/
/***** Table No. 10 - HumanResources.Drivers *****/