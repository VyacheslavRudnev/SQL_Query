CREATE DATABASE New_Academy
GO
USE New_Academy

CREATE TABLE [Faculties]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_FName CHECK ([Name] != ''),
);

CREATE TABLE [Departments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[FacultyId] INT NOT NULL REFERENCES [Faculties]([Id]), 
	CONSTRAINT CHK_DPFinancing CHECK ([Financing] >= 0),
	CONSTRAINT CHK_DPName CHECK ([Name] != ''),
);

CREATE TABLE [Groups]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(10) NOT NULL UNIQUE,
	[Year] INT NOT NULL,
	[DepartmentId] INT NOT NULL REFERENCES [Departments]([Id]),
	CONSTRAINT CHK_GName CHECK ([Name] != ''),
	CONSTRAINT CHK_Year CHECK ([Year] BETWEEN 1 AND 5),
);

CREATE TABLE [Subjects]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_SName CHECK ([Name] != ''),
);

CREATE TABLE [Teachers]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(MAX) NOT NULL,
	[Salary] MONEY NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHK_TName CHECK ([Name] != ''),
	CONSTRAINT CHK_TSalary CHECK ([Salary] > 0),
	CONSTRAINT CHK_TSurname CHECK ([Surname] != ''),
);
CREATE TABLE [Lectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DayOfWeek] INT NOT NULL,
	[LectureRoom] NVARCHAR(MAX) NOT NULL,
	[SubjectId] INT NOT NULL REFERENCES [Subjects]([Id]),
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
	CONSTRAINT CHK_LLectureRoom CHECK ([LectureRoom] != ''),
	CONSTRAINT CHK_LDayOfWeek CHECK ([DayOfWeek] BETWEEN 1 AND 7),
);
CREATE TABLE [GroupsLectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
	[LectureId] INT NOT NULL REFERENCES [Lectures](Id),
);

INSERT INTO [Faculties] ([Name])
VALUES 
('Computer Science'),
('Engineering'),
('Information Technology'),
('Robotics'),
('Physics and Mathematics');

INSERT INTO [Departments] ([Financing], [Name], [FacultyId])
VALUES 
(40000, 'Software Engineering Department', 1),
(66000, 'Software Development Department', 1),
(81000, 'Data Science Department', 1),
(38000, 'Network Engineering Department', 1),

(45000, 'Electrical Systems Department', 2),
(47000, 'Control Systems Department', 2),
(43000, 'Mechatronics Department', 2),
(42000, 'Structural Engineering Department', 2),
(44000, 'Environmental Engineering Department', 2),

(49000, 'Information Systems Department', 3),
(46000, 'Cybersecurity Department', 3),
(48000, 'Artificial Intelligence Department', 3),

(46000, 'Robotics Engineering Department', 4),
(48000, 'Automation Engineering Department', 4),

(58000, 'Theoretical Physics Department', 5), 
(44000, 'Mathematical Analysis Department', 5),  
(70000, 'Quantum Mechanics Department', 5), 
(42000, 'Applied Mathematics Department', 5);

INSERT INTO [Groups] ([Name], [Year], [DepartmentId])
VALUES 
('SE101', 1, 1),
('SE102', 1, 1),
('SE301', 3, 1),
('DS201', 2, 2),
('DS401', 4, 2),
('DS402', 4, 2),
('NE201', 2, 3),
('NE301', 3, 3),
('NE402', 4, 3),
('NE501', 5, 3),
('E301', 3, 4),
('M401', 4, 6),
('M501', 5, 6),
('P107', 1, 9),
('P201', 2, 9),
('P301', 3, 9),
('P401', 4, 9),
('P501', 5, 9),
('CS102', 1, 10),
('CS103', 1, 10),
('CS104', 1, 10),
('CS201', 2, 10),
('CS202', 2, 10),
('CS204', 2, 10),
('AE302', 3, 13),
('AE401', 4, 13),
('MA101', 1, 15),
('MA301', 3, 15),
('MA501', 5, 15);
	
INSERT INTO [Subjects] ([Name])
VALUES 
('Mathematics'),
('Physics'),
('Computer Science'),
('Database Theory'),
('Software Engineering'),
('Data Science'),
('Network Engineering'),
('Electrical Systems'),
('Control Systems'),
('Thermal Engineering'),
('Mechatronics'),
('Information Systems'),
('Cybersecurity'),
('Structural Engineering'),
('Robotics Engineering'),
('Automation Engineering');

