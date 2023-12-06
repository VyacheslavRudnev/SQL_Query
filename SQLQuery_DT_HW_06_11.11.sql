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
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_FName CHECK ([Name] != ''),
);

CREATE TABLE [Departments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[FacultyId] INT NOT NULL REFERENCES [Faculties]([Id]), 
	CONSTRAINT CHK_DPFinancing CHECK ([Financing] >= 0),
	CONSTRAINT CHK_DPName CHECK ([Name] != ''),
	CONSTRAINT CHK_DPBuilding CHECK ([Building] BETWEEN 1 AND 5),
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
	[IsProfessor] BIT NOT NULL DEFAULT(0),
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
	[Date] DATE NOT NULL,
	[LectureRoom] NVARCHAR(MAX) NOT NULL,
	[SubjectId] INT NOT NULL REFERENCES [Subjects]([Id]),
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
	CONSTRAINT CHK_LLectureRoom CHECK ([LectureRoom] != ''),
	CONSTRAINT CHK_LDate CHECK ([Date] <= GETDATE()),
);

CREATE TABLE [GroupsLectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
	[LectureId] INT NOT NULL REFERENCES [Lectures](Id),
);

CREATE TABLE [Students]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(MAX) NOT NULL,
	[Rating] INT NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHK_StName CHECK ([Name] != ''),
	CONSTRAINT CHK_StRating CHECK ([Rating] BETWEEN 0 AND 5),
	CONSTRAINT CHK_StSurname CHECK ([Surname] != ''),
);

CREATE TABLE [GroupsStudents]
(	
	[Id] INT PRIMARY KEY IDENTITY,
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
	[StudentId] INT NOT NULL REFERENCES [Students]([Id]),
);

INSERT INTO [Curators] ([Name], [Surname])
VALUES 
('Liam', 'Anderson'),
('Sophia', 'Martinez'),
('Ethan', 'Nguyen'),
('Olivia', 'Garcia'),
('Lucas', 'Kim'),
('Aria', 'Chen');

INSERT INTO [Faculties] ([Name])
VALUES 
('Computer Science'),
('Engineering'),
('Information Technology'),
('Robotics'),
('Physics and Mathematics');

INSERT INTO [Departments] ([Building], [Financing], [Name], [FacultyId])
VALUES 
(1, 40000, 'Software Engineering Department', 1),
(3, 66000, 'Software Development Department', 1),
(5, 81000, 'Data Science Department', 1),
(1, 38000, 'Network Engineering Department', 1),

(2, 45000, 'Electrical Systems Department', 2),
(2, 47000, 'Control Systems Department', 2),
(2, 43000, 'Mechatronics Department', 2),
(2, 42000, 'Structural Engineering Department', 2),
(2, 44000, 'Environmental Engineering Department', 2),

(3, 49000, 'Information Systems Department', 3),
(3, 46000, 'Cybersecurity Department', 3),
(3, 48000, 'Artificial Intelligence Department', 3),

(4, 46000, 'Robotics Engineering Department', 4),
(4, 48000, 'Automation Engineering Department', 4),

(5, 58000, 'Theoretical Physics Department', 5), 
(5, 44000, 'Mathematical Analysis Department', 5),  
(5, 70000, 'Quantum Mechanics Department', 5), 
(5, 42000, 'Applied Mathematics Department', 5);

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
('MA501', 5, 15),
('D221', 2, 4);
	
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

INSERT INTO [Teachers] ([IsProfessor], [Name], [Salary], [Surname])
VALUES 
(1, 'John', 55000, 'Smith'),
(0, 'Emily', 60000, 'Johnson'),
(1, 'William', 58000, 'Williams'),
(0, 'Olivia', 62000, 'Brown'),
(0, 'Michael', 59000, 'Jones'),
(1, 'Emma', 61000, 'Garcia'),
(0, 'Alexander', 60000, 'Martinez'),
(0, 'Samantha', 63000, 'Adams'), 
(0, 'Daniel', 57000, 'Anderson'),
(1, 'Ava', 59000, 'Taylor'),
(0, 'David', 60000, 'Thomas'),
(0, 'Mia', 61000, 'Moore'),
(0, 'James', 58000, 'Jackson'),
(0, 'Dave', 64000, 'McQueen'),
(1, 'Jack', 66000, 'Underhill');

