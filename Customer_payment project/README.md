# 💳 Customer-Payment SQL Project

This project demonstrates how to create and manage **relational tables** in SQL — specifically, a `customer` table and a `payment` table with a **foreign key relationship**. It includes data insertion, updating, and joining operations.

---

## 🧾 Project Overview

The project covers:
- Creating `customer` and `payment` tables.
- Establishing a **foreign key** relationship between them.
- Performing **INSERT**, **SELECT**, **UPDATE**, and **INNER JOIN** operations.
- Viewing updated and joined data after modifications.

---

## 🗃️ Database Schema

### `customer` Table
| Column       | Type         | Description                 |
|---------------|--------------|-----------------------------|
| customerID    | INT (PK)     | Unique ID for each customer |
| first_name    | VARCHAR(50)  | Customer's first name       |
| last_name     | VARCHAR(50)  | Customer's last name        |
| address_id    | INT          | Address reference ID        |

### `payment` Table
| Column         | Type          | Description                         |
|----------------|---------------|-------------------------------------|
| paymentID      | INT (PK)      | Unique payment ID                   |
| customerID     | INT (FK)      | References `customer(customerID)`   |
| payment_mode   | VARCHAR(30)   | Mode of payment (UPI, Cash, etc.)   |
| date_of_payment| DATE          | Date of payment                     |
| amount         | DECIMAL(10,2) | Amount paid                         |

---

## ⚙️ Queries Used

### 🔹 Create Tables
```sql
CREATE TABLE customer(...);
CREATE TABLE payment(...);
```
### 🔹 Insert Data
```sql

INSERT INTO customer (customerID, first_name, last_name, address_id)
VALUES
(1, 'Roshan', 'kumar', 5),			
(2, 'Anshika', 'kumari', 4),
(3, 'Akash', 'Roy', 2),
(4, 'Ramu', 'kumar', 5),
(5, 'Meghana', 'shaw', 3);

INSERT INTO payment (paymentID, customerID, payment_mode, date, amount)
VALUES
(101, 1, 'UPI', '2025-10-10', 1200.50),
(102, 2, 'Credit Card', '2025-10-09', 850.00),
(103, 3, 'Cash', '2025-10-11', 500.00),
(104, 4, 'Debit Card', '2025-10-12', 950.75),
(105, 5, 'Net Banking', '2025-10-13', 2000.00);
```

### 🔹 Inner Join
```sql
SELECT * 
FROM customer AS c
INNER JOIN payment AS p
ON c.customerID = p.customerID;

```
This query joins the customer and payment tables based on their shared customerID, showing complete customer details along with their payments.

### 🔹 Update Records
```sql
UPDATE payment
SET payment_mode = 'Net Banking'
WHERE customerID = (
  SELECT customerID FROM customer WHERE first_name = 'Roshan' LIMIT 1
);

```
This updates Roshan’s payment mode to Net Banking.

### 🔹 View Updated Joined Table
```sql
SELECT * 
FROM customer AS c
INNER JOIN payment AS p
ON c.customerID = p.customerID;
```

Use this to see the updated record in the joined table.

🧠 Learning Outcome

By completing this project, you’ll understand:

How relational databases connect tables using foreign keys

How to perform joins to combine related data

How to update multiple records dynamically in SQL

🧑‍💻 Author

Roshan Kumar Ram
📧 okroshan4u@gmail.com

🔗 GitHub Profile
