/* Purpose: Create functions to determine years of service and vested status in the database MovingOn_KVP
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


/*MovinOn Inc. recently adopted a pension plan for all employees, the managers want to inform employees 
when they are fully vested in the plan, which happens after five years of service.

David asks if you can add a message (script) that indicates when an employee is fully vested based on the length of service. 
He also wants you to calculate an employee’s years of service. For active employees, he wants you to hide the End Date field; 
for inactive employees, he wants you to hide the Review field.

Add a new script that uses a calculation to accurately determine the years of service for each active
and inactive employee.

A simple algorithm to determine whether an employee is vested: 
If the employee end date is null (the employee is not terminated yet) and the employee has a started (hired) date, 
then calculate the employee’s years of service. Otherwise, the employee is not vested.

A Simple algorithm: Check if the employee’s years of service are greater than five years, then this
employee is eligible, otherwise the employee is not vested yet.

 For active employees, hide the End Date. For inactive employees, display the End Date.
 */


/* create a function, HumanResources.getEmployeeYearsServedFn, that returns the employee Years Served. 
Drop the function if exists and re-createe it */

if OBJECT_ID('HumanResources.getEmployeeYearsServedFn', 'Fn') is not null
	drop function HumanResources.getEmployeeYearsServedFn
;
go

create function HumanResources.getEmployeeYearsServedFn
(
	-- define parameter list
	-- @parameter_name as data_type =[expression]
	@StartDate as datetime,
	@EndDate as datetime
)
-- returns data_type
returns int
as
	begin
		-- declare the return value
		-- declare @variable_name as data_type =[expression]
		declare @YearsServed as int

		-- compute the return value
		select @YearsServed = abs( 
		CASE
        when @EndDate IS NULL and @StartDate IS NOT NULL then DATEDIFF(YEAR, @StartDate, GETDATE()) 
        when @EndDate IS NOT NULL then DATEDIFF(YEAR, @StartDate, @EndDate)
		else NULL
		END)
			   		
		-- return the result to the function caller
		return @YearsServed
	end
;
go

	
 /* create VIEW with all employees ID, full name, Employee Status, Years Served and Vested Status - Using the fn HumanResources.getEmployeeYearsServedFn */
if OBJECT_ID('HumanResources.EmployeesStatusVestedView', 'V') is not null
	drop view HumanResources.EmployeesStatusVestedView
;
go

create view HumanResources.EmployeesStatusVestedView 
as select
	EmpID as 'Employee ID',
	CONCAT_WS(' ' , EmpFN, EmpLN) as 'Employee Full Name', 
	IIF(EndDate IS NULL, 'Active', 'Inactive') as 'Employee Status',
	HumanResources.getEmployeeYearsServedFn(StartDate, EndDate) as 'Years Served',
	CASE
        when EndDate IS NULL AND StartDate IS NOT NULL AND (DATEDIFF(YEAR, StartDate, GETDATE()) >= 5) then 'Fully Vested'
        else 'Not Vested'
    END as 'Vesting Status'
from HumanResources.Employees
;
go

select *
from HumanResources.EmployeesStatusVestedView
order by 'Years Served' asc
;
go



