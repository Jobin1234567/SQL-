CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    subject VARCHAR(100),
    experience INT,
    salary DECIMAL(10, 2)
);


INSERT INTO teachers (id, name, subject, experience, salary) VALUES
(1, 'John Doe', 'Mathematics', 5, 50000.00),
(2, 'Jane Smith', 'Science', 7, 55000.00),
(3, 'Michael Brown', 'History', 10, 60000.00),
(4, 'Emily Davis', 'English', 3, 45000.00),
(5, 'William Johnson', 'Physics', 8, 58000.00),
(6, 'Sophia Martinez', 'Chemistry', 12, 62000.00),
(7, 'James Anderson', 'Biology', 6, 52000.00),
(8, 'Olivia Taylor', 'Geography', 9, 57000.00);



select * from teachers;


DELIMITER $$ 
CREATE TRIGGER sbefore_insert_teacher
BEFORE INSERT ON teachers
FOR EACH ROW 
BEGIN 
IF NEW.salary < 0 THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative'; 
END IF;
END $$ 
DELIMITER ;

INSERT INTO teachers (id, name, subject, experience, salary)  VALUES (9,'jobin jose','DataScience',11,75000);
INSERT INTO teachers (id, name, subject, experience, salary)  VALUES (10,'JOSMY jose','AI',11,-75000);


CREATE TABLE teacher_log(
log_id INT PRIMARY KEY AUTO_INCREMENT,
teacher_id INT ,
action VARCHAR(50),
timestamp DATETIME
);

select * from teacher_log;

DELIMITER $$

CREATE TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, timestamp)
    VALUES (NEW.id, 'INSERT', NOW());
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN
    IF OLD.experience > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete a teacher with experience greater than 10 years';
    END IF;
END$$

DELIMITER ;

delete from teachers where id=9;

DELIMITER $$

CREATE TRIGGER after_delete_teacher
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, timestamp)
    VALUES (OLD.id, 'DELETE', NOW());
END$$

DELIMITER ;

delete from teachers where id=3;

select * from teacher_log;