INSERT INTO [Lectures] ([Date], [LectureRoom], [SubjectId], [TeacherId])
VALUES
('2023-10-02', 'A 101', 1, 1),
('2023-10-03', 'A 102', 1, 1),
('2023-10-04', 'A 201', 1, 2),
('2023-10-05', 'A 202', 1, 2),
('2023-10-06', 'B 101', 2, 3),
('2023-10-02', 'B 102', 2, 3),
('2023-10-03', 'C 101', 3, 4),
('2023-10-04', 'C 102', 3, 5),
('2023-10-05', 'C 103', 4, 4),
('2023-10-06', 'C 104', 4, 5),
('2023-10-02', 'C 105', 5, 4),
('2023-10-09', 'C 201', 5, 5),
('2023-10-10', 'C 202', 6, 6),
('2023-10-11', 'C 203', 6, 7),
('2023-10-12', 'C 204', 7, 6),
('2023-10-12', 'C 205', 7, 7),
('2023-10-06', 'D 101', 8, 8),
('2023-10-09', 'D 102', 9, 8),
('2023-10-02', 'D 103', 10, 8),
('2023-10-09', 'D 201', 11, 9),
('2023-10-10', 'D 202', 11, 9),
('2023-10-03', 'E 101', 12, 10),
('2023-10-03', 'E 102', 12, 11),
('2023-10-13', 'F 103', 13, 10),
('2023-10-16', 'F 104', 13, 11),
('2023-10-17', 'G 101', 14, 12),
('2023-10-16', 'G 102', 15, 13),
('2023-10-18', 'G 103', 16, 13),
('2023-10-19', 'A 101', 5, 14),
('2023-10-20', 'A 102', 6, 15);

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
(29, 5),
(30, 6),
(1, 26),
(2, 27),
(3, 28),
(4, 1),
(5, 2),
(6, 3);

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
(4, 29),
(5, 30);

