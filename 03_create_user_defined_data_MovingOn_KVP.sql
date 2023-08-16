/* Purpose: Create user defined data in the database MovingOn_KVP
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
create type [schema_name].type_name
from system_data_type [constraint]
*/

/* create BusinessAddress data type */
---

/* create SocialNumber data type */
create type SocialNumber
from nchar(11) not null
;
go

/* create table Contacts */
create table Sales.Contacts
(
	ContactID smallint identity(1, 1) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	SocialInsuranceNumber SocialNumber,
	Address BusinessAddress,
	Region RegionCode,
	constraint pk_Contacts primary key clustered (ContactID asc)
)
;
go

/* return the definition of the table Contacts */
execute sp_help 'Contacts'
;
go

/* insert row into Contacts */
insert into Contacts (FirstName, LastName, Address, SocialInsuranceNumber)
values ('John', 'Smith', 'Some adress', '123-456-789')
;
go

select *
from Contacts
;
go