/* Purpose: Using System Stored Procedures in database MovingOn_KVP
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

execute sp_datatype_info
;
go

/* return the list of all databases in SQL Server */
exec sp_databases
;
go

/* return information about MovingOn_KVP database */
execute sp_helpdb 'MovingOn_KVP'
;
go

/* return information about specific object in a database */
execute sp_help 'Sales.Customers'
;
go

/* return all tables in a specific schema */
execute sp_tables
-- @table_name = 'Orders',
@table_owner = 'Sales'
;
go

/* return constraints applyed to the Sales.JobOrders table */
execute sp_helpconstraint 'Sales.JobOrders'
;
go
