-- Question 1:
CREATE DATABASE ClassAssignment;

-- Use Database
USE ClassAssignment;

-- Question 2:
CREATE TABLE Project(
	project_num INT NOT NULL PRIMARY KEY,
    project_code CHAR(4),
	project_title VARCHAR(45), 
	first_name VARCHAR(45), 
	last_name VARCHAR(45),  
	project_budget DECIMAL(5,2) 
);

-- Question 3
ALTER TABLE Project DROP PRIMARY KEY, MODIFY project_num INT NOT NULL PRIMARY KEY AUTO_INCREMENT FIRST;
ALTER TABLE Project AUTO_INCREMENT=10;

-- Question 4
ALTER TABLE Project MODIFY project_budget DECIMAL(10,2); 

-- Question 5
INSERT INTO Project (project_code, project_title, first_name, last_name, project_budget) VALUES 
('PC01', 'DIA', 'John', 'Smith', 10000.99),
('PC02', 'CHF', 'Tim', 'Cook', 12000.50),
('PC03', 'AST', 'Rhonda', 'Smith', 8000.40);

-- Select statement for sanity check
-- SELECT * FROM Project;

-- Question 6
CREATE TABLE PayRoll(
	employee_num INT PRIMARY KEY AUTO_INCREMENT,
	job_id INT NOT NULL,
	job_desc VARCHAR(40), 
	emp_pay DECIMAL (10,2)
);

-- Question 7
	-- Part 1
	ALTER TABLE PayRoll ADD CONSTRAINT emp_pay CHECK (emp_pay > 10000);
    
    -- Part 2
    ALTER TABLE PayRoll MODIFY job_desc VARCHAR(40) DEFAULT 'Data Analyst';
    
    -- Part 3
    ALTER TABLE PayRoll ADD COLUMN pay_date DATE AFTER job_desc;
    
-- Sanity Check
-- SELECT * FROM PayRoll;

-- Question 8
ALTER TABLE PayRoll ADD FOREIGN KEY (job_id) REFERENCES Project(project_num);

-- Question 9
INSERT INTO PayRoll (job_id, pay_date, emp_pay) VALUES
	(10, CURRENT_DATE, 12000.99 ),
	(11, CURRENT_DATE, 14000.99 ),
	(12, CURRENT_DATE, 16000.99 );
    
-- Question 10
UPDATE PayRoll SET emp_pay = TRUNCATE(emp_pay *1.10,2) WHERE employee_num = 2;

-- Sanity Check Again
-- SELECT * FROM PayRoll;

-- Question 11
CREATE TABLE Project_backup AS SELECT * FROM Project WHERE last_name = 'Smith';

-- Another Sanity Check
SELECT * FROM Project_backup;

-- Question 12
CREATE VIEW PayRoll_View AS SELECT job_id, job_desc, pay_date FROM PayRoll WHERE job_id > 10;

-- Sanity Check
-- SELECT * FROM PayRoll_View;

-- Question 13
CREATE INDEX pay_date_idx ON PayRoll(pay_date);

-- Question 14
-- NOTE: Need to turn off safe mode for this :)
DELETE FROM Project_backup;

-- Question 15
-- DELETE FROM Project WHERE project_num = 10;

-- Errors: Error is as follows:
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`classassignment`.`payroll`, CONSTRAINT `payroll_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `project` (`project_num`))

-- This is because we are trying to delete the reference rather than trying to delete the original row, in order to delete this we'd have to delete the corresponding row in payroll first

-- Question 16
-- Setup Foreign Key With ON DELETE CASCADE so when you delete the child row, it deletes the parent row in the corresponding database
ALTER TABLE PayRoll DROP CONSTRAINT payroll_ibfk_1;
ALTER TABLE PayRoll ADD CONSTRAINT payroll_ibfk_1 FOREIGN KEY (job_id) REFERENCES project(project_num) ON DELETE CASCADE;
DELETE FROM Project WHERE project_num = 10;