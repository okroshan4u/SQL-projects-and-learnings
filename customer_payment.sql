-- Create Customer Tabl
CREATE TABLE customer(
  customerID INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  address_id INT
);

-- Insert Data into Customer Table
INSERT INTO customer(customerID, first_name, last_name, address_id)
VALUES
(1, 'Roshan', 'kumar', 5),
(2, 'Anshika', 'kumari', 4),
(3, 'Akash', 'Roy', 2),
(4, 'Ramu', 'kumar', 5),
(5, 'Meghana', 'shaw', 3);

-- Create Payment Table
CREATE TABLE payment(
  paymentID INT PRIMARY KEY,
  customerID INT,
  payment_mode VARCHAR(30),
  date_of_payment DATE,
  amount DECIMAL(10,2),
  FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

-- Insert Data into Payment Table
INSERT INTO payment(paymentID, customerID, payment_mode, date_of_payment, amount)
VALUES
(101, 1, 'UPI', '2025-10-10', 1200.50),
(102, 2, 'Credit Card', '2025-10-09', 850.00),
(103, 3, 'Cash', '2025-10-11', 500.00),
(104, 4, 'Debit Card', '2025-10-12', 950.75),
(105, 5, 'Net Banking', '2025-10-13', 2000.00);

-- View Tables
SELECT * FROM customer;
SELECT * FROM payment;

-- Inner Join Example
SELECT 
  c.customerID,
  c.first_name,
  c.last_name,
  p.payment_mode,
  p.amount,
  p.date_of_payment
FROM customer AS c
INNER JOIN payment AS p
ON c.customerID = p.customerID;

-- Update Payment Mode Example
UPDATE payment 
SET payment_mode = 'Net Banking'
WHERE customerID = (
  SELECT customerID FROM customer WHERE first_name = 'Roshan'
);

