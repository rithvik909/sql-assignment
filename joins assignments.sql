------ joins assignment----
create table departments_a(dept_id int primary key, depat_name varchar(20))
create table employee_a (e_id int primary key ,e_name varchar(20),dept_id int foreign key references departments_a(dept_id),hire_date date)
create table salaries_a (e_id int foreign key references employee_a(e_id),salary int,salary_date date)

-- Insert data into departments_a
INSERT INTO departments_a (dept_id, depat_name) VALUES (1, 'HR');
INSERT INTO departments_a (dept_id, depat_name) VALUES (2, 'IT');
INSERT INTO departments_a (dept_id, depat_name) VALUES (3, 'Finance');

-- Insert data into employee_a
INSERT INTO employee_a (e_id, e_name, dept_id, hire_date) VALUES (1, 'Alice', 1, '2020-01-15');
INSERT INTO employee_a (e_id, e_name, dept_id, hire_date) VALUES (2, 'Bob', 2, '2019-03-10');
INSERT INTO employee_a (e_id, e_name, dept_id, hire_date) VALUES (3, 'Charlie', 3, '2018-07-22');
INSERT INTO employee_a (e_id, e_name, dept_id, hire_date) VALUES (5, 'jhon', 3, '2021-10-01');

-- Insert data into salaries_a
INSERT INTO salaries_a (e_id, salary, salary_date) VALUES (1, 50000, '2022-01-01');
INSERT INTO salaries_a (e_id, salary, salary_date) VALUES (2, 60000, '2022-01-01');
INSERT INTO salaries_a (e_id, salary, salary_date) VALUES (3, 70000, '2022-01-01');
INSERT INTO salaries_a (e_id, salary, salary_date) VALUES (5, 35000, '2022-01-01')


select * from employee_a
select * from departments_a
select * from salaries_a

select e.e_id, e.e_name,d.depat_name, s.salary from employee_a e join departments_a d on e.dept_id=d.dept_id 
													join salaries_a s on s.e_id=e.e_id

------ 2nd join----
create table category_a(category_id int primary key ,category_name varchar(20))
create table products_a(product_id int primary key,product_name varchar(20),cat_id int foreign key references category_a(category_id),price int)
create table orders_a(order_id int,product_id int foreign key references products_a(product_id),quantity int,order_date date)

-- Insert data into category_a
INSERT INTO category_a (category_id, category_name) VALUES (1, 'Electronics');
INSERT INTO category_a (category_id, category_name) VALUES (2, 'Clothing');
INSERT INTO category_a (category_id, category_name) VALUES (3, 'Groceries');

-- Insert data into products_a
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (1, 'Laptop', 1, 1000);
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (2, 'Smartphone', 1, 800);
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (3, 'T-Shirt', 2, 20);
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (4, 'Jeans', 2, 40);
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (5, 'Apples', 3, 5);
INSERT INTO products_a (product_id, product_name, cat_id, price) VALUES (6, 'Milk', 3, 2);

-- Insert data into orders_a
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (1, 1, 2, '2023-01-15');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (1, 3, 5, '2023-01-15');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (9, 2, 6, '2024-05-10');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (9, 5, 5, '2024-05-10');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (8, 4, 7, '2024-05-05');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (8, 6, 4, '2024-05-05');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (7, 3, 2, '2024-05-10');
INSERT INTO orders_a (order_id, product_id, quantity, order_date) VALUES (7, 1, 8, '2024-05-10');


select * from category_a
select * from products_a
select * from orders_a

------Write a SQL query to find out the total revenue generated from each category in the last month.---

select c.category_id, sum(p.price*o.quantity) as TOTAL_revenue from category_a as c join products_a as p on p.cat_id=c.category_id 
							join orders_a as o on o.product_id=p.product_id 
							where datepart(month,o.order_date)=(datepart(month,getdate())-1) group by c.category_id

------- 3rd joins------
create table authors_a(author_id int primary key,author_name varchar(20),author_country varchar(20))
create table books_a (book_id int primary key,book_title varchar(20),author_id int foreign key references authors_a(author_id),publication_date date)
create table borrowers_a (borrowers_id int ,book_id int foreign key references books_a(book_id),borrower_name varchar(20),borrower_date date,return_date date)

-- Insert data into authors_a
INSERT INTO authors_a (author_id, author_name, author_country) VALUES (1, 'Jane Austen', 'UK');
INSERT INTO authors_a (author_id, author_name, author_country) VALUES (2, 'Mark Twain', 'USA');
INSERT INTO authors_a (author_id, author_name, author_country) VALUES (3, 'Haruki Murakami', 'Japan');

-- Insert data into books_a
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (1, 'Pride and Prejudice', 1, '1813-01-28');
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (2, 'Adventure of li', 2, '1884-12-10');
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (3, 'Norwegian Wood', 3, '1987-09-04');
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (4, 'Pride', 1, '1813-01-28');
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (5, 'values', 2, '1884-12-10');
INSERT INTO books_a (book_id, book_title, author_id, publication_date) VALUES (6, 'fire Wood', 3, '1987-09-04');

