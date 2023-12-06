CREATE DATABASE New_Academy
GO
USE New_Academy

CREATE TABLE [Teachers]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(MAX) NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHK_TName CHECK ([Name] != ''),
	CONSTRAINT CHK_TSurname CHECK ([Surname] != ''),
);

CREATE TABLE [Assistants]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
);

CREATE TABLE [Curators]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
);

CREATE TABLE [Deans]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
);

CREATE TABLE [Heads]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
);

CREATE TABLE [Faculties]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[DeanId] INT NOT NULL REFERENCES [Deans]([Id]),
	CONSTRAINT CHK_FBuilding CHECK ([Building] BETWEEN 1 AND 5),
	CONSTRAINT CHK_FName CHECK ([Name] != ''),
);

CREATE TABLE [Departments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[FacultyId] INT NOT NULL REFERENCES [Faculties]([Id]),
	[HeadId] INT NOT NULL REFERENCES [Heads]([Id]),
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
	CONSTRAINT CHK_GYear CHECK ([Year] BETWEEN 1 AND 5),
);

CREATE TABLE [GroupsCurators]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[CuratorId] INT NOT NULL REFERENCES [Curators]([Id]),
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
);

CREATE TABLE [LectureRooms]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Name] NVARCHAR(10) NOT NULL UNIQUE,
	CONSTRAINT CHK_LRBuilding CHECK ([Building] BETWEEN 1 AND 5),
	CONSTRAINT CHK_LRName CHECK ([Name] != ''),
);

CREATE TABLE [Subjects]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_SName CHECK ([Name] != ''),
);

CREATE TABLE [Lectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[SubjectId] INT NOT NULL REFERENCES [Subjects]([Id]),
	[TeacherId] INT NOT NULL REFERENCES [Teachers]([Id]),
);

CREATE TABLE [GroupsLectures]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[GroupId] INT NOT NULL REFERENCES [Groups]([Id]),
	[LectureId] INT NOT NULL REFERENCES [Lectures](Id),
);

CREATE TABLE [Schedules]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Class] INT NOT NULL,
	[DayOfWeek] INT NOT NULL,
	[Week] INT NOT NULL,
	[LectureId] INT NOT NULL REFERENCES [Lectures]([Id]),
	[LectureRoomId] INT NOT NULL REFERENCES [LectureRooms]([Id]),
	CONSTRAINT CHK_SClass CHECK ([Class] BETWEEN 1 AND 8),
	CONSTRAINT CHK_SDayOfWeek CHECK ([DayOfWeek] BETWEEN 1 AND 7),
	CONSTRAINT CHK_SWeek CHECK ([Week] BETWEEN 1 AND 52),
);

INSERT INTO [Teachers] ([Name], [Surname])
VALUES
('John', 'Smith'),
('Emily', 'Johnson'),
('William', 'Williams'),
('Olivia', 'Brown'),
('Michael', 'Jones'),
('Emma', 'Garcia'),
('Alexander', 'Martinez'),
('Samantha', 'Adams'), 
('Daniel', 'Anderson'),
('Ava', 'Taylor'),
('David', 'Thomas'),
('Mia', 'Moore'),
('James', 'Jackson'),
('Dave', 'McQueen'),
('Jack', 'Underhill'),
('Edward', 'Hopper'),
('Alex', 'Carmack'),
('Nolan', 'Mitchell'),
('Ruby', 'Coleman'),
('David','Griffin'),
('Kaylee', 'Bryant'),
('Christian', 'Cox'),
('Amelia', 'Richardson'),
('Christopher', 'Powell'),
('Harper', 'Hayes'),
('Leo', 'Alexander'),
('Lucy', 'Foster'),
('Jaxon', 'Ward'),
('Isla', 'Collins'),
('Isaac', 'Wood');

INSERT INTO [Assistants] ([TeacherId])
VALUES
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

INSERT INTO [Curators] ([TeacherId])
VALUES
(2),
(6),
(9),
(11),
(15),
(19),
(21),
(22),
(24),
(26),
(28),
(29),
(30);

INSERT INTO [Deans] ([TeacherId])
VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO [Heads] ([TeacherId])
VALUES
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18);

INSERT INTO [Faculties] ([Building], [Name], [DeanId])
VALUES
(1, 'Computer Science', 1),
(3, 'Engineering', 2),
(2, 'Information Technology', 3),
(4, 'Robotics', 5),
(5, 'Physics and Mathematics', 4);

