-- assginments 2nd question----
create table test( id int identity(1,1), name_1 varchar(20),dob date);
insert into test values
('rithvik',2002-08-21),
('puri',2005-04-21),
('vijay',2001-09-21),
('srinivas',2000-02-21);

select id, name_1, datediff(year,dob,getdate()) as age from test;