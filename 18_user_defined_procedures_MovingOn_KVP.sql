-- CREATED SP TO SHOW EMPLOYEES BASIC INFORMATION

/* Purpose: User-Defined Stored Procedures in database MovingOn_KVP
Script Date: August 16, 2023
Developed by: Karina De Vargas Pereira
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the current MovingOn_KVP database
-- Syntax: use database_name
use MovingOn_KVP
;
go	-- includes end of the batch marker


-- Transact-SQL Syntax for Stored Procedures in SQL Server and Azure SQL Database  
  /*
CREATE [ OR ALTER ] { PROC | PROCEDURE } 
    [schema_name.] procedure_name 
    [ { @parameter [ type_schema_name. ] data_type }  ]   

AS 
	{ [ BEGIN ] 
		sql_statement [;] [ ...n ] 
		[ END ] 
	}  
[;]  

*/


/* create a procedure, HumanResources.getAllEmployeesSP, that returns the employee first name, last name, TitleOfCourtesy
and Position
*/
create procedure HumanResources.getAllEmployeesSP
as
	begin
		select EmpFN as 'Employee First Name', EmpLN 'Employee Last Name', ISNULL(TitleOfCourtesy, '(none)'), PositionID 'Employee Position'
		from HumanResources.Employees
	end
;
go

/* call the procedure HumanResources.getAllEmployeesSP */
execute HumanResources.getAllEmployeesSP
;
go
  


drop procedure HumanResources.getAllEmployeesSP
;
go