INSERT INTO [Departments] ([Building], [Name], [FacultyId], [HeadId])
VALUES
(1, 'Software Engineering Department', 1, 1),
(1, 'Software Development Department', 1, 2),
(5, 'Data Science Department', 1, 3),
(3, 'Network Engineering Department', 1, 4),

(3, 'Electrical Systems Department', 2, 5),
(4, 'Control Systems Department', 2, 6),
(4, 'Mechatronics Department', 2, 7),
(3, 'Structural Engineering Department', 2, 8),
(3, 'Environmental Engineering Department', 2, 9),

(2, 'Information Systems Department', 3, 10),
(2, 'Cybersecurity Department', 3, 11),
(2, 'Artificial Intelligence Department', 3, 12),

(4, 'Robotics Engineering Department', 4, 13),
(4, 'Automation Engineering Department', 4, 1),

(5, 'Theoretical Physics Department', 5, 3), 
(5, 'Mathematical Analysis Department', 5, 7),  
(5, 'Quantum Mechanics Department', 5, 9), 
(5, 'Applied Mathematics Department', 5, 11);

INSERT INTO [LectureRooms] ([Building], [Name])
VALUES
(1, 'A 101'),
(1, 'A 102'),
(1, 'A 103'),
(1, 'A 104'),
(1, 'A 311'),
(1, 'A 201'),
(1, 'A 202'),
(4, 'B 101'),
(4, 'B 102'),
(3, 'C 101'),
(3, 'C 102'),
(3, 'C 103'),
(3, 'C 104'),
(3, 'C 105'),
(3, 'C 201'),
(3, 'C 202'),
(3, 'C 203'),
(3, 'C 204'),
(3, 'C 205'),
(2, 'D 101'),
(2, 'D 102'),
(2, 'D 103'),
(2, 'D 201'),
(2, 'D 202'),
(5, 'E 101'),
(5, 'E 102'),
(5, 'F 103'),
(5, 'F 104'),
(4, 'G 101'),
(4, 'G 102'),
(4, 'G 103');


INSERT INTO [Lectures] ([SubjectId], [TeacherId])
VALUES
(1, 28),
(2, 29),
(3, 30),
(4, 4),
(5, 5),
(6, 6),
(7, 6),
(8, 7),
(9, 7),
(10, 8),
(11, 8),
(12, 9),
(13, 9),
(14, 10),
(15, 1),
(16, 2),
(1, 11),
(2, 12),
(3, 12),
(4, 13),
(5, 27),
(6, 26),
(7, 14),
(8, 25),
(9, 15),
(10, 24),
(13, 16),
(14, 23),
(15, 17),
(11, 18),
(16, 22),
(12, 19),
(1, 21),
(2, 20);

INSERT INTO [Schedules] ([Class], [DayOfWeek], [Week], [LectureId], [LectureRoomId])
VALUES
(1,1,1,5,1),
(2,1,2,4,2),
(3,1,3,3,3),
(4,1,4,4,4),
(5,1,1,5,5),
(6,1,2,6,6),
(7,1,3,7,7),
(8,1,1,8,8),
(1,2,2,9,9),
(2,2,1,10,10),
(3,2,2,11,11),
(4,2,3,12,12),
(5,2,4,13,13),
(6,2,5,14,14),
(1,3,1,15,15),
(2,3,2,16,16),
(3,3,3,3,17),
(4,3,4,4,18),
(5,3,1,3,19),
(2,4,2,4,20),
(3,4,3,5,21),
(4,4,4,6,22),
(5,4,5,7,23),
(6,4,6,8,24),
(2,5,7,9,25),
(3,5,8,10,26),
(4,5,9,11,27),
(5,5,10,12,28),
(1,2,10,13,29),
(1,2,10,29,30),
(2,2,11,22,31),
(1,3,12,28,22);

