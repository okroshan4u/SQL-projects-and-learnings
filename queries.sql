** sub queries **
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'London'),
(3, 'Charlie', 'Delhi'),
(4, 'Diana', 'Sydney');

INSERT INTO payments VALUES
(1, 1, 200.00, '2024-01-10'),
(2, 1, 150.00, '2024-01-15'),
(3, 2, 100.00, '2024-01-12'),
(4, 2, 50.00,  '2024-01-20'),
(5, 3, 300.00, '2024-01-18'),
(6, 4, 80.00,  '2024-01-22'),
(7, 4, 70.00,  '2024-01-25');

select * from Customers as c
join Payments as p
on c.customer_id = p.customer_id
where p.amount > (select avg(amount) from Payments)

** logical operator**

select * from Payments 
where payment_id IN (select customer_id from Customers)

** exits operator **
select customer_name, city from Customers as c
where EXISTS(
  select customer_id , amount from Payments as p
  where c.customer_id = p.customer_id
	and amount > 100
)


** window functions **
CREATE TABLE cat_sum(
    new_id INT,
    new_cat VARCHAR(20),
);


INSERT INTO cat_sum VALUES
(100, 'Agni'),
(200, 'Agni'),

(500, 'Dharti'),
(700, 'Dharti'),

(200, 'Vayu'),
(300, 'Vayu'),
(500, 'Vayu');


** without window fun **
select SUM(new_id) as sumId , new_cat from Category_summary
group by new_cat
order by new_id desc

** with window fun **

select new_id, new_cat, 
sum(new_id) over(partition by new_cat) as "Total",
avg(new_id) over(partition by new_cat) as "avg",
count(new_id) over (partition by new_cat) as "count",
min(new_id) over(partition by new_cat) as "MIN",
max(new_id) over(partition by new_cat) as "MAX"
from cat_sum