INSERT INTO [Students] ([Name], [Rating], [Surname])
VALUES
('Ethan', 0, 'Adams'),
('Mia', 1, 'Turner'),
('Carter', 2, 'Foster'),
('Harper', 3, 'Bryant'),
('Evelyn', 4, 'Collins'),
('Sebastian', 5, 'Hayes'),
('Chloe', 0, 'Murphy'),
('Lincoln', 1, 'Rivera'),
('Scarlett', 1, 'Long'),
('Lucas', 2, 'Myers'),
('Aria', 2, 'Graham'),
('Owen', 3, 'Sullivan'),
('Grace', 4, 'Dixon'),
('Gabriel', 0, 'Ward'),
('Aurora', 0, 'Ramirez'),
('Eliana', 0, 'Carter'),
('Grayson', 1, 'Ellis'),
('Stella', 1, 'Powell'),
('Levi', 1, 'Gordon'),
('Zoey', 2, 'Alexander'),
('Hazel', 3, 'Wallace'),
('Xavier', 2, 'Bennett'),
('Penelope', 2, 'Coleman'),
('Leo', 3, 'Richardson'),
('Bella', 3, 'Hughes'),
('Elijah', 3, 'Taylor'),
('Nova', 3, 'Parker'),
('William', 4, 'Wood'),
('Emilia', 4, 'Brooks'),
('Mason', 5, 'James'),
('Everly', 5, 'Nelson'),
('Nathan', 0, 'King'),
('Riley', 0, 'Mitchell'),
('Audrey', 0, 'Perry'),
('Logan', 1, 'Foster'),
('Madelyn', 1, 'Campbell'),
('Jack', 1, 'Cox'),
('Paisley', 1, 'Rivera'),
('Daniel', 2, 'Ward'),
('Ariana', 3, 'Price'),
('Joshua', 3, 'Jenkins'),
('Brooklyn', 2, 'Butler'),
('Liam', 2, 'Hill'),
('Addison', 3, 'Foster'),
('Samuel', 2, 'Flores'),
('Ellie', 2, 'Bryant'),
('John', 2, 'Campbell'),
('Lily', 4, 'Rogers'),
('Christopher', 3, 'Peterson'),
('Hannah', 3, 'Ward'),
('Andrew', 3, 'Rivera'),
('Adeline', 3, 'Scott'),
('Brayden', 4, 'Carter'),
('Lillian', 4, 'Stewart'),
('Julian', 5, 'Reed'),
('Sarah', 4, 'Simmons'),
('Dominic', 4, 'Edwards'),
('Violet', 0, 'Bell'),
('Wyatt', 0, 'Martinez'),
('Isabelle', 0, 'Diaz'),
('Zachary', 0, 'Parker'),
('Clara', 0, 'Hughes'),
('Michael', 0, 'Richardson'),
('Sophie', 1, 'Morgan'),
('Isaac', 1, 'Gray'),
('Paisley', 2, 'Reed'),
('Alexander', 3, 'Hughes'),
('Hazel', 2, 'Griffin'),
('Evan', 1, 'Butler'),
('Nora', 1, 'Long'),
('Jordan', 1, 'Foster'),
('Elena', 1, 'Henderson'),
('Owen', 1, 'Lewis'),
('Savannah', 2, 'Perez'),
('Lincoln', 2, 'Sanders'),
('Arianna', 2, 'Baker'),
('Samuel', 2, 'Turner'),
('Quinn', 2, 'Hayes'),
('Eliana', 3, 'Murphy'),
('Mateo', 3, 'Peterson'),
('Emery', 2, 'Bell'),
('Anthony', 1, 'Russell'),
('Eliza', 1, 'Diaz'),
('Theodore', 2, 'Wright'),
('Scarlett', 2, 'Thompson'),
('Ezra', 0, 'Nelson'),
('Naomi', 0, 'Myers'),
('Nolan', 0, 'Mitchell'),
('Ruby', 2, 'Coleman'),
('David', 2, 'Griffin'),
('Kaylee', 2, 'Bryant'),
('Christian', 3, 'Cox'),
('Amelia', 3, 'Richardson'),
('Christopher', 3, 'Powell'),
('Harper', 3, 'Hayes'),
('Leo', 3, 'Alexander'),
('Lucy', 2, 'Foster'),
('Jaxon', 2, 'Ward'),
('Isla', 1, 'Collins'),
('Isaac', 4, 'Wood');

INSERT INTO [GroupsStudents] ([GroupId], [StudentId])
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2,7),
(2,8),
(2,9),
(2,10),
(3,11),
(3,12),
(3,13),
(3,14),
(4,15),
(4,16),
(4,17),
(4,18),
(5,19),
(5,20),
(5,21),
(5,22),
(5,23),
(5,24),
(5,25),
(6,26),
(6,27),
(6,28),
(6,29),
(7,30),
(7,31),
(7,32),
(7,33),
(30,34),
(30,35),
(30,36),
(8,37),
(8,38),
(8,39),
(9,40),
(9,41),
(9,42),
(9,43),
(10,44),
(10,45),
(10,46),
(10,47),
(11,48),
(11,49),
(11,50),
(12,51),
(12,52),
(29,53),
(29,54),
(12,55),
(12,56),
(13,57),
(13,58),
(28,59),
(28,60),
(14,61),
(14,62),
(14,63),
(14,64),
(27,65),
(27,66),
(15,67),
(15,68),
(15,69),
(16,70),
(16,71),
(16,72),
(17,73),
(17,74),
(17,75),
(26,76),
(26,77),
(18,78),
(18,79),
(18,80),
(18,81),
(25,82),
(25,83),
(19,84),
(19,85),
(20,86),
(20,87),
(20,88),
(21,89),
(24,90),
(21,91),
(21,92),
(22,93),
(22,94),
(22,95),
(23,96),
(23,97),
(23,98),
(23,99),
(24,100);

--Запити Тема: Підзапити

--1. Вивести номери корпусів, якщо сумарний фонд фінансу-
--вання розташованих у них кафедр перевищує 100 000.
SELECT D.[Building] AS 'Номер корпусу', [TotalFinancing] AS 'Сумарний фонд фінансуівання'
FROM (
	SELECT DP.[Building], SUM(DP.[Financing]) AS [TotalFinancing]
	FROM [Departments] AS DP
	GROUP BY DP.[Building]
) AS D
WHERE [TotalFinancing] > 100000