INSERT INTO [Teachers] ([Name], [Salary], [Surname])
VALUES 
('John', 55000, 'Smith'),
('Emily', 60000, 'Johnson'),
('William', 58000, 'Williams'),
('Olivia', 62000, 'Brown'),
('Michael', 59000, 'Jones'),
('Emma', 61000, 'Garcia'),
('Alexander', 60000, 'Martinez'),
('Samantha', 63000, 'Adams'), 
('Daniel', 57000, 'Anderson'),
('Ava', 59000, 'Taylor'),
('David', 60000, 'Thomas'),
('Mia', 61000, 'Moore'),
('James', 58000, 'Jackson'),
('Dave', 64000, 'McQueen'),
('Jack', 66000, 'Underhill');

INSERT INTO [Lectures] ([DayOfWeek], [LectureRoom], [SubjectId], [TeacherId])
VALUES
(1, 'A 101', 1, 1),
(2, 'A 102', 1, 1),
(1, 'A 201', 1, 2),
(3, 'A 202', 1, 2),
(2, 'B 101', 2, 3),
(3, 'B 102', 2, 3),
(4, 'C 101', 3, 4),
(4, 'C 102', 3, 5),
(5, 'C 103', 4, 4),
(6, 'C 104', 4, 5),
(1, 'C 105', 5, 4),
(2, 'C 201', 5, 5),
(3, 'C 202', 6, 6),
(4, 'C 203', 6, 7),
(5, 'C 204', 7, 6),
(1, 'C 205', 7, 7),
(2, 'D 101', 8, 8),
(3, 'D 102', 9, 8),
(4, 'D 103', 10, 8),
(5, 'D 201', 11, 9),
(6, 'D 202', 11, 9),
(7, 'E 101', 12, 10),
(1, 'E 102', 12, 11),
(2, 'F 103', 13, 10),
(3, 'F 104', 13, 11),
(4, 'G 101', 14, 12),
(5, 'G 102', 15, 13),
(1, 'G 103', 16, 13),
(2, 'A 101', 5, 14),
(3, 'A 102', 6, 15);

INSERT INTO [GroupsLectures] ([GroupId], [LectureId])
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 4),
(7, 4),
(8, 5),
(9, 6),
(10, 7),
(11, 8),
(12, 10),
(13, 12),
(14, 9),
(15, 11),
(16, 13),
(17, 14),
(18, 15),
(19, 16),
(20, 17),
(21, 18),
(22, 19),
(23, 20),
(24, 21),
(25, 22),
(26, 23),
(27, 24),
(28, 25),
(1, 26),
(2, 27),
(3, 28),
(4, 1),
(5, 2),
(6, 3),
(29, 4);

--Запити
--Тема: Функції агрегування
--1. Вивести кількість викладачів кафедри «Software Development».

SELECT COUNT(T.[Id]) AS 'Kількість викладачів'
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
JOIN [Departments] AS DP ON DP.[Id] = G.[DepartmentId]
WHERE DP.[Name] LIKE 'Software Development%'

--2. Вивести кількість лекцій, які читає викладач “Dave McQueen”.

SELECT COUNT(L.[Id]) AS 'Kількість лекцій'
FROM [Lectures] AS L
JOIN [Teachers] AS T ON T.[Id] = L.[TeacherId]
WHERE T.[Name] = 'Dave' AND T.[Surname] = 'McQueen'

--3. Вивести кількість занять, які проводяться в аудиторії “D201”.

SELECT COUNT(S.[Id]) AS 'кількість занять'
FROM [Subjects] AS S
JOIN [Lectures] AS L ON S.[Id] = L.[SubjectId]
WHERE L.[LectureRoom] = 'D 201'

--4. Вивести назви аудиторій та кількість лекцій, що прово-
--дяться в них.
SELECT L.[LectureRoom], COUNT(S.[Id]) AS 'Kількість лекцій'
FROM [Lectures] AS L
JOIN [Subjects] AS S ON S.[Id] = L.[SubjectId]
GROUP BY L.[LectureRoom]

--5. Вивести кількість студентів, які відвідують лекції викла-
--дача “Jack Underhill”.
----------- Запит 5 неможливо виконати/перевірити, дані з кількістю студентів в групах відсутні в базі взагалі --------------
			--SELECT COUNT(St.[Id])
			--FROM [Students] AS St
			--JOIN [Groups] AS G ON St.[Id] = G.[StudentId]
			--JOIN [GroupsLectures] AS GL ON G.[Id] = GL.[GroupId]
			--JOIN [Lectures] AS L ON L.[Id] = GL.[LectureId]
			--JOIN [Teachers] AS T ON T.[Id] = L.[TeacherId]
			--WHERE T.[Name] = 'Jack' AND T.[Surname] = 'Underhill'