INSERT INTO [Groups] ([Name], [Year], [DepartmentId])
VALUES 
('SE101', 1, 1),
('SE102', 1, 1),
('SE301', 3, 1),
('DS201', 2, 2),
('DS401', 4, 2),
('DS402', 4, 2),
('NE201', 2, 6),
('NE301', 3, 6),
('NE402', 4, 6),
('NE501', 5, 6),
('E301', 3, 7),
('M401', 4, 8),
('M501', 5, 8),
('P107', 1, 9),
('P201', 2, 9),
('P301', 3, 9),
('P401', 4, 5),
('P501', 5, 10),
('CS102', 1, 11),
('CS103', 1, 11),
('CS104', 1, 11),
('CS201', 2, 12),
('CS202', 2, 12),
('CS204', 2, 12),
('AE302', 3, 13),
('AE401', 4, 13),
('MA101', 1, 14),
('MA301', 3, 14),
('MA501', 5, 15),
('D221', 2, 16),
('K333', 3, 17),
('R206', 2, 18),
('F505', 5, 3),
('F504', 5, 4);
	
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

INSERT INTO [GroupsLectures] ([GroupId], [LectureId])
VALUES
(2, 3),
(2, 6),
(3, 3),
(4, 4),
(5, 4),
(6, 5),
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
(4, 26),
(2, 27),
(3, 28),
(4, 22),
(5, 21),
(6, 3),
(31, 4),
(32, 2),
(33, 3),
(30, 30),
(29, 30),
(28, 30);
INSERT INTO [GroupsCurators] ([CuratorId], [GroupId])
VALUES
(1, 2),
(2, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 11),
(10, 12),
(11, 13),
(12, 14),
(13, 15),
(1, 16),
(2, 17),
(3, 18),
(4, 19),
(5, 20),
(6, 21),
(7, 22),
(8, 23),
(9, 24),
(10, 25),
(11, 26),
(12, 27),
(13, 28),
(1, 29),
(2, 30),
(3, 31),
(4, 32),
(5, 33);


--Запити Тема: Об'єднання
--1. Вивести назви аудиторій, де читає лекції викладач “Edward
--Hopper”.
SELECT LR.[Name] AS 'Назва аудиторії'
FROM [LectureRooms] AS LR
JOIN [Schedules] AS S ON LR.[Id] = S.[LectureRoomId]
JOIN [Lectures] AS L ON S.[LectureId] = L.[Id]
JOIN [Teachers] AS T ON L.[TeacherId] = T.[Id]
WHERE T.[Name] = 'Edward' AND T.[Surname] = 'Hopper'

--2. Вивести прізвища асистентів, які читають лекції у групі
--“F505”.
SELECT T.[Surname] AS 'Призвище асистента'
FROM [Teachers] AS T
JOIN [Assistants] AS A ON T.[Id] = A.[TeacherId]
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
WHERE G.[Name] = 'F505'

--3. Вивести дисципліни, які читає викладач “Alex Carmack”
--для груп 5 курсу.
SELECT S.[Name] AS 'Назва дисципліни', G.[Name] AS 'Група'
FROM [Subjects] AS S
JOIN [Lectures] AS L ON S.[Id] = L.[SubjectId] 
JOIN [Teachers] AS T ON T.[Id] = L.[TeacherId]
JOIN [GroupsLectures] AS GL ON L.[Id] = GL.[LectureId]
JOIN [Groups] AS G ON G.[Id] = GL.[GroupId]
WHERE T.[Name] = 'Alex' AND T.[Surname] = 'Carmack' AND G.[Year] = 5

--4. Вивести прізвища викладачів, які не читають лекції у по-
--неділок.

SELECT DISTINCT T.[Surname] AS 'Призвище викладача'
FROM [Teachers] AS T
JOIN [Lectures] AS L ON T.[Id] = L.[TeacherId]
JOIN [Schedules] AS SC ON L.[Id] = SC.[LectureId]
WHERE SC.[DayOfWeek] <> 1

--5. Вивести назви аудиторій, із зазначенням їх корпусів, у яких
--немає лекцій у середу другого тижня на третій парі.
SELECT LR.[Name] AS 'Аудиторія', LR.[Building] AS 'Корпус'
FROM [LectureRooms] AS LR
LEFT JOIN (
	SELECT DISTINCT SC.[LectureRoomId]
	FROM [Schedules] AS SC
	WHERE SC.[DayOfWeek] = 3 AND SC.[Week] = 2 AND SC.[Class] = 3
	) AS NoLectures ON LR.[Id] = NoLectures.[LectureRoomId]
WHERE NoLectures.[LectureRoomId] IS NULL

--6. Вивести повні імена викладачів факультету “Computer Science”,
--які не курирують групи кафедри “Software Development”.

