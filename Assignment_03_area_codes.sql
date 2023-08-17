/* Purpose: Check area codes for employees in database MovingOn_KVP
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

/*
Finally, to help with data entry, the warehouse managers want to verify phone and cell phone area 
codes entered into Employee Data

Verify telephone area codes for employee phone numbers. 
For employees living in Oregon, the valid area codes are 541, 503, and 971; 
for employees living in Washington, the valid area codes are 425, 360, 206, 509, and 253; 
for employees living in Wyoming, the valid area code is 307. 
Warehouse managers should be able to enter phone area codes for other states not included in the lists.
*/


/*** USED: VIEW | CONCAT_WS() | CASE | substring() ***/
/* create Employee telephone area code VIEW (HumanResources.EmployeesAreaCodeView) */
if OBJECT_ID('HumanResources.EmployeesAreaCodeView', 'V') is not null
	drop view HumanResources.EmployeesAreaCodeView
;
go

create view HumanResources.EmployeesAreaCodeView 
as select
	HRE.EmpID as 'Employee ID',
	CONCAT_WS(' ' , HRE.EmpFN, HRE.EmpLN) as 'Employee Full Name', 
	HRE.Phone, 
	CASE
        when substring([Phone], 1, 3) in ('541', '503', '971') and HRE.State not in ('OR') then 'Incorrect Area Code'
	   	when substring([Phone], 1, 3) in ('425', '360', '206', '509', '253') and HRE.State not in ('WA') then 'Incorrect Area Code'
		when substring([Phone], 1, 3) in ('307') and HRE.State not in ('WY') then 'Incorrect Area Code'
		else 'Correct Area Code'
    END as 'Area Code Check',
   	State
from HumanResources.Employees as HRE
;
go

select *
from HumanResources.EmployeesAreaCodeView
;
go

update HumanResources.Employees
set State = 'OR'  -- Changed to test my view HumanResources.EmployeesAreaCodeView 
where EmpID = 1;
;
go