--2. Вивести назви груп 5-го курсу кафедри “Software Development”,
--які мають понад 10 пар на перший тиждень.
------- для цього запиту немає даних в таблицях ------- в теорії буде якось так?
	SELECT G.[Name] AS 'Назва групи'
	FROM [Groups] AS G
	JOIN [Departments] AS DP ON G.[DepartmentId] = DP.[Id]
	JOIN [Schedules] AS SC ON SC.[LectureId] IN 
	(
		SELECT GL.[LectureId]
		FROM [GroupsLectures] AS GL
		WHERE GL.[GroupId] = G.[Id]
		)
	WHERE G.[Year] = 5
	AND DP.[Name] = 'Software Development'
	AND SC.[DayOfWeek] = 1
	GROUP BY G.[Name]
	HAVING COUNT(*) > 10;

--3. Вивести назви груп, які мають рейтинг (середній рейтинг
--усіх студентів групи) більший, ніж рейтинг групи “D221”.
SELECT GR.[Name] AS 'Назва групи', AVG(ST.[Rating]) AS 'Рейтинг групи'
FROM [Groups] AS GR
JOIN [GroupsStudents] AS GS ON GR.[Id] = GS.[GroupId]
JOIN [Students] AS ST ON ST.[Id] = GS.[StudentId]
GROUP BY GR.[Name]
HAVING AVG(ST.[Rating]) > 
(
	SELECT AVG(S.[Rating]) 
	FROM [Students] AS S 
	JOIN [GroupsStudents] AS GSt ON S.[Id] = GSt.[StudentId]
	JOIN [Groups] AS GR ON GR.[Id] = Gst.[GroupId]
	WHERE GR.[Name] IN ('D221')
)
	
--4. Вивести прізвища та імена викладачів, ставка яких вища
--за середню ставку професорів.

SELECT T.[Surname] + ' ' + T.[Name] AS 'Викладач', T.[Salary] AS 'Ставка'
FROM [Teachers] AS T
WHERE T.[Salary] >
(
	SELECT AVG(T2.[Salary])
	FROM [Teachers] AS T2
	WHERE T2.[IsProfessor] = 1
)
AND T.[IsProfessor] = 0

--5. Вивести назви груп, які мають більше одного куратора.
-- змінюємо дані в таблиці для перевірки запиту---
		UPDATE [GroupsCurators]
		SET [GroupId] = 1
		WHERE [CuratorId] = 2 AND [GroupId] = 4
--запит:
SELECT G.[Name] AS 'Назва групи', COUNT(GC.[CuratorId]) AS 'Кількість кураторів'
FROM [Groups] AS G
JOIN [GroupsCurators] AS GC ON G.[Id] = GC.[GroupId]
GROUP BY G.[Name]
HAVING COUNT(GC.[CuratorId]) > 1

-- другий варіант
	SELECT G.[Name] AS 'Назва групи'
	FROM [Groups] AS G
	WHERE G.[Id] IN 
	(
		SELECT GC.[GroupId]
		FROM [GroupsCurators] AS GC
		GROUP BY GC.[GroupId]
		HAVING COUNT(GC.[CuratorId]) > 1
	)

--6. Вивести назви груп, які мають рейтинг (середній рейтинг
--усіх студентів групи) менший, ніж мінімальний рейтинг
--груп 5-го курсу.
SELECT GR.[Name] AS 'Назва групи', AVG(ST.[Rating]) AS 'Рейтинг групи'
FROM [Groups] AS GR
JOIN [GroupsStudents] AS GS ON GR.[Id] = GS.[GroupId]
JOIN [Students] AS ST ON ST.[Id] = GS.[StudentId]
GROUP BY GR.[Name]
HAVING AVG(ST.[Rating]) < (
	SELECT MIN(Aver_Rating)
	FROM 
	(
		SELECT AVG(S.[Rating]) AS  Aver_Rating
		FROM [Students] AS S 
		JOIN [GroupsStudents] AS GSt ON S.[Id] = GSt.[StudentId]
		JOIN [Groups] AS GR ON GR.[Id] = Gst.[GroupId]
		WHERE GR.[Year] = 5
		GROUP BY GR.[Id]
	) AS AR
)

