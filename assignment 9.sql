USE ENTRI_D42;

CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT,
    JoiningDate DATETIME,
    Department CHAR(25)
);

INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES
(1, 'John', 'Doe', 50000, '2023-01-01', 'HR'),
(2, 'Jane', 'Smith', 60000, '2022-03-15', 'Finance'),
(3, 'William', 'Johnson', 70000, '2021-05-20', 'IT'),
(4, 'Emma', 'Brown', 75000, '2020-11-01', 'Marketing'),
(5, 'Liam', 'Jones', 80000, '2019-08-25', 'Sales'),
(6, 'Olivia', 'Miller', 65000, '2023-06-10', 'HR'),
(7, 'Noah', 'Davis', 72000, '2022-09-14', 'Finance'),
(8, 'Sophia', 'Garcia', 68000, '2021-12-20', 'IT'),
(9, 'James', 'Martinez', 78000, '2018-07-19', 'Marketing'),
(10, 'Isabella', 'Rodriguez', 82000, '2017-04-22', 'Sales');

DELIMITER $$

CREATE PROCEDURE AddWorker (
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END $$

DELIMITER ;

CALL AddWorker(11, 'Alex', 'Brown', 55000, '2023-02-01', 'Engineering');

select * from worker;

CALL AddWorker(12, 'Olivia', 'Miller', 65000, '2023-06-10', 'HR');


DELIMITER $$

CREATE PROCEDURE GetWorkerSalary (
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
END $$

DELIMITER ;

CALL GetWorkerSalary(6, @salary);
SELECT @salary;




DELIMITER $$

CREATE PROCEDURE UPDATE_DEPARTMENT(IN P_WORKER_ID INT , IN P_DEPARTMENT VARCHAR(20))
BEGIN 

UPDATE WORKER SET Department =P_DEPARTMENT WHERE Worker_Id = P_WORKER_ID;
END $$
DELIMITER ;

CALL UPDATE_DEPARTMENT (3,'Finance');
SELECT * FROM WORKER;



DELIMITER $$
CREATE PROCEDURE WORKER_COUNT(IN p_DEPARTMENT VARCHAR(20),p_worker_count int)
BEGIN 
SELECT COUNT(*) INTO p_worker_count FROM WORKER WHERE Department = P_DEPARTMENT;
END $$
DELIMITER ;

CALL WORKER_COUNT('Finance',@WORKERCOUNT);
SELECT @WORKERCOUNT; 



DELIMITER $$
CREATE PROCEDURE AVG_SALARY(IN P_DEPARTMENT VARCHAR(20),OUT p_avg_Salary double )
BEGIN
SELECT AVG(SALARY) INTO p_avg_salary FROM WORKER WHERE  DEPARTMENT =P_DEPARTMENT ;
END $$
DELIMITER ;

CALL AVG_SALARY('Finance',@AVG_SALARY);
SELECT @AVG_SALARY;
