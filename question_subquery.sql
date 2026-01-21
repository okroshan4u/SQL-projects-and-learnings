** sub query **
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
	
percent_rank() over (order by new_id) as "percent rank"
from cat_sum