--6. Вивести середню ставку викладачів факультету Computer
--Science.

SELECT AVG(t.[Salary]) AS 'Cередня ставка'
FROM [Teachers] AS t
JOIN [Lectures] AS l ON t.[Id] = l.[TeacherId]
JOIN [GroupsLectures] AS gl ON l.[Id] = gl.[LectureId]
JOIN [Groups] AS g ON g.[Id] = gl.[GroupId]
JOIN [Departments] AS dp ON dp.[Id] = g.[DepartmentId]
JOIN [Faculties] AS f ON f.[Id] = dp.[FacultyId]
WHERE f.[Name] = 'Computer Science'

--7. Вивести мінімальну та максимальну кількість студентів
--серед усіх груп.
----------- Запит 7 неможливо виконати/перевірити, дані з кількістю студентів в групах відсутні в базі взагалі --------------
			SELECT MAX(NumberOfStudents) AS 'Max', MIN(NumberOfStudents) AS 'Min'
			FROM (
				SELECT COUNT(*) AS NumberOfStudents
				FROM [Students] AS S
				JOINT [GroupStudents] AS GS ON S.[Id] = GS.[StudentId]
				JOIN [Group] AS G ON G.[Id] = GS.[GroupId]
				GROUP BY G.[Name]
			) AS StudentCount

--8. Вивести середній фонд фінансування кафедр.

SELECT AVG(d.[Financing]) AS 'середній фонд фінансування кафедр'
FROM [Departments] AS d

--9. Вивести повні імена викладачів та кількість читаних ними
--дисциплін.

SELECT T.[Name] +' '+ T.[Surname] AS 'Викладач', COUNT(S.[Id]) AS 'Кількість дисциплин'
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [Subjects] AS S ON S.[Id] = L.[SubjectId]
GROUP BY T.[Name], T.[Surname]

--10. Вивести кількість лекцій щодня протягом тижня.

SELECT COUNT(L.[Id]) AS 'Кількість лекцій', L.[DayOfWeek] AS 'День тижня'
FROM [Lectures] AS L 
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
GROUP BY L.[DayOfWeek] 

--11. Вивести номери аудиторій та кількість кафедр, чиї лекції
--в них читаються.

SELECT L.[LectureRoom] AS 'Номер аудиторії', COUNT(DP.[Id]) AS 'Кількість кафедр'
FROM [Lectures] AS L
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
JOIN [Departments] AS DP ON DP.[Id] = G.[DepartmentId]
GROUP BY L.[LectureRoom]

--12. Вивести назви факультетів та кількість дисциплін, які на
--них читаються.

SELECT F.[Name] AS 'Назва факультету', COUNT(S.[Id]) AS 'Кількість дисциплін'
FROM [Faculties] AS F
JOIN [Departments] AS DP ON F.[Id] = DP.[FacultyId]
JOIN [Groups] AS G ON DP.[Id] = G.[DepartmentId]
JOIN [GroupsLectures] AS GL ON G.[Id] = GL.[GroupId]
JOIN [Lectures] AS L ON L.[Id] = GL.[LectureId]
JOIN [Subjects] AS S ON S.[Id] = L.[SubjectId]
GROUP BY F.[Name]

--13. Вивести кількість лекцій для кожної пари викладач-ау-
--диторія.

SELECT T.[Name]+' '+ T.[Surname] AS 'Викладач', L.[LectureRoom] AS 'Аудиторія', COUNT(L.[Id])
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
Group BY T.[Name], T.[Surname], L.[LectureRoom]




SELECT * FROM [Faculties]
SELECT * FROM [Departments]
SELECT * FROM [Groups]
SELECT * FROM [Subjects]
SELECT * FROM [Teachers]
SELECT * FROM [Lectures]
SELECT * FROM [GroupsLectures]

DELETE [Faculties]
DELETE [Departments]
DELETE [Groups]
DELETE [Subjects]
DELETE [Teachers]
DELETE [Lectures]
DELETE [GroupsLectures]

DROP TABLE [Faculties]
DROP TABLE [Departments]
DROP TABLE [Groups]
DROP TABLE [Subjects]
DROP TABLE [Teachers]
DROP TABLE [Lectures]
DROP TABLE [GroupsLectures]