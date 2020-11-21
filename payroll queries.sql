#UC1
CREATE DATABASE payroll_service;
SHOW DATABASES;
USE payroll_service;
SELECT DATABASE();

#UC2
CREATE TABLE employee_payroll
(	EmployeeId	INT unsigned NOT NULL AUTO_INCREMENT,
	EmployeeName	VARCHAR(150) NOT NULL,
    Salary	Double NOT NULL,
    StartDate	DATE NOT NULL,
    PRIMARY KEY	(EmployeeID)
);
DESCRIBE employee_payroll;

#UC3
INSERT INTO employee_payroll (EmployeeName,Salary,StartDate) VALUES
('Bill',1000000.00,'2018-01-03'),
('Terrisa',2000000.00,'2019-11-13'),
('Charlie',3000000.00,'2020-05-21'),
('Gunjan',4000000.00,'2019-07-10');

#UC4
SELECT * FROM employee_payroll;

#UC5
SELECT Salary FROM employee_payroll WHERE EmployeeName = 'Bill';
SELECT * FROM employee_payroll 
WHERE StartDate BETWEEN CAST('2019-01-01' AS DATE) AND DATE(NOW());

#UC6
ALTER TABLE employee_payroll ADD Gender CHAR(1) AFTER EmployeeName;
UPDATE employee_payroll SET Gender = 'M'
WHERE EmployeeName = 'Bill' OR EmployeeName = 'Charlie';
UPDATE employee_payroll SET Gender = 'F'
WHERE EmployeeName = 'Terrisa' OR EmployeeName = 'Gunjan';

#UC7
SELECT SUM(Salary) FROM employee_payroll
WHERE Gender = 'F' GROUP BY Gender;
SELECT Gender,SUM(Salary) FROM employee_payroll GROUP BY Gender;
SELECT Gender,AVG(Salary) FROM employee_payroll GROUP BY Gender;
SELECT Gender,MIN(Salary) FROM employee_payroll GROUP BY Gender;
SELECT Gender,MAX(Salary) FROM employee_payroll GROUP BY Gender;
SELECT Gender,COUNT(EmployeeName) FROM employee_payroll GROUP BY Gender;

#UC8
ALTER TABLE employee_payroll ADD PhoneNumber VARCHAR(15) AFTER EmployeeName;
ALTER TABLE employee_payroll ADD Address VARCHAR(255) DEFAULT 'Mumbai' AFTER PhoneNumber;
ALTER TABLE employee_payroll ADD Department VARCHAR(20) NOT NULL AFTER Address;
SELECT * FROM employee_payroll;

#UC9
ALTER TABLE employee_payroll CHANGE COLUMN Salary BasicPay DOUBLE NOT NULL;
ALTER TABLE employee_payroll ADD Deductions DOUBLE NOT NULL AFTER BasicPay;
ALTER TABLE employee_payroll ADD TaxablePay DOUBLE NOT NULL AFTER Deductions;
ALTER TABLE employee_payroll ADD IncomeTax DOUBLE NOT NULL AFTER TaxablePay;
ALTER TABLE employee_payroll ADD NetPay DOUBLE NOT NULL AFTER IncomeTax;

#UC10
UPDATE employee_payroll SET PhoneNumber = '9876543210' ,Department='Sales',
Deductions=1000000.00, TaxablePay=1000000.00 ,IncomeTax=500000.00 ,NetPay=500000.00
WHERE EmployeeName = 'Terrisa';
INSERT INTO employee_payroll(EmployeeName,PhoneNumber,Address,Department,Gender,BasicPay,Deductions,
TaxablePay,IncomeTax,NetPay,StartDate) VALUES
('Terrisa','9876543210','Mumbai','Marketing','F',2000000.00,1000000.00,1000000.00,500000.00,500000.00,'2019-11-13');

#UC11
CREATE TABLE payroll_details (
    EmployeeId INT UNSIGNED NOT NULL,
    BasicPay DOUBLE NOT NULL,
    Deductions DOUBLE NOT NULL,
    TaxablePay DOUBLE NOT NULL,
    IncomeTax DOUBLE NOT NULL,
    NetPay DOUBLE NOT NULL,
    FOREIGN KEY	(EmployeeId)
    REFERENCES employee_payroll(EmployeeId)
		ON DELETE CASCADE
);
INSERT INTO payroll_details (EmployeeId,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay)
SELECT DISTINCT EmployeeId,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM employee_payroll;
SELECT * FROM payroll_details;
SELECT * FROM employee_payroll;
ALTER TABLE employee_payroll DROP COLUMN BasicPay,
DROP COLUMN Deductions,
DROP COLUMN TaxablePay,
DROP COLUMN IncomeTax,
DROP COLUMN NetPay;

CREATE TABLE department (
	DepartmentId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    DepartmentName varchar(20) NOT NULL,
    PRIMARY KEY	(DepartmentId)
);
INSERT INTO department(DepartmentName) VALUES
('Sales'),
('Marketing');
SELECT * FROM department;
ALTER TABLE employee_payroll DROP COLUMN Department;

CREATE TABLE employee_department (
	EmployeeId INT UNSIGNED NOT NULL,
	DepartmentId INT UNSIGNED NOT NULL,
    PRIMARY KEY(EmployeeId,DepartmentId),
    FOREIGN KEY	(EmployeeId)
    REFERENCES employee_payroll(EmployeeId)
		ON DELETE CASCADE,
	FOREIGN KEY	(DepartmentId)
    REFERENCES department(DepartmentId)
		ON DELETE CASCADE
);
SELECT * FROM employee_department;
INSERT INTO employee_department(EmployeeId,DepartmentId) VALUES
(1,1),
(2,1),
(2,2),
(3,1),
(4,2);
DELETE FROM employee_payroll WHERE EmployeeId = 5;

#UC12
SELECT * FROM employee_payroll;
SELECT BasicPay FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId and EmployeeName='Bill';
SELECT Gender,SUM(BasicPay) FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId GROUP BY Gender;
SELECT Gender,AVG(BasicPay) FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId GROUP BY Gender;
SELECT Gender,MIN(BasicPay) FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId GROUP BY Gender;
SELECT Gender,MAX(BasicPay) FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId GROUP BY Gender;
SELECT Gender,COUNT(EmployeeName) FROM payroll_details p, employee_payroll e WHERE e.EmployeeId=p.EmployeeId GROUP BY Gender;

