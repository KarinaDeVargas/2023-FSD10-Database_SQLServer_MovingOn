-- NOT USED

/* Purpose: Creating View Objects in database Northwind23H2
Script Date: August 15, 2023
Developed by: Khattar Daou
*/


/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the current Northwind database
-- Syntax: use database_name
use Northwind23H2
;
go	-- includes end of the batch marker

/*
/* 1. create the contact customer view (Sales.ContactNameView) that contains the contact name and contact title */
if OBJECT_ID('Sales.ContactNameView', 'V') is not null
	drop view Sales.ContactNameView
;
go

create view Sales.ContactNameView
as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle
	from Sales.Customers as SC
;
go

select *
from Sales.ContactNameView
;
go


/* 2. modify the Sales.ContactNameView and add the Phone, and Country */
alter view Sales.ContactNameView
	as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle, Phone, Country
	from Sales.Customers as SC
;
go


/* create the order total view, Sales.OrderTotalView, that returns the sum of each order */
if OBJECT_ID('Sales.OrderTotalView', 'V') is not null
	drop view Sales.OrderTotalView
;
go

create view Sales.OrderTotalView
as
	select SOD.OrderID, SOD.ProductID,
   convert(smallmoney,	(SOD.UnitPrice * SOD.Quantity)*(1 - SOD.Discount) ) as 'OrderTotal'
	from Sales.[Order Details] as SOD
-- where SOD.OrderID = 10250
;
go


/* 3. return the grand total of all orders placed customers (company name) in 2023. use the Sales.OrderTotalView in your script. */
select
	SC.CustomerID, SC.CompanyName as 'Company',
	sum(SOT.OrderTotal) as 'Grand Total'
from Sales.Customers as SC
	inner join Sales.Orders as SO
		on SC.CustomerID = SO.CustomerID
	inner join Sales.OrderTotalView as SOT
		on SO.OrderID = SOT.OrderID
where year(so.OrderDate) = '2023'
-- and SC.CustomerID = 'ALFKI'
group by SC.CustomerID, SC.CompanyName
;
go

-- check for dependencies
execute sp_depends 'Sales.Orders'
;
go

EXEC sp_depends @objname = N'Sales.Customers' 
;  
go

*/