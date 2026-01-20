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
