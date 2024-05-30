--- 3. Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results ----
create table error(id int identity(1,1),
					name varchar(20),
					salary int,
					error_col as (salary/0));
INSERT into error values ('rithvik',20000);

select *from error;
select error_col from error;
select id,name,salary from error;