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
		Day_Of_Year   = datename(DAYOFYEAR, d)+'-'+datename(DAYOFYEAR,@CutoffDate),
		Day_Of_Month  = datename(DAY,d)+'-'+datename(day,eomonth(d)),
		Day_Name      = DATENAME(WEEKDAY,   d),
		Week_of_year  = datename(WEEK,d)+'-'+datename(WEEK,@CutoffDate) ,
		Day_Of_Week    = datename(WEEKDAY,   d)+' - 7',
		Month        = datename(MONTH,d)+'- 12',
		Month_Name    = DATENAME(MONTH,d)
  FROM date_add)
SELECT * FROM calendar
  ORDER BY Date
  OPTION (MAXRECURSION 0);
end;
go

exec calender @StartDate='2024-01-01';