---  Display Calendar Table based on the input year. If I give the year 2017 then populate data for 2017 only ---
create procedure calender @StartDate date 
as
begin
	DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 1, @StartDate));


	WITH range_year(n) AS 
	(SELECT 0 UNION ALL SELECT n + 1 FROM range_year
	WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)),
	date_add(d) AS 
	(SELECT DATEADD(DAY, n, @StartDate) FROM range_year),
	calendar AS
	(SELECT
		Date         = CONVERT(date, d),
		Day_Of_Year   = cast(DATEPART(DAYOFYEAR, d)as varchar)+'-'+cast(datepart(DAYOFYEAR,@CutoffDate)AS varchar),
		Day_Of_Month  = cast(DATEPART(DAY,d)as varchar)+'-'+cast(datepart(day,eomonth(d))as varchar),
		Day_Name      = DATENAME(WEEKDAY,   d),
		Week_of_year  = cast(DATEPART(WEEK,d)as varchar)+'-'+cast(DATEPART(WEEK,@CutoffDate) as varchar),
		Day_Of_Week    = cast(DATEPART(WEEKDAY,   d)as varchar)+' - 7',
		Month        = cast(DATEPART(MONTH,d)as varchar)+'- 12',
		Month_Name    = DATENAME(MONTH,d)
  FROM date_add)
SELECT * FROM calendar
  ORDER BY Date
  OPTION (MAXRECURSION 0);
end;
go

exec calender @StartDate='2023-01-01';