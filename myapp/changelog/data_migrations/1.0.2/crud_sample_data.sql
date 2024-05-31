INSERT INTO departments (department_name) VALUES 
('Development'),
('Human Resources'),
('Marketing'),
('Finance');

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2020-01-15', 'DEV', 60000.00, NULL, 1),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '2019-03-23', 'HR', 75000.00, NULL, 2),
('Robert', 'Brown', 'robert.brown@example.com', '345-678-9012', '2021-11-04', 'DEV', 50000.00, 1, 1),
('Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', '2018-07-19', 'MKT', 55000.00, NULL, 3),
('Michael', 'Wilson', 'michael.wilson@example.com', '567-890-1234', '2020-02-12', 'FIN', 70000.00, 2, 4),
('Jessica', 'Taylor', 'jessica.taylor@example.com', '678-901-2345', '2019-09-30', 'HR', 68000.00, 2, 2),
('David', 'Anderson', 'david.anderson@example.com', '789-012-3456', '2017-12-21', 'DEV', 75000.00, 3, 1),
('Sarah', 'Thomas', 'sarah.thomas@example.com', '890-123-4567', '2021-05-10', 'MKT', 60000.00, NULL, 3),
('James', 'Martinez', 'james.martinez@example.com', '901-234-5678', '2018-04-14', 'FIN', 72000.00, 4, 4),
('Laura', 'Hernandez', 'laura.hernandez@example.com', '012-345-6789', '2020-06-09', 'DEV', 58000.00, 1, 1),
('Chris', 'Moore', 'chris.moore@example.com', '123-456-7890', '2019-01-25', 'HR', 65000.00, 2, 2),
('Ashley', 'Jackson', 'ashley.jackson@example.com', '234-567-8901', '2017-11-18', 'MKT', 70000.00, NULL, 3),
('Brian', 'White', 'brian.white@example.com', '345-678-9012', '2021-08-07', 'FIN', 75000.00, 5, 4),
('Emma', 'Harris', 'emma.harris@example.com', '456-789-0123', '2018-03-02', 'DEV', 64000.00, 3, 1),
('Daniel', 'Martin', 'daniel.martin@example.com', '567-890-1234', '2019-06-15', 'HR', 68000.00, 2, 2),
('Olivia', 'Lee', 'olivia.lee@example.com', '678-901-2345', '2020-10-22', 'MKT', 60000.00, NULL, 3),
('Matthew', 'Walker', 'matthew.walker@example.com', '789-012-3456', '2017-09-12', 'FIN', 70000.00, 6, 4),
('Sophia', 'Hall', 'sophia.hall@example.com', '890-123-4567', '2018-12-05', 'DEV', 75000.00, 1, 1),
('Andrew', 'Allen', 'andrew.allen@example.com', '901-234-5678', '2021-03-28', 'HR', 72000.00, 2, 2),
('Ava', 'Young', 'ava.young@example.com', '012-345-6789', '2020-07-19', 'MKT', 68000.00, NULL, 3);