** or advanced version **
SELECT
    new_id,
    new_cat,
    SUM(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY new_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Total,
    AVG(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY new_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Average,
    COUNT(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY new_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Count,
    MIN(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY new_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Min,
    MAX(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY new_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Max
FROM cat_sum
ORDER BY new_cat, new_id;

**Rank Function **
select new_id,
row_number() over(order by new_id) as "Row number",
rank() over (order by new_id ) as "Rank",
dense_rank() over(order by new_id) as "Dense Rank",
percent_rank() over (order by new_id) as "percent rank"
from cat_sum

** analytic functions **

select new_id,
first_value(new_id) over(order by new_id) as "First value",
last_value(new_id) over(order by new_id) as "Last value",
lead(new_id) over(order by new_id) as "Lead",
lag(new_id) over (order by new_id) as "Lag"
from cat_sum

** with offset value **
select new_id,
first_value(new_id) over(order by new_id ) as "First value",
last_value(new_id) over(order by new_id) as "Last value",
lead(new_id,2) over(order by new_id) as "Lead",
lag(new_id,2) over (order by new_id) as "Lag"
from cat_sum

// here offset means if we take example of lead then setting offset 2 means go to the skit the next row and go for the the value next to next row and put on the lead column

here is the result of offset 2
on lead and lag both 

new_id	First value	Last value	Lead	Lag
100	100		100		200	
200	100		200		300	
200	100		200		500	100
300	100		300		500	200
500	100		500		700	200
500	100		500			300
700	100		700			500


*** CASE expression ***

CREATE TABLE customer_payments (
    customer_id BIGINT PRIMARY KEY,
    amount BIGINT,
    mode VARCHAR(50),
    payment_date DATE
);




INSERT INTO customer_payments (customer_id, amount, mode, payment_date) VALUES
(1, 60,  'Cash',          '2020-09-24'),
(10, 70, 'mobile Payment','2021-02-28'),
(11, 80, 'Cash',          '2021-03-01'),
(2, 500, 'Credit Card',   '2020-04-27'),
(8, 100, 'Cash',          '2021-01-26');

** case statement **

select *,
case 
when amount>100 then "expensive prd"
when amount = 100 then "moderate prd"
else "inexensive prd"
end as prdStatus from customer_payments


customer_id	amount	mode	payment_date	prdStatus
1	60	Cash	        2020-09-24	inexensive prd
10	70	mobile Payment	2021-02-28	inexensive prd
11	80	Cash		2021-03-01	inexensive prd
2	500	Credit Card	2020-04-27	expensive prd
8	100	Cash		2021-01-26	moderate prd

** case expression **

select *,
case amount
when 100 then "plus customer"
when 500 then "Prime Customer"
else "Regular customer"
end as custStatus from customer_payments


customer_id	amount	mode		payment_date	custStatus
1		60	Cash		2020-09-24	Regular customer
10		70	mobile Payment	2021-02-28	Regular customer
11		80	Cash		2021-03-01	Regular customer
2		500	Credit Card	2020-04-27	Prime Customer
8		100	Cash		2021-01-26	plus customer



** CTE **

CREATE TABLE payments (
    customer_id BIGINT PRIMARY KEY,
    amount BIGINT,
    mode VARCHAR(50),
    payment_date DATE
);

INSERT INTO payments (customer_id, amount, mode, payment_date) VALUES
(1, 60, 'Cash', '2020-09-24'),
(11, 80, 'Cash', '2021-03-01'),
(2, 500, 'Credit Card', '2020-04-27'),
(8, 100, 'Cash', '2021-01-26'),
(7, 20, 'Mobile Payment', '2021-02-01'),
(17, 250, 'Credit Card', '2021-04-01'),
(10, 70, 'Mobile Payment', '2021-02-28');



CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_id BIGINT
);


INSERT INTO customers (customer_id, first_name, last_name, address_id) VALUES
(1, 'Mary', 'Smith', 5),
(3, 'Linda', 'Williams', 7),
(4, 'Barbara', 'Jones', 8),
(2, 'Madan', 'Mohan', 6),
(17, 'R', 'Madhav', 9);


** basic example of CTE **
WITH my_cte as (
  select * , avg(amount) over(order by p.customer_id) as "avg",
count(address_id) over (order by c.customer_id ) as "count"
  from payments as p 
  inner join customers as c
  on p.customer_id = c.customer_id
) select first_name, last_name, amount from my_cte



** Intermediate cte **

CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_id BIGINT
);


INSERT INTO customers (customer_id, first_name, last_name, address_id) VALUES
(1, 'Mary', 'Smith', 5),
(3, 'Linda', 'Williams', 7),
(4, 'Barbara', 'Jones', 8),
(2, 'Madan', 'Mohan', 6),
(17, 'R', 'Madhav', 9);

CREATE TABLE address (
    address_id BIGINT PRIMARY KEY,
    address_line VARCHAR(100),
    city_id BIGINT,
    postal_code VARCHAR(20)
);

INSERT INTO address (address_id, address_line, city_id, postal_code) VALUES
(5, '123 Main Street', 101, '10001'),
(6, '45 Park Avenue', 102, '11002'),
(7, '78 Lake Road', 103, '22003'),
(8, '9 Hill View', 104, '33004'),
(9, '56 Green Street', 105, '44005');


CREATE TABLE country (
    city_id BIGINT PRIMARY KEY,
    city_name VARCHAR(50),
    country_name VARCHAR(50)
);


INSERT INTO country (city_id, city_name, country_name) VALUES
(101, 'New York', 'USA'),
(102, 'Mumbai', 'India'),
(103, 'London', 'UK'),
(104, 'Toronto', 'Canada'),
(105, 'Sydney', 'Australia');



with my_cp as (
  select * , avg(amount) over(order by p.customer_id) as "avg",
	count(address_id) over(order by c.customer_id) as "count"
  from payments as p 
  inner join customers as c
on p.customer_id = c.customer_id
),
my_ca as (
  select * from customers as c
inner join address as a
  on a.address_id = c.address_id
  inner join country as cc
on cc.city_id = a.city_id
)
select cp.first_name, cp.last_name , ca.city_name, ca.country_name, cp.amount
from my_ca as ca , my_cp as cp


** Advanced Example ** 
with my_cte as (
  select mode, max(amount) as highest_price , sum(amount) as total_price
  from payments as p
  group by mode
)
select p.*, my_cte.highest_price, my_cte.total_price
from Payments as p
join my_cte
on p.mode = my_cte.mode
order by p.mode


customer_id	amount	mode		payment_date	highest_price	total_price
1		60	Cash		2020-09-24	100		240
11		80	Cash		2021-03-01	100		240
8		100	Cash		2021-01-26	100		240
2		500	Credit Card	2020-04-27	500		750
17		250	Credit Card	2021-04-01	500		750
7		20	Mobile Payment	2021-02-01	70		90
10		70	Mobile Payment	2021-02-28	70		90


** Recursive CTE **
with recursive roshan as(
  select 0 as n
  union all
  select n+2 from roshan
  where n<20
)
select * from roshan

Output
n
0
2
4
6
8
10
12
14
16
18
20


** Intermediate Example **
CREATE TABLE employee (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INTEGER,
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
        REFERENCES employee(emp_id)
);

INSERT INTO employee (emp_id, emp_name, manager_id) VALUES
(1, 'Madhav', NULL),
(2, 'Sam', 1),
(3, 'Tom', 2),
(4, 'Arjun', 6),
(5, 'Shiva', 4),
(6, 'Keshav', 1),
(7, 'Damodar', 5);

Employee
emp_id	emp_name	manager_id
1	Madhav	
2	Sam		1
3	Tom		2
4	Arjun		6
5	Shiva		4
6	Keshav		1
7	Damodar		5


** Q ** Find the management chain (hierarchy) upwards for a given employee

with recursive EmpCTE as (
  select emp_id , emp_name,manager_id
  from employee
  where emp_id = 7
  union all
  select employee.emp_id , employee.emp_name , employee.manager_id
  from employee
  join EmpCTE
on employee.emp_id = EmpCTE.manager_id
)
select * from EmpCTE

emp_id	emp_name	manager_id
7	Damodar		5
5	Shiva		4
4	Arjun		6
6	Keshav		1
1	Madhav		null --> final boss


** going downwards means -- > Starting from a manager (say emp_id = 1), show all employees under them, at all levels, and show how deep they are in the hierarchy.**

WITH RECURSIVE EmpCTE AS (
    -- Anchor: start from the manager
    SELECT 
        emp_id,
        emp_name,
        manager_id,
        0 AS level
    FROM employee
    WHERE emp_id = 1

    UNION ALL

    -- Recursive: find subordinates
    SELECT 
        e.emp_id,
        e.emp_name,
        e.manager_id,
        c.level + 1 AS level
    FROM employee e
    JOIN EmpCTE c
        ON e.manager_id = c.emp_id
)
SELECT * 
FROM EmpCTE
ORDER BY level, emp_id;


**output**
Output
emp_id	emp_name	manager_id	level
1	Madhav				0
6	Keshav		1		1
2	Sam		1		1
4	Arjun		6		2
3	Tom		2		2
5	Shiva		4		3
7	Damodar		5		4	


