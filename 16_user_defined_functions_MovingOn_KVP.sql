/* Purpose: User-Defined Functions in database MovingOn_KVP
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


/* A User-Defined Function (UDF) is a Transactional-SQL (T-SQL) statements that returns parameters, perform an action, 
such as calculation, and returns the result of that action as a value. 
The return value can either be a scalar (single) or a table. */

/* 
SYNTAX:
	create function schema_name.function_name
	(
		[@parameter_name as data_type [=expression],
		@parameter_name as data_type,
		...
		]
	)
	returns data_type
	as
		begin
			T-SQL statement goes here
			return value
		end
	;
	go
*/























/*
/* create a function, HumanResources.getEmployeeSeniorityFn, that returns the employee seniority. drop the function if exists and re-createe it */
if OBJECT_ID('HumanResources.getEmployeeSeniorityFn', 'Fn') is not null
	drop function HumanResources.getEmployeeSeniorityFn
;
go

alter function HumanResources.getEmployeeSeniorityFn
(
	-- define parameter list
	-- Syntax: @parameter_name as data_type [=expression]
	@HireDate as datetime2
)


-- returns data_type
returns int
as
	begin
		-- declare the returned value
		-- declare @variable_name as data_type [=expression]
		declare @Seniority as int

		-- compute the returned value 
		select @Seniority = abs(DateDiff(year, @HireDate, getDate() ))

		-- return the result to the function caller 
		return @Seniority
	end
;
go

-- testing the HumanResources.getEmployeeSeniorityFn
select HumanResources.getEmployeeSeniorityFn('08/15/2026') as 'Seniority'
;
go
*/