--7. Вивести назви факультетів, сумарний фонд фінансуван-
--ня кафедр яких більший за сумарний фонд фінансування
--кафедр факультету “Computer Science”.
SELECT F.[Name] AS 'Назва факультету', SUM(DP.[Financing]) AS 'Фонд фінансування кафедр'
FROM [Faculties] AS F
JOIN [Departments] AS DP ON F.[Id] = DP.[FacultyId]
GROUP BY F.[Name]
HAVING SUM(DP.[Financing]) > (
	SELECT SUM(DP2.[Financing])
	FROM [Departments] AS DP2
	JOIN [Faculties] AS F2 ON F2.[Id] = DP2.[FacultyId]
	WHERE F2.[Name] = 'Information Technology'
)

--8. Вивести назви дисциплін та повні імена викладачів, які
--читають найбільшу кількість лекцій з них.

SELECT SB.[Name] AS 'Дисципліна', T.[Name] + ' ' + T.[Surname] AS 'Викладач', LC.[Кількість_лекцій]
FROM [Subjects] AS SB
JOIN (
    SELECT L.[SubjectId], L.[TeacherId], COUNT(*) AS 'Кількість_лекцій'
    FROM [Lectures] AS L
    GROUP BY L.[SubjectId], L.[TeacherId]
) AS LC ON SB.[Id] = LC.[SubjectId]
JOIN [Teachers] AS T ON T.[Id] = LC.[TeacherId]
WHERE LC.[Кількість_лекцій] = (
    SELECT MAX(SubLC.[Кількість_лекцій])
    FROM (
        SELECT L.[SubjectId], L.[TeacherId], COUNT(*) AS 'Кількість_лекцій'
        FROM [Lectures] AS L
        GROUP BY L.[SubjectId], L.[TeacherId]
    ) AS SubLC
    WHERE SubLC.[SubjectId] = LC.[SubjectId]
    GROUP BY SubLC.[SubjectId]
)

--9. Вивести назву дисципліни, за якою читається найменше
--лекцій.

SELECT SB.[Name] AS 'Дисципліна', LecturesCount.[Кількість_лекцій] AS 'Кількість лекцій'
FROM [Subjects] AS SB
JOIN (
    SELECT L.[SubjectId], COUNT(*) AS 'Кількість_лекцій'
    FROM [Lectures] AS L
    GROUP BY L.[SubjectId]
) AS LecturesCount ON SB.[Id] = LecturesCount.[SubjectId]
WHERE LecturesCount.[Кількість_лекцій] = (
    SELECT MIN(CountLectures)
    FROM (
        SELECT COUNT(*) AS 'CountLectures'
        FROM [Lectures]
        GROUP BY [SubjectId]
    ) AS MinLectures
)

--10. Вивести кількість студентів та дисциплін, що читаються
--на кафедрі “Software Development”.
SELECT 
	(SELECT COUNT(*)  --, COUNT(SB.[Id]) AS 'Кількість дисциплін'
	FROM [Students] AS ST
	JOIN [GroupsStudents] AS GS ON ST.[Id] = GS.[StudentId]
	JOIN [Groups] AS G ON G.[Id] = GS.[GroupId]
	JOIN [Departments] AS D ON D.[Id] = G.[DepartmentId]
	WHERE D.[Name] LIKE 'Software Development%') AS 'Кількість студентів',

	(SELECT COUNT(*)
	FROM [Subjects] AS SB
	JOIN [Lectures] AS L ON SB.[Id] = L.[SubjectId]
	JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
	JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
	JOIN [Departments] AS D ON D.[Id] = G.[DepartmentId]
	WHERE D.[Name] LIKE 'Software Development%') AS 'Кількість дисциплін'



SELECT * FROM [Curators]
SELECT * FROM [GroupsCurators]
SELECT * FROM [Students]
SELECT * FROM [GroupsStudents]
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