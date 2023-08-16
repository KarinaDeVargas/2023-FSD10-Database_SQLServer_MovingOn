/* Purpose: User-Defined Triggers in database Northwind23H2
Script Date: August 16, 2023
Developed by: Khattar Daou
*/


/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the current Northwind database
-- Syntax: use database_name
use Northwind23H2
;
go	-- includes end of the batch marker


/* SYNTAX:
create object_type schema_name.object_name
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table | view } 
{ FOR | AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] } 
as 
sql statements
*/

/* create a trigger, Sales.NotifyCustomerChangesTr, that displays a message when anyone modifies or inserts data into the table Sales.Customers 
*/

create trigger Sales.NotifyCustomerChangesTr
on Sales.Customers
after update, insert
as
	raiserror('Customer table was modified',
		10, -- user severity
		1 -- state
	)
;
go

/* testing the trigger Sales.NotifyCustomerChangesTr */
select *
from Sales.Customers
;
go

/* change the contact name for customer id 'ALFKI' from 'Maria Anders' to 'Margeret Green' */
update Sales.Customers
set ContactName = 'Maria Anders' -- 'Margeret Green'
where CustomerID = 'ALFKI'
;
go


/* create a trigger, HumanResources.CheckModifiedDateTR, that checks the modified date column value.
This trigger ensures that during the insert of a new department, or updating an existing department, the modified date is the current date. If it is not, the row will be updated and set to the current date and time.*/

-- create the table department
create table HumanResources.Departments
(
	DepartmentID int identity(1, 1) not null,
	DepartmentName nvarchar(40) not null,
	ModifiedDate datetime null,
	constraint pk_Departments primary key clustered (DepartmentID asc)
)
;
go

select *
from HumanResources.Departments
;
go

-- insert a new Department
insert into HumanResources.Departments(DepartmentName)
values ('Technet')
;
go

/* create a trigger, HumanResources.CheckModifiedDateTR */
alter trigger HumanResources.CheckModifiedDateTR
on HumanResources.Departments
for insert, update
as
	begin
		-- declare variables
		-- @variable_name as data_type [=expression]
		declare @ModifiedDate as datetime2, @DepartmentID as int
		-- compute the returned value
		select @ModifiedDate = ModifiedDate,
			@DepartmentID = DepartmentID
		from inserted
		-- making decision (comparing the Modified Date with the current date)
		if (abs(DateDiff(day, @ModifiedDate, getDate() )) > 0) or (@ModifiedDate is null)
			begin
				-- set the modified date to the current date
				update HumanResources.Departments
				set ModifiedDate = getDate()
				where DepartmentID = @DepartmentID
				print '***** The Date was modified *****'
			end
	end
;
go

select *
from HumanResources.Departments
;
go

/* change the department name of Department 1 to 'IT' */
update HumanResources.Departments
set DepartmentName = 'IT' 
where DepartmentID = 1
;
go

/* add a new department (passed date) */
insert into HumanResources.Departments
values('HR', '08/16/2022')
;
go

/* add a new department (future date) */
insert into HumanResources.Departments
values('Sales', '08/16/2026')
;
go

insert into HumanResources.Departments
values ('Purchase', '08/16/2026')
;
go

/* add a new department (no modified date) */
insert into HumanResources.Departments(DepartmentName)
values ('Production')
;
go

/* Enable or Disable a trigger 
Syntax:
disable trigger schema_name.trigger_name on schema_name.table_name 

enable trigger schema_name.trigger_name on schema_name.table_name 
*/

disable trigger HumanResources.CheckModifiedDateTR on HumanResources.Departments
;
go

/* add a new department (trigger is disabled) */
insert into HumanResources.Departments(DepartmentName)
values ('Shipping')
;
go

-- check if the trigger is disabled or enabled
select name, is_disabled
from sys.triggers


/*
create a trigger, OrderDetailsInsertTr, that updates a column (UnitsInStock) 
in the Production.Products table, whenever a products is ordered (whenever a 
record is inserted into the order details table). 
When the insert occurs, it fires the OrderDetailsInsertTr trigger and reduces 
the quantity of the product placed in the order details. another words, 
the UnitsInStock in the Production.Products table will be calculated as 
UnitsInStock  = UnitsInStock - QuantityOrdered
*/

select *
from Production.Products
where ProductID = 1
;

select *
from Sales.[Order Details]
where OrderID = 10248
;
go

create trigger Sales.OrderDetailsInsertTr
on Sales.[Order Details]
for insert
as
	update PP
	set PP.UnitsInStock = (PP.UnitsInStock - SOD.Quantity)
	from Production.Products as PP
		inner join Sales.[Order Details] as SOD
			on PP.ProductID = SOD.ProductID
;
go

-- disable constraint
alter table Production.Products
nocheck constraint CK_UnitsInStock
;
go

insert into Sales.[Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (10248, 1, 48.99, 10, 0.0)
;
go
