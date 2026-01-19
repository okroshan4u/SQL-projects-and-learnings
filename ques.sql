create table customer(
  id int Primary key,
  name varchar(50),
  payment_amount int,
  payment_date Date
payment_type varchar(50)

)

alter table customer
add payment_type varchar(50)

insert into customer values
(101, 'Rahul Sharma', 2500.00, '2025-01-10', 'Credit Card'),
(102, 'Anita Verma', 1800.50, '2025-01-12', 'Debit Card'),
(103, 'Karan Singh', 3200.00, '2025-01-15', 'Cash'),
(104, 'Pooja Mehta', 1500.00, '2025-01-18', 'Credit Card'),
(105, 'Amit Patel', 4000.00, '2025-01-20', 'Debit Card');


update  customer
set payment_amount = 4500
where id = 105


select AVG(payment_amount) from customer

-- 1. Find customers who paid more than the average payment amount

select * from customer
where payment_amount >(
 select AVG(payment_amount) from customer
) 

-- 2. Find customers who made the highest payment
select * from customer
where payment_amount =(
  select max(payment_amount) 
	from customer

)


select * from customer
where payment_amount > (
  select min(payment_amount)
  from customer
)



-- 3. Find customers who used the same payment type as customer_id = 101
select * from customer
where payment_type = (
  select payment_type from customer
where id = 101

)

	-- 4. Find customers who made a payment on the latest payment date
select * from customer
where payment_date = (
  select Max(payment_date)
from customer
)




create table customer_2 (
  customer_id INT,
  first_name varchar(50),
  last_name varchar(50),
address_id  int
)

select * from customer_2


insert into customer_2 values
(1, 'Rahul', 'Sharma', 101),
(2, 'Anita', 'Verma', 102),
(3, 'Karan', 'Singh', 108),
(4, 'Pooja', 'Mehta', 107),
(5, 'Amit', 'Patel', 109);

select * from customer
where id in (select address_id from customer_2)