SELECT DISTINCT T.[Name] + ' ' + T.[Surname] AS 'Викладачі'
FROM [Teachers] AS T
JOIN [Curators] AS C ON T.[Id] = C.[TeacherId]
JOIN [GroupsCurators] AS GC ON C.[Id] = GC.[CuratorId]
JOIN [Groups] AS G ON G.[Id] = GC.[GroupId]
JOIN [Departments] AS DP ON DP.[Id] = G.[DepartmentId]
JOIN [Faculties] AS F ON F.[Id] = DP.[FacultyId]
LEFT JOIN (
    SELECT GC2.[CuratorId]
    FROM [GroupsCurators] AS GC2
    JOIN [Groups] AS G2 ON G2.[Id] = GC2.[GroupId]
    JOIN [Departments] AS DP2 ON DP2.[Id] = G2.[DepartmentId]
    WHERE DP2.[Name] LIKE 'Software Development%'
) AS SD ON C.[Id] = SD.[CuratorId]
WHERE F.[Name] = 'Computer Science' AND SD.[CuratorId] IS NULL

--7. Вивести список номерів усіх корпусів, які є у таблицях
--факультетів, кафедр та аудиторій.
SELECT DISTINCT [Building] AS 'Номер корпусу'
FROM [Departments]
UNION
SELECT DISTINCT [Building]
FROM [Faculties]
UNION
SELECT DISTINCT [Building]
FROM [LectureRooms];
--8. Вивести повні імена викладачів у такому порядку: дека-
--ни факультетів, завідувачі кафедр, викладачі, куратори,
--асистенти.
SELECT T.[Name] + ' ' + T.[Surname] AS 'ПІБ', 'Декан' AS 'Роль'
FROM [Teachers] AS T
JOIN [Deans] AS D ON T.[Id] = D.[TeacherId]

UNION ALL

SELECT T.[Name] + ' ' + T.[Surname], 'Завідувач кафедри'
FROM [Teachers] AS T
JOIN [Heads] AS H ON T.[Id] = H.[TeacherId]

UNION ALL

SELECT T.[Name] + ' ' + T.[Surname], 'Викладач'
FROM [Teachers] AS T

UNION ALL

SELECT T.[Name] + ' ' + T.[Surname], 'Куратор'
FROM [Teachers] AS T
JOIN [Curators] AS C ON T.[Id] = C.[TeacherId]

UNION ALL

SELECT T.[Name] + ' ' + T.[Surname], 'Асистент'
FROM [Teachers] AS T
JOIN [Assistants] AS A ON T.[Id] = A.[TeacherId]

--9. Вивести дні тижня (без повторень), в які є заняття в ауди-
--торіях «A311» та «A104» корпусу.
SELECT DISTINCT SC.[DayOfWeek]
FROM [Schedules] AS SC
JOIN [LectureRooms] AS LR ON SC.[LectureRoomId] = LR.[Id]
WHERE LR.[Name] IN ('A 311', 'A 104')




--SELECT * FROM [Teachers]
--SELECT * FROM [Assistants]
--SELECT * FROM [Curators]
--SELECT * FROM [Deans]
--SELECT * FROM [Heads]
--SELECT * FROM [Faculties]
--SELECT * FROM [Departments]
--SELECT * FROM [Groups]
--SELECT * FROM [GroupsCurators]
--SELECT * FROM [LectureRooms]
--SELECT * FROM [Subjects]
--SELECT * FROM [Lectures]
--SELECT * FROM [GroupsLectures]
--SELECT * FROM [Schedules]


--DELETE [Teachers]
--DELETE [Assistants]
--DELETE [Curators]
--DELETE [Deans]
--DELETE [Heads]
--DELETE [Faculties]
--DELETE [Departments]
--DELETE [Groups]
--DELETE [GroupsCurators]
--DELETE [LectureRooms]
--DELETE [Subjects]
--DELETE [Lectures]
--DELETE [GroupsLectures]
--DELETE [Schedules]

--DROP TABLE [Teachers]
--DROP TABLE [Assistants]
--DROP TABLE [Curators]
--DROP TABLE [Deans]
--DROP TABLE [Heads]
--DROP TABLE [Faculties]
--DROP TABLE [Departments]
--DROP TABLE [Groups]
--DROP TABLE [GroupsCurators]
--DROP TABLE [LectureRooms]
--DROP TABLE [Subjects]
--DROP TABLE [Lectures]
--DROP TABLE [GroupsLectures]
--DROP TABLE [Schedules]