-- Insert data into borrowers_a
INSERT INTO borrowers_a (borrowers_id, book_id, borrower_name, borrower_date, return_date) VALUES (1, 1, 'Alice Johnson', '2023-01-01', '2023-01-15');
INSERT INTO borrowers_a (borrowers_id, book_id, borrower_name, borrower_date, return_date) VALUES (2, 2, 'Bob Smith', '2023-02-01', '2023-02-15');
INSERT INTO borrowers_a (borrowers_id, book_id, borrower_name, borrower_date, return_date) VALUES (3, 3, 'Charlie Brown', '2023-03-01', '2023-03-15');
INSERT INTO borrowers_a (borrowers_id, book_id, borrower_name, borrower_date, return_date) VALUES (4, 4, 'rithvik', '2023-01-01', '2023-01-15');
INSERT INTO borrowers_a (borrowers_id, book_id, borrower_name, borrower_date, return_date) VALUES (5, 5, 'puri', '2023-02-01', '2023-02-15');

select * from books_a
select * from authors_a
select * from borrowers_a

select a.author_name,b.book_title,d.borrower_name,d.borrower_date,d.return_date from authors_a a join books_a b on a.author_id=b.author_id
						left outer join borrowers_a d on d.book_id=b.book_id


----- 4th join-------

CREATE TABLE studentki (
  student_id INT PRIMARY KEY,student_name VARCHAR(255),student_major VARCHAR(255));
 
CREATE TABLE courses (
  course_id INT PRIMARY KEY,course_name VARCHAR(255),course_department VARCHAR(255));
 
CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,student_id INT,course_id INT,enrollment_date DATE,FOREIGN KEY (student_id) REFERENCES studentki(student_id),FOREIGN KEY (course_id) REFERENCES courses(course_id));
 
CREATE TABLE grades (
  grade_id INT PRIMARY KEY,enrollment_id INT,grade_value DECIMAL(3,2),FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id));

INSERT INTO studentki (student_id, student_name, student_major)
VALUES (1, 'John Doe', 'Computer Science'),
       (2, 'Jane Smith', 'Mathematics'),
       (3, 'Mike Johnson', 'Physics'),
       (4, 'Alice Williams', 'Biology'),
       (5, 'Bob Brown', 'Chemistry');
 
INSERT INTO courses (course_id, course_name, course_department)
VALUES (1, 'Calculus I', 'Mathematics'),
       (2, 'Introduction to Computer Science', 'Computer Science'),
       (3, 'Introduction to Physics', 'Physics'),
       (4, 'Introduction to Biology', 'Biology'),
       (5, 'Introduction to Chemistry', 'Chemistry');
 
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (1, 1, 1, '2024-06-01'),
       (2, 1, 2, '2024-06-01'),
       (3, 2, 1, '2024-06-01'),
       (4, 3, 3, '2024-06-01'),
       (5, 4, 4, '2024-06-01'),
       (6, 5, 5, '2024-06-01'),
       (7, 1, 2, '2024-09-01'),
       (8, 2, 1, '2024-09-01'),
       (9, 3, 3, '2024-09-01'),
       (10, 4, 4, '2024-09-01'),
       (11, 5, 5, '2024-09-01');
 
INSERT INTO grades (grade_id, enrollment_id, grade_value)
VALUES (1, 1, 8.2),
       (2, 2, 8.2),
       (3, 3, 7.9),
       (4, 4, 9),
       (5, 5, 7.9),
       (6, 7, 8.8),
       (7, 8, 9.2),
       (8, 9, 7.8),
       (9, 10, 8.2),
       (10, 11, 8.2);
----Write a SQL query to calculate the average grade for each course.----
select c.course_department,avg(g.grade_value) from enrollments e join studentki s on s.student_id=e.student_id 
																	join courses c on c.course_id=e.course_id 
																	join grades g on g.enrollment_id=e.enrollment_id 
																	group by course_department



---- 5th join ----
create table customer_a(cust_id int primary key ,cust_name varchar(20),cust_country varchar(20))
create table product_a(pro_id int primary key ,pro_name varchar(20),pro_price int)
create table order_a (order_id int ,cust_id int foreign key references customer_a(cust_id),pro_id int foreign key references product_a(pro_id),order_date date,order_quantity int)

insert into customer_a values (1,'rithvik','india'),
								(2,'rakhi','india'),
								(3,'puri','us'),
								(4,'vijay','us'),
								(5,'punneth','uk'),
								(6,'srinivas','uk')
insert into product_a values(1,'laptop',10000),
							(2,'t-shrit',200),
							(3,'cup',300),
							(4,'phone',7000),
							(5,'gun',2000)
insert into order_a values(1,1,1,'2024-05-02',3),
							(2,2,2,'2024-05-02',4),
							(3,3,3,'2024-05-02',13),
							(4,4,4,'2024-05-02',9),
							(5,5,5,'2024-05-02',30),
							(6,6,1,'2024-05-02',2)

------Write a SQL query to find out the total revenue generated from customers in each country.---------
select c.cust_country,sum(p.pro_price*o.order_quantity) from order_a o join customer_a c on c.cust_id=o.cust_id join product_a p on p.pro_id=o.pro_id group by c.cust_country


