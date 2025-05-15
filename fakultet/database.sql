-- Kreiranje baze fakultet
CREATE DATABASE IF NOT EXISTS fakultet;
USE fakultet;

-- Tabela student
CREATE TABLE IF NOT EXISTS student (
    sno INT PRIMARY KEY,
    sname VARCHAR(32),
    level INT
);

-- Tabela course
CREATE TABLE IF NOT EXISTS course (
    cno INT PRIMARY KEY,
    title VARCHAR(64),
    lname VARCHAR(32)
);

-- Tabela report (ocene)
CREATE TABLE IF NOT EXISTS report (
    sno INT,
    cno INT,
    mark INT,
    PRIMARY KEY (sno, cno),
    FOREIGN KEY (sno) REFERENCES student(sno),
    FOREIGN KEY (cno) REFERENCES course(cno)
);

-- Tabela lecturer
CREATE TABLE IF NOT EXISTS lecturer (
    lname VARCHAR(32) PRIMARY KEY,
    roomno INT
);

-- Unos podataka u student
INSERT INTO student (sno, sname, level)
VALUES
(856434, 'Cairns', 3),
(864532, 'Burns', 1),
(876421, 'Hughes', 2),
(876543, 'Jones', 2);

-- Unos podataka u course
INSERT INTO course (cno, title, lname)
VALUES
(121, 'Compilers', 'Holt'),
(216, 'Database Systems', 'Black'),
(251, 'Numerical Analysis', 'Quinn'),
(312, 'Software Engineering', 'Welsh');

-- Unos podataka u lecturer
INSERT INTO lecturer (lname, roomno)
VALUES
('Black', 1017),
('Holt', 2014),
('Quinn', 1010),
('Welsh', 1024);

-- Unos podataka u report
INSERT INTO report (sno, cno, mark)
VALUES
(856434, 121, 49),
(864532, 121, 78),
(864532, 216, 75),
(864532, 312, 69),
(876421, 312, 79),
(876543, 216, 82),
(876543, 251, 70);
