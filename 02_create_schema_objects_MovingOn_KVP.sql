/* Purpose: Creating schema objects in the database MovingOn_KVP
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


/* Partial Syntax:
create schema schema_name authorization owner_name
*/

/* a schema is a distinct namespace to facilitate the separation,
organization, management, and ownership of database objects.

Schemas are used as containers for objects such as tables, views, and stored procedures. Schemas can be particularly helpful in providing a level of organization and structure when large numbers of objects are present in a database.

Security permissions can also be assigned at the schema level rather than individually on the objects contained within the schemas. Doing this can greatly simplify the design of system security requirements

In SQL Server, an object is formally referred to by a name of the form:
Server.Database.Schema.Object

? Security Boundary
Schemas can be used to simplify the assignment of permissions. An example of applying permissions at the schema level would be to assign the EXECUTE permission on a schema to a user. The user could then execute all stored procedures within the schema. This simplifies the granting of permissions as there is no need to set up individual permissions on each stored procedure.

It is important to understand that schemas are not used to define physical storage locations for data, as occurs in some other database engines, such as in MySQL Server. 
*/

/* create schema objects and set the owner to each of them
1. Sales
2. Production
3. HumanResources
4. Person
5. Purchasing
*/



-- syntax: create schema schema_name authorization onwer_name

-- 1. Sales schema
create schema Sales authorization dbo
;
go

-- 2. Production schema
create schema Production authorization dbo
;
go

-- 3. HumanResources schema
create schema HumanResources authorization dbo
;
go

-- 4. Person schema
create schema Person authorization dbo
;
go

-- 5. Purchasing schema
create schema Purchasing authorization dbo
;
go



/*
 create a schema and grant permessions. 
 Create Sports schema owned by Annik that contains table Teams. 
 The statement grants SELECT to Andrew and denies SELECT to David.
 */

 /*create schema Sports authorization Annik
	create table Teams
	(
		MemberID int not null,
		TeamName varchar(25) not null
	)
	grant select on schema::sports to Andreww
	deny select on schema::Sports to David

	I am Andrew
	select *
	from Sports.Team
	*/