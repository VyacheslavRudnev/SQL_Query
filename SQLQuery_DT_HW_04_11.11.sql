CREATE DATABASE New_Academy
GO
USE New_Academy

CREATE TABLE [Curators]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(MAX) NOT NULL, 
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHK_CName CHECK ([Name] != ''),
	CONSTRAINT CHK_CSurname CHECK ([Surname] != ''),
);

CREATE TABLE [Faculties]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_FFinancing CHECK ([Financing] >= 0),
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

CREATE TABLE [GroupsCurators]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[CuratorId] INT NOT NULL REFERENCES [Curators]([Id]),
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
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
	CONSTRAINT CHK_Salary CHECK ([Salary] > 0),
	CONSTRAINT CHK_TSurname CHECK ([Surname] != ''),
);
CREATE TABLE [Lectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[LectureRoom] NVARCHAR(MAX) NOT NULL,
	[SubjectId] INT NOT NULL REFERENCES [Subjects]([Id]),
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
	CONSTRAINT CHK_LectureRoom CHECK ([LectureRoom] != ''),
);
CREATE TABLE [GroupsLectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
	[LectureId] INT NOT NULL REFERENCES [Lectures](Id),
);

INSERT INTO [Curators] ([Name], [Surname])
VALUES 
('Liam', 'Anderson'),
('Sophia', 'Martinez'),
('Ethan', 'Nguyen'),
('Olivia', 'Garcia'),
('Lucas', 'Kim'),
('Aria', 'Chen');

INSERT INTO [Faculties] ([Financing], [Name])
VALUES 
(60000, 'Faculty of Computer Science'),
(70000, 'Faculty of Engineering'),
(80000, 'Faculty of Information Technology'),
(56000, 'Faculty of Robotics'),
(64000, 'Faculty of Physics and Mathematics');


INSERT INTO [Departments] ([Financing], [Name], [FacultyId])
VALUES 
(40000, 'Software Engineering Department', 1),
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
	

INSERT INTO [GroupsCurators] ([CuratorId], [GroupId])
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(4, 11),
(5, 12),
(5, 13),
(6, 14),
(6, 15),
(6, 16),
(6, 17),
(6, 18),
(1, 19),
(1, 20),
(1, 21),
(2, 22),
(2, 23),
(2, 24),
(3, 25),
(3, 26),
(4, 27),
(4, 28),
(4, 29);


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
('James', 58000, 'Jackson');

INSERT INTO [Lectures] ([LectureRoom], [SubjectId], [TeacherId])
VALUES
('A 101', 1, 1),
('A 102', 1, 1),
('A 201', 1, 2),
('A 202', 1, 2),
('B 101', 2, 3),
('B 102', 2, 3),
('C 101', 3, 4),
('C 102', 3, 5),
('C 103', 4, 4),
('C 104', 4, 5),
('C 105', 5, 4),
('C 201', 5, 5),
('C 202', 6, 6),
('C 203', 6, 7),
('C 204', 7, 6),
('C 205', 7, 7),
('D 101', 8, 8),
('D 102', 9, 8),
('D 103', 10, 8),
('D 201', 11, 9),
('D 202', 11, 9),
('E 101', 12, 10),
('E 102', 12, 11),
('F 103', 13, 10),
('F 104', 13, 11),
('G 101', 14, 12),
('G 102', 15, 13),
('G 103', 16, 13);

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
--Тема: Багатотабличні бази даних
--1. Вивести всі можливі пари рядків викладачів та груп.

SELECT T.[Name] + ' ' +T.[Surname] AS 'Викладач', G.[Name] AS 'Назва групи'
FROM [Teachers] AS T, [Groups] AS G, [Lectures] AS L, [GroupsLectures] AS GL
WHERE T.[Id] = L.[TeacherId] AND G.[Id] = GL.[GroupId] AND L.[Id] = GL.[LectureId];
	-- варіант 2 --
	SELECT T.[Name] + ' ' +T.[Surname] AS 'Викладач', G.[Name] AS 'Назва групи'
	FROM [Teachers] AS T
	JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
	JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
	JOIN [Groups] AS G ON G.[Id] = GL.[GroupId];

