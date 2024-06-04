
--- please use EMPID268 to all this querys -------

----- 1st question assignment -------
select service_type,location_1 from company_bonus group by service_type,location_1 having (sum(salary)>2*(avg(salary)) and max(salary)>3*(min(salary)));


------- 2nd question assignment------
with eligibe as(
select *,
		 dateadd(day,15,dateadd(month,3,dateadd(year,1,date_of_join))) as 'eligibile_date',
		dateadd(day,1,EOmonth(dateadd(day,15,dateadd(month,3,dateadd(year,1,date_of_join)))))as 'e_m' ,
		datename(weekday,dateadd(day,15,dateadd(month,3,dateadd(year,1,date_of_join)))) as 'weekday',
		datename(week,dateadd(day,15,dateadd(month,3,dateadd(year,1,date_of_join)))) as 'week_of_year',
		datename(day,dateadd(day,15,dateadd(month,3,dateadd(year,1,date_of_join)))) as 'day_of_year'  from company_bonus)
select *,dbo.age(dob,e_m) as 'AGE_when_eligible'from eligibe



CREATE FUNCTION age(
    @dob DATE,
    @curda DATE
)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @years INT,@months INT,@days INT,@tmpdate DATE;
SET @tmpdate = @dob;
SET @years = DATEDIFF(yy, @tmpdate, @curda) - 
CASE 
	WHEN (MONTH(@dob) > MONTH(@curda)) OR (MONTH(@dob) = MONTH(@curda) AND DAY(@dob) > DAY(@curda)) 
		THEN 1 
	ELSE 0 END;
SET @tmpdate = DATEADD(yy, @years, @tmpdate)
SET @months = DATEDIFF(m, @tmpdate, @curda) - 
CASE 
	WHEN DAY(@dob) > DAY(@curda) THEN 1 
	ELSE 0 END;
SET @tmpdate = DATEADD(m, @months, @tmpdate);
SET @days = DATEDIFF(d, @tmpdate, @curda);
RETURN concat_ws('-',CAST(@years AS VARCHAR(10)), CAST(@months AS VARCHAR(10)), CAST(@days AS VARCHAR(10)));
END;




----- 3rd  question assignment2 ----------
select * from company_bonus where (service_type=1 and
									(employee_type=1 and datediff(year,date_of_join,GETDATE())>=10 and datediff(year,getdate(),dateadd(year,60,DOB))>=15) or
									(employee_type=2 and datediff(year,date_of_join,GETDATE())>=12 and datediff(year,getdate(),dateadd(year,55,DOB))>=14) or
									(employee_type=3 and datediff(year,date_of_join,GETDATE())>=12 and datediff(year,getdate(),dateadd(year,55,DOB))>=12)) 
									or(service_type in (2,3,4) and datediff(year,date_of_join,GETDATE())>=15 and datediff(year,getdate(),dateadd(year,55,DOB))>=20);

------ 4th question assignment2---------
WITH cte AS (
    SELECT id,name,service_type, age, dbo.age(date_of_join,GETDATE()) as 'service_status',
		sum(age) over(order by service_type),
        row_number() OVER (partition by service_type ORDER BY age) rnk_min,
        row_number() OVER (partition by service_type ORDER BY age DESC) rnk_max
    FROM company_bonus
)
select * from cte
SELECT id,name,service_type, age,service_status
FROM cte
WHERE rnk_min = 1 OR rnk_max = 1
ORDER BY service_type,age;



-----  5th question of assignment 2------
select * from CUSTOMER where left(cust_name,1)=right(cust_name,1);

------ same 5th question but whe we need to ignore intials in a name-----
declare @name varchar(20)
set @name = 'rithikr v'
declare @l int = len(@name)
if patindex('% %',left(@name,2))= 2 
begin
	if substring(@name,3,1)=substring(@name,@l,1)
	select @name
	end
else if patindex('% %',right(@name,2))= 1
begin
	if substring(@name,1,1)=substring(@name,@l-2,1)
	select @name
	end;

------ OR -------

select name from emp_name where SUBSTRING(name,3,1)=SUBSTRING(name,len(name),1) or SUBSTRING(name,1,1)=SUBSTRING(name,len(name)-2,1);