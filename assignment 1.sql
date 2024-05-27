
-- 1. Write a script to extracts all the numerics from Alphanumeric String--
DECLARE @entry VARCHAR(100) = 'as78sff56a7sf9dfg9d87fg6d'

DECLARE @answer VARCHAR(100) = ''

DECLARE @n INT = 1
WHILE @n <= LEN(@entry)
BEGIN
DECLARE @singlechar CHAR(1) = SUBSTRING(@entry, @n, 1)
IF @singlechar BETWEEN '0' AND '9'
BEGIN
SET @answer = @answer + @singlechar
END
SET @n = @n + 1
END
SELECT @answer AS only_numeric_values

---- using patindex method----

DECLARE @entry VARCHAR(100) = 'as78sff56a7sf9dfg9d87fg6d'

DECLARE @answer VARCHAR(100) = ''

DECLARE @n INT = 1
WHILE @n <= LEN(@entry)
BEGIN
DECLARE @singlechar CHAR(1) = SUBSTRING(@entry, @n, 1)
IF PATINDEX('%[0-9]%',@singlechar)>0
	BEGIN
		SET @answer = @answer + @singlechar
	END
SET @n = @n + 1
END
SELECT @answer AS only_numeric_values