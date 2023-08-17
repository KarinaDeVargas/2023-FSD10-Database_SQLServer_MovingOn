use movinon_t6;
go

--1. function for years of service -- finished
--2. function isvested
--3. view for active emp
--4. view for inactive emp
--5. trigger to verfiy phone # -- finished
--6. view of Emp salary's
--7. funtion for age + view 1 & 7 -- finished
--8. view 'warehousemanagerReportLabels' contains,warehouseID, WarehouseManager, Mailing address, phone
--9.view JobvenueReport
--10. view StorageRevenueReport
--11. function rent length, add to num 10
--addition questions, functions in one view? FAQ





--1. function to calculate years of service

create function dbo.EmployeesYearService
(
	@EmpID as int
)
returns int
as
	begin
		return
			(select case
						when Enddate is null then Datediff(year, StartDate, getdate())
						else datediff(year, StartDate, EndDate)
					end
			from Employees
			where EmpID = @empID)
	end
;
go

select * from dbo.employees;
go

--test
select EmpFirst, EmpLast, dbo.EmployeesYearService(empID) as 'Years Of Service'
from Employees
;
go

-- function to determind whether an employee is vested

drop function dbo.stillworking;
go

Create function dbo.IsVested
(@EmpID as int)
returns bit
as
	begin
	declare @isVested bit
		return
		
		(select case
					when Enddate is  not null then 0
					else 1
				end,
				case
					when Startdate is not null then 0
					else 1
				end,
				case
						when Enddate is null then Datediff(year, StartDate, getdate())
						else datediff(year, StartDate, EndDate)
				end
		from employees
		where EmpID = @empID)
	end
;
go


--5. trigger to verfiy phone #
create trigger dbo.VerifyPhone
on Dbo.Employees
for insert, update
as
	begin
		declare @phone as nvarChar, @cell as nvarchar, @state as char(2)
		select @phone = phone, @cell = cell, @state = state
		from inserted
		if (@state = 'OR')
			begin
				if LEFT(@Phone, 3) NOT IN ('541', '503', '971')
					begin
						print '***** phone area codes should be 541, 503, or 971 *****'
					end
			end
		if (@state = 'WA')
			begin
				if LEFT(@Phone, 3) NOT IN ('425', '360', '206', '509', '253')
					begin
						print '***** phone area codes should be 425, 360, 206, 509, or 253 *****'
					end
			end
		if (@state = 'WY')
			begin
				if LEFT(@Phone, 3) != '307'
					begin
						print '***** phone area codes should be 307 *****'
					end
			end
	end
;
go

--test
select * from employees;
go

update dbo.employees
set phone = '111333999'
where phone = '5035742742'
;
go

--7. funtion for age
create function dbo.EmployeesAge
(	
	@EmpID as int
)
returns int
as
	begin
		return
			(select  Datediff(year, DOB, getdate())
			from Employees
			where EmpID = @empID)
	end
;
go


select dbo.EmployeesAge(empID), DOB
from employees
;
go

-- view for age and years of service
Create view dbo.EmployeeAgeYoS
as
select concat_ws(', ', EmpLast, EmpFirst) as 'Name', dbo.EmployeesAge(EmpID) as 'Age', dbo.EmployeesYearService(EmpID) as 'Years Of Service'
from employees
;
go

-- test
select *
from dbo.EmployeeAgeYoS
;
go