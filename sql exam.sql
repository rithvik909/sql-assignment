--------------------------------1st question------------------------------------

create table cit(id int,name varchar(25),ccode varchar(3) primary key,pop int);

create table country(ccode varchar(3) foreign key references cit(ccode),continent varchar(10) primary key);

insert into cit values(1,'a',123,222);
insert into cit values(2,'b',124,232);
insert into cit values(3,'c',125,242);

insert into country values(123,'aa');
insert into country values(124,'ab');
insert into country values(125,'cc');

select sum(c.pop) as population from cit c join country ct on c.ccode=ct.ccode where ct.continent='aa';


select sum(c.pop) as population from cit c 
where c.ccode in (select ccode from country where continent = 'aa');




------------------------------ 2nd question-----------------------------------------

CREATE TABLE country (
    code VARCHAR(3) PRIMARY KEY,
    name VARCHAR(44),
    continent VARCHAR(13)
);

CREATE TABLE city (
    id INT PRIMARY KEY,
    name VARCHAR(17),
    countrycode VARCHAR(3),
    population INT,
    FOREIGN KEY (countrycode) REFERENCES country(code)
);

INSERT INTO country (code, name, continent) VALUES
('IND', 'India', 'Asia'),
('CHN', 'China', 'Asia'),
('USA', 'United States', 'North America'),
('BRA', 'Brazil', 'South America'),
('FRA', 'France', 'Europe');

INSERT INTO city (id, name, countrycode, population) VALUES
(1, 'Mumbai', 'IND', 20411000),
(2, 'Delhi', 'IND', 16787941),
(3, 'Shanghai', 'CHN', 24183300),
(4, 'Beijing', 'CHN', 21707000),
(5, 'New York', 'USA', 8804190),
(6, 'Los Angeles', 'USA', 3980400),
(7, 'Sao Paulo', 'BRA', 12325232),
(8, 'Rio de Janeiro', 'BRA', 6748000),
(9, 'Paris', 'FRA', 2140526),
(10, 'Marseille', 'FRA', 870018);


SELECT
    c.continent,
    round(cast(avg(ct.population)as decimal(10,2)),0) AS avg_population
FROM
    country c
JOIN
    city ct ON c.code = ct.countrycode
GROUP BY
    c.continent;

------

SELECT
    c.continent,
    floor(avg(ct.population)) as avg_population
FROM
    country c
JOIN
    city ct ON c.code = ct.countrycode
GROUP BY
    c.continent;


---------------------------

with continentpopulations as (
    select
        c.continent,
        ct.population
    from
        country c
    join
        city ct on c.code = ct.countrycode
)
select
    continent,
    floor(avg(population)) as avg_population
from
    continentpopulations
group by
    continent;




---------------------------------3rd question--------------------------------------------

 
 CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Marks INT
);

CREATE TABLE Grades (
    Grade INT PRIMARY KEY,
    Min_Mark INT,
    Max_Mark INT
);


INSERT INTO Students (ID, Name, Marks) VALUES
(1, 'Alice', 85),
(2, 'Bob', 92),
(3, 'Charlie', 67),
(4, 'David', 53),
(5, 'Eve', 48),
(6, 'Frank', 75),
(7, 'Grace', 32),
(8, 'Hank', 25),
(9, 'Ivy', 15),
(10, 'Jack', 5);

INSERT INTO Grades (Grade, Min_Mark, Max_Mark) VALUES
(1, 0, 2),
(2, 3, 19),
(3, 20, 29),
(4, 30, 39),
(5, 40, 49),
(6, 50, 59),
(7, 60, 69),
(8, 70, 79),
(9, 80, 89),
(10, 90, 100);


select 
    case 
        when g.grade < 8 then 'null'
        else s.name 
    end as name,
    g.grade,
    s.marks
from students s
join grades g
on s.marks between g.min_mark and g.max_mark
order by 
    g.grade desc,
    case 
        when g.grade >= 8 then s.name
        else null
    end asc,
    case
        when g.grade < 8 then s.marks
        else null
    end asc;


with studentgrades as (
    select 
        s.name,
        g.grade,
        s.marks,
        case 
            when g.grade < 8 then 'null'
            else s.name 
        end as display_name
    from students s
    join grades g
    on s.marks between g.min_mark and g.max_mark
)
select display_name as name, grade, marks from studentgrades
order by grade desc,
    case 
        when grade >= 8 then display_name
        else null
    end asc,
    case
        when grade < 8 then marks
        else null
    end asc;



----------------------------4th question----------------------------------------

CREATE TABLE Hackertable (
    hacker_id INTEGER PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Hackertable (hacker_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

CREATE TABLE Difficultytable (
    challenge_id INTEGER PRIMARY KEY,
    difficulty_level INTEGER
);

INSERT INTO Difficultytable (challenge_id, difficulty_level) VALUES
(101, 5),
(102, 3),
(103, 7),
(104, 2);

CREATE TABLE Submissions (
    submission_id INTEGER PRIMARY KEY,
    hacker_id INTEGER,
    challenge_id INTEGER,
    score INTEGER
);

INSERT INTO Submissions (submission_id, hacker_id, challenge_id, score) VALUES
(1, 1, 101, 5),
(2, 1, 102, 3),
(3, 1, 103, 7),
(4, 2, 101, 5),
(5, 2, 102, 3),
(6, 3, 101, 5),
(7, 3, 103, 7),
(8, 3, 104, 2),
(9, 4, 101, 5),
(10, 4, 102, 3),
(11, 4, 103, 7);


WITH FullScoreCounts AS (
    SELECT hacker_id, COUNT(DISTINCT s.challenge_id) AS num_full_scores
    FROM Submissions s
    JOIN Difficultytable d ON s.challenge_id = d.challenge_id
    WHERE s.score = d.difficulty_level
    GROUP BY hacker_id
    HAVING COUNT(DISTINCT s.challenge_id) > 1
)
SELECT h.hacker_id, h.name
FROM Hackertable h
JOIN FullScoreCounts f ON h.hacker_id = f.hacker_id
ORDER BY f.num_full_scores DESC, h.hacker_id ASC;


----------------------------------

SELECT h.hacker_id, h.name
FROM Hackertable h
JOIN (
    SELECT s.hacker_id, COUNT(DISTINCT s.challenge_id) AS num_full_scores
    FROM Submissions s
    JOIN Difficultytable d ON s.challenge_id = d.challenge_id
    WHERE s.score = d.difficulty_level
    GROUP BY s.hacker_id
    HAVING COUNT(DISTINCT s.challenge_id) > 1
) AS full_scores ON h.hacker_id = full_scores.hacker_id
ORDER BY full_scores.num_full_scores DESC, h.hacker_id ASC;



--------------------------6th question-----------------------------------------------------------

with cte as 
(select hacker_id,sum(score) as total from submissions group by hacker_id)
select h.hacker_id,h.name,c.total from hacker as h join cte as c on h.hacker_id=c.hacker_id order by total desc,hacker_id

select h.hacker_id,h.name,sum(c.score) as total from hacker as h 
														join submissions as c on h.hacker_id=c.hacker_id 
															group by h.hacker_id,h.name order by total desc,hacker_id;


--------------------------------7th question-------------------------------------------------


CREATE TABLE Odr (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

INSERT INTO Odr (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(3001, 270.65, '2012-10-05', 3005, 5001),
(3002, 65.26, '2012-09-10', 3001, 70002),
(3003, 948.50, '2012-09-10', 3005, 5002),
(3004, 2400.60, '2012-07-27', 3007, 5001),
(3005, 5760.00, '2012-09-10', 3002, 5001),
(3006, 1983.43, '2012-10-10', 3004, 5006),
(3007, 2480.40, '2012-10-10', 3009, 5003),
(3008, 250.45, '2012-06-27', 3008, 5002),
(3009, 75.29, '2012-08-17', 3003, 5007),
(3010, 3045.60, '2012-04-25', 3002, 5001);


CREATE TABLE Custo (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT
);

INSERT INTO Custo (customer_id, cust_name, city, grade, salesman_id) VALUES
(3001, 'Brad Guzan', 'London', 100, 5005),
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3003, 'Jozy Altidor', 'Moncow', 200, 5007),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3008, 'Julian Green', 'London', 300, 5002),
(3009, 'Geoff Camero', 'Berlin', 100, 5003);

with ordersums as (
    select
        ord_date,
        sum(purch_amt) as total_amount,
        max(purch_amt) as max_amount
    from odr group by ord_date
)
select
    ord_date,
    total_amount
from ordersums where total_amount >= max_amount + 1000.00;


-------------------

alter table odr add maxi as (purch_amt+1000);

select * from (
select ord_date,sum(purch_amt) as sumo,max(maxi) as maxd from odr group by ord_date) as table1
where sumo>maxd




--------------------------8th question--------------------------------------------------------

create table emp_department(dpt_code int, dpt_name varchar(20), dpt_allotment int,  primary key(dpt_code))
insert into emp_department values
( 57,'IT',65000),
(63,'Finance',15000),
(47,'HR', 240000),
(27,'RD', 55000),
(89,'QC',75000)

create table emp_details(emp_idno int,emp_fname varchar(20),emp_lname varchar(20),emp_dept int,primary key(emp_idno),
foreign key(emp_dept) references emp_department(dpt_code))
insert into emp_details values
(127323,'Michale','Robbin',57)
,(526689,'Carlos','Snares',63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);

with cte as(
select *,
dense_rank() OVER (order by d.dpt_allotment) as dept_rank 
from emp_department d
)
SELECT 
    e.emp_fname,
    e.emp_lname
FROM 
    emp_details e
JOIN 
    cte c ON e.emp_dept = c.dpt_code
WHERE 
    dept_rank = 2;