--2. Вивести назви факультетів, фонд фінансування кафедр
--яких перевищує фонд фінансування факультету.

SELECT F.[Name] AS 'Назва факультету', F.[Financing] AS 'Фонд факультету', DP.[Financing] AS 'Фонд кафедри'
FROM [Faculties] AS F
JOIN [Departments] AS DP ON F.[Id] = DP.[FacultyId]
WHERE DP.[Financing] > F.[Financing]

--3. Вивести прізвища кураторів груп та назви груп, які вони
--курирують.

SELECT C.[Surname] AS 'Прізвище куратора', G.[Name] AS 'Назва групи'
FROM [Curators] AS C
JOIN [GroupsCurators] AS GC ON C.[Id] = GC.[CuratorId]
JOIN [Groups] AS G ON G.[Id] = GC.[GroupId]

--4. Вивести імена та прізвища викладачів, які читають лекції
--у групі “P107”.

SELECT T.[Name] + '' + T.[Surname]
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.LectureId
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
WHERE G.[Name] = 'P107'

--5. Вивести прізвища викладачів та назви факультетів, на яких
--вони читають лекції.

SELECT DISTINCT T.[Surname] AS 'Викладач', F.[Name] AS 'Факультет'
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
JOIN [Departments] AS D ON D.[Id] = G.[DepartmentId]
JOIN [Faculties] AS F ON F.[Id] = D.[FacultyId]

--6. Вивести назви кафедр та назви груп, які до них належать.

SELECT DP.[Name] AS 'Кафедра', G.[Name] AS 'Група'
FROM [Departments] AS DP
JOIN[Groups] AS G ON DP.[Id] = G.[DepartmentId]

--7. Вивести назви дисциплін, які читає викладач “Samantha
--Adams”.
SELECT S.[Name] AS 'Дисципліна'
FROM [Subjects] AS S
JOIN [Lectures] AS L ON S.[Id] = L.[SubjectId]
JOIN [Teachers] AS T ON T.[Id] = L.[TeacherId]
WHERE T.[Name] = 'Samantha' AND T.[Surname] = 'Adams'

--8. Вивести назви кафедр, де читається дисципліна “Database
--Theory”.

SELECT DP.[Name] AS 'Кафедра'
FROM [Departments] AS DP
JOIN [Groups] AS G ON DP.[Id] = G.[DepartmentId]
JOIN [GroupsLectures] AS GL ON G.[Id] = GL.[GroupId]
JOIN [Lectures] AS L ON L.[Id] = GL.[LectureId]
JOIN [Subjects] AS S ON S.[Id] = L.[SubjectId]
WHERE S.[Name] = 'Database Theory'

--9. Вивести назви груп, що належать до факультету Computer
--Science.

SELECT G.[Name] AS 'Група' 
FROM [Groups] AS G
JOIN [Departments] AS DP ON DP.[Id] = G.[DepartmentId]
JOIN [Faculties] AS F ON F.[Id] = DP.[FacultyId]
WHERE F.[Name] LIKE '%Computer Science'

--10. Вивести назви груп 5-го курсу, а також назву факультетів,
--до яких вони належать.

SELECT G.[Name] AS 'Група' 
FROM [Groups] AS G
JOIN [Departments] AS DP ON DP.[Id] = G.[DepartmentId]
JOIN [Faculties] AS F ON F.[Id] = DP.[FacultyId]
WHERE G.[Year] = 5

--11. Вивести повні імена викладачів та лекції, які вони чита-
--ють (назви дисциплін та груп), причому відібрати лише ті
--лекції, що читаються в аудиторії “B102”.

SELECT T.[Name] + ' ' + T.[Surname] AS 'Викладач', S.[Name] AS 'Дисципліна', G.[Name] AS 'Група'
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [Subjects] AS S ON S.[Id] = L.[SubjectId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
WHERE L.[LectureRoom] = 'B 102'