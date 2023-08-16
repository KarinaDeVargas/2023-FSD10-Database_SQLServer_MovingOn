/* Purpose: Creating the database MovingOn_KVP
Script Date: August 15, 2023
Developed by: Karina De Vargas Pereira
*/

/* add a statement that specifies the script 
runs in the context of the master database */

-- switch to the master database 
-- syntax: use database_name

use master
;
go 	-- includes end of the batch marker



/* Partial syntax to create a database
create object_type object_name
create database database_name
*/

-- database name
-- create the MovingOn_KVP database
create database MovingOn_KVP
-- data file
on primary
(
	-- 1) rows data logical filename
	name = 'MovingOn_KVP',
	-- 2) rows data initial file size 
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 8MB,
	-- 4) rows data maximum size
	maxsize = unlimited, -- 250MB
	-- 5) rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\MovingOn_KVP.mdf'
)
-- log file
log on
(
	-- 1) log logical filename
	name = 'MovingOn_KVP_log',
	-- 2) log initial file size (1/4 the rows data file size)
	size = 3MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log maximum size
	maxsize = 25MB,
	-- 5) log path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\MovingOn_KVP_log.ldf'
)
;
go

-- increase the maximum size of the database MovingOn_KVP_log to 100MB

-- switch to the Master database
-- use database master
use master
;
go

alter database MovingOn_KVP
	modify file 
	(
		name = 'MovingOn_KVP',
		maxsize = 100Mb
	)
;
go

-- return the definition of MovingOn_KVP database using system stored procedure 
-- Syntax exec(ute) stored_procedure_name [paramater_value]
execute sp_helpdb 'MovingOn_KVP'
;
go

/* return the SQL Server version we are running */
select
	@@VERSION as 'SQL Server Version',
	@@SERVERNAME as 'Server Name'
;
go

-- switch to database MovingOn_KVP
use MovingOn_KVP
;
go

-- return the current user name and the database name 
select
	USER_NAME() as 'User Name',
	DB_NAME() as 'Database Name'
;
go


/*
drop database MovingOn_KVP, MyDB1
;
go

*/
