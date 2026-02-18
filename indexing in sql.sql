CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees (id, first_name, last_name, department, salary) VALUES
(1, 'John', 'Smith', 'IT', 60000),
(2, 'Sarah', 'Johnson', 'HR', 55000),
(3, 'Mike', 'Smith', 'Finance', 70000),
(4, 'Emily', 'Davis', 'IT', 65000),
(5, 'James', 'Brown', 'Marketing', 50000),
(6, 'Linda', 'Smith', 'IT', 72000);


SELECT * 
FROM employees 
WHERE last_name = 'Smith';


CREATE INDEX idx_lastname
ON employees(last_name);


SELECT * 
FROM employees 
WHERE last_name = 'Smith';

