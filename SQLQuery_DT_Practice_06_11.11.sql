CREATE DATABASE Hospital_2
GO
USE Hospital_2
CREATE TABLE [Departments]
(
    [Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_Name CHECK ([Name] !=''),
	CONSTRAINT CHK_Building CHECK ([Building] BETWEEN 1 AND 5),
);

CREATE TABLE [Doctors] 
(
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Premium] MONEY NOT NULL DEFAULT 0,
    [Salary] MONEY NOT NULL,
    [Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHD_Name CHECK ([Name] !=''),
	CONSTRAINT CHK_Premium CHECK ([Premium] >= 0),
	CONSTRAINT CHK_Salary CHECK ([Salary] > 0),
	CONSTRAINT CHK_Surname CHECK ([Surname] !=''),
);
CREATE TABLE [DoctorsExaminations]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[EndTime] TIME NOT NULL,
	[StartTime] TIME NOT NULL,
	[DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
	[ExaminationId] INT NOT NULL REFERENCES [Examinations]([Id]),
	[WardId] INT NOT NULL REFERENCES [Wards]([Id]),
	CONSTRAINT CHK_EndTime CHECK ([EndTime] > [StartTime]),
	CONSTRAINT CHK_StartTime CHECK ([StartTime] BETWEEN '08:00:00' AND '18:00:00'),
);
CREATE TABLE [Examinations]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DayOfWeek] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
	CONSTRAINT CHK_DayOfWeek CHECK ([DayOfWeek] BETWEEN 1 AND 8),
);
CREATE TABLE [Specializations]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHS_Name CHECK ([Name] != '')
);

CREATE TABLE [Sponsors]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHSP_Name CHECK ([Name] !='')
);

CREATE TABLE [DoctorsSpecializations]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
    [SpecializationId] INT NOT NULL REFERENCES [Specializations]([Id])
);

CREATE TABLE [Donations]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [Amount] MONEY NOT NULL,
    [Date] DATE NOT NULL DEFAULT GETDATE(),
    [DepartmentId] INT NOT NULL REFERENCES [Departments]([Id]),
    [SponsorId] INT NOT NULL REFERENCES [Sponsors]([Id]),
	CONSTRAINT CHK_Amount CHECK ([Amount] > 0),
	CONSTRAINT CHK_Date CHECK ([Date] <= GETDATE())
);

CREATE TABLE [Vacations]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [EndDate] DATE NOT NULL,
    [StartDate] DATE NOT NULL,
    [DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
	CONSTRAINT CHK_EndDate CHECK ([EndDate] > [StartDate])
);

CREATE TABLE [Wards] 
(
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(20) NOT NULL UNIQUE,
	[Places] INT NOT NULL,
    [DepartmentId] INT NOT NULL REFERENCES [Departments]([Id]),
	CONSTRAINT CHKW_Name CHECK ([Name] !=''),
	CONSTRAINT CHK_Places CHECK ([Places] > 0),
);
INSERT INTO [Departments] ([Building], [Name]) 
VALUES 
	(1, 'Cardiology'),
	(2, 'Orthopedics'),
	(2, 'Neurology'),
	(3, 'Intensive Treatment'),
	(4, 'Dermatology'),
	(3, 'Emergency Medicine'),
	(5, 'Ophthalmology'),
	(5, 'Gastroenterology'),
	(1, 'General Surgery'),
	(5, 'Microbiology'),
	(4, 'Oncology');

INSERT INTO [Doctors] ([Name], [Premium], [Salary], [Surname])
VALUES
	('John', 2000, 80000, 'Doe'),
    ('Jane', 1500, 70000, 'Smith'),
    ('Robert', 1000, 60000, 'Johnson'),
    ('Emily', 1200, 75000, 'Williams'),
    ('Michael', 1800, 85000, 'Brown'),
    ('Olivia', 1600, 78000, 'Davis'),
    ('William', 0, 72000, 'Miller'),
    ('Ava', 1700, 82000, 'Moore'),
    ('Daniel', 1100, 65000, 'Clark'),
    ('Sophia', 1400, 73000, 'Taylor'),
    ('Matthew', 1900, 88000, 'White'),
    ('Emma', 1500, 76000, 'Anderson'),
    ('Ethan', 1600, 79000, 'Hill'),
    ('Mia', 1200, 71000, 'Ward'),
    ('Helen', 2000, 90000, 'Williams'),
	('Thomas', 1500, 65000, 'Gerada'),
	('Anthony', 1600, 55000, 'Davis'),
	('Joshua', 1700, 85000, 'Bell'),
	('Anastasia', 1800, 70000, 'Kovalyova'),
	('Maxim', 1900, 55000, 'Petrov'),
	('Alexander', 2000, 71000, 'Johnson'),
	('Sophia', 2100, 62000, 'Miller'),
	('Elena', 2200, 60000, 'Sidorova');
	
INSERT INTO [Specializations] ([Name])
VALUES
	('Cardiology'),
	('Orthopedics'),
	('Neurology'),
	('Intensive Treatment'),
	('Dermatology'),
	('Emergency Medicine'),
	('Ophthalmology'),
	('Gastroenterology'),
	('General Surgery'),
	('Microbiology'),
	('Oncology');

INSERT INTO [DoctorsSpecializations] ([DoctorId], [SpecializationId]) 
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(5, 3),
	(6, 3),
	(7, 4),
	(8, 4),
	(9, 5),
	(10, 5),
	(11, 6),
	(12, 6),
	(13, 7),
	(14, 1),
	(15, 7),
	(16, 8),
	(17, 9),
	(18, 10),
	(19, 11),
	(20, 9),
	(21, 10),
	(22, 11),
	(23, 8);

INSERT INTO [Sponsors] ([Name])
VALUES
	('Umbrella Corporation'),
	('Caritas'),
	('Hopeful Hearts Charity'),
	('MedTech Solutions');

INSERT INTO [Donations] ([Amount], [Date], [DepartmentId], [SponsorId])
VALUES
	(50000, '2023.11.02', 1, 1),
	(45000, '2023.10.15', 2, 2),
	(5000, '2023.11.12', 3, 3),
	(15000, '2023.09.22', 4, 4),
	(55000, '2023.03.31', 5, 1),
	(100000, '2023.11.05', 6, 2),
	(65000, '2023.10.02', 7, 3),
	(5000, '2023.08.02', 1, 4),
	(51000, '2023.06.28', 2, 1),
	(15000, '2023.02.02', 3, 2),
	(25000, '2023.05.13', 4, 3),
	(30000, '2023.04.24', 8, 4),
	(65000, '2023.08.13', 9, 1),
	(25000, '2023.09.13', 10, 2),
	(125000, '2023.10.20', 11, 3);


INSERT INTO [Vacations] ([EndDate], [StartDate], [DoctorId])
VALUES
	('2023-12-30', '2023-12-20', 1),
    ('2023-11-30', '2023-11-15', 2),
    ('2023-10-31', '2023-10-15', 4),
    ('2023-09-30', '2023-09-15', 6),
    ('2023-08-31', '2023-08-15', 5),
    ('2023-07-31', '2023-07-15', 3),
    ('2023-06-30', '2023-06-15', 7),
    ('2023-05-31', '2023-05-15', 8),
    ('2023-04-30', '2023-04-15', 9),
    ('2023-03-31', '2023-03-15', 11),
    ('2023-02-28', '2023-02-15', 10),
    ('2023-01-31', '2023-01-15', 12),
    ('2022-12-31', '2022-12-15', 13),
    ('2022-11-30', '2022-11-15', 14),
    ('2022-10-31', '2022-10-15', 15),
    ('2022-09-30', '2022-09-15', 16),
    ('2022-08-31', '2022-08-15', 17),
    ('2022-07-31', '2022-07-15', 18),
    ('2022-06-30', '2022-06-15', 19),
    ('2022-05-31', '2022-05-15', 20),
    ('2022-04-30', '2022-04-15', 21),
    ('2022-03-31', '2022-03-15', 22),
    ('2022-02-28', '2022-02-15', 23);
		
INSERT INTO [Wards] ([Name], [Places], [DepartmentId])
VALUES
	('Ward A1', 5, 1),
	('Ward A2', 11, 1),
	('Ward A3', 15, 1),
	('Ward B1', 22, 2),
	('Ward B2', 11, 2),
	('Ward S1', 8, 3),
	('Ward R1', 5, 4),
	('Ward R2', 8, 4),
	('Ward R3', 8, 4),
	('Ward B3', 16, 2),
	('Ward B4', 22, 2),
	('Ward C1', 5, 5),
	('Ward C2', 10, 5),
	('Ward C3', 15, 5),
	('Ward X1', 8, 6),
	('Ward D1', 10, 7),
	('Ward D2', 10, 7),
	('Ward R4', 16, 4),
	('Ward B5', 6, 2),
	('Ward G1', 10, 8),
	('Ward GS1', 6, 9),
	('Ward GS2', 8, 9),
	('Ward M1', 10, 10),
	('Ward O1', 6, 11),
	('Ward O2', 8, 11),
	('Ward A4', 8, 1);
	
INSERT INTO [DoctorsExaminations] ([EndTime], [StartTime], [DoctorId], [ExaminationId], [WardId])
VALUES
	('08:20:00', '08:00:01', 1, 1, 1),
	('08:40:00', '08:20:01', 1, 2, 2),
	('08:20:00', '08:00:01', 2, 3, 3),
	('08:40:00', '08:20:01', 2, 4, 4),
	('10:00:00', '09:00:00', 14, 5, 5),
	('11:00:00', '10:00:01', 14, 6, 6),
	('12:00:00', '11:00:01', 14, 7, 7),
	('13:00:00', '12:00:01', 14, 1, 8),
	('11:00:00', '09:00:00', 3, 2, 9),
	('11:00:00', '09:00:00', 4, 3, 10),
	('15:00:00', '09:00:00', 5, 4, 11),
	('15:00:00', '09:00:00', 6, 5, 12),
	('11:00:00', '09:00:00', 7, 6, 13),
	('10:00:00', '08:00:00', 8, 7, 14),
	('11:00:00', '10:00:00', 9, 1, 15),
	('15:00:00', '11:00:00', 10, 2, 16),
	('15:00:00', '14:00:00', 11, 3, 17),
	('15:00:00', '08:00:00', 12, 4, 18),
	('09:30:00', '09:00:00', 13, 5, 19),
	('11:30:00', '11:00:00', 14, 6, 20),
	('13:00:00', '12:00:00', 15, 7, 21),
	('09:30:00', '09:00:00', 16, 1, 22),
	('09:30:00', '09:00:00', 17, 2, 23),
	('09:30:00', '09:00:00', 18, 3, 24),
	('09:30:00', '09:00:00', 19, 4, 25),
	('09:30:00', '09:00:00', 20, 5, 26),
	('09:30:00', '09:00:00', 21, 6, 1),
	('09:30:00', '09:00:00', 22, 7, 2),
	('09:30:00', '09:00:00', 23, 1, 3);


INSERT INTO [Examinations] ([DayOfWeek], [Name])
VALUES
	(1, 'Checkup'),
	(4, 'X-Ray'),
	(2, 'MRT'),
	(3, 'Blood Test'),
	(5, 'CT Scan'),
	(1, 'Endoscopy'),
	(2, 'EKG'),
	(5, 'EEG'),
	(6, 'Allergy Test'),
	(7, 'DEXA Scan');
--	Запити 
--1. Вивести назви відділень, що знаходяться у тому ж корпусі,
--що й відділення “Cardiology”.
SELECT [Name]
FROM [Departments]
WHERE [Building] = (SELECT [Building]
    FROM [Departments]
    WHERE [Name] = 'Cardiology')

--2. Вивести назви відділень, що знаходяться у тому ж корпусі,
--що й відділення “Gastroenterology” та “General Surgery”.

SELECT [Name]
FROM [Departments]
WHERE [Building] IN (
    SELECT [Building]
    FROM [Departments]
    WHERE [Name] IN ('Gastroenterology', 'General Surgery')
);

--3. Вивести назву відділення, яке отримало найменше по-
--жертвувань.
SELECT DP.[Name] AS 'Назва відділення', SUM(D.[Amount]) AS 'Сума пожертвування'
FROM [Departments] AS DP
JOIN [Donations] AS D ON DP.[Id] = D.[DepartmentId]
GROUP BY DP.[Name]
HAVING SUM(D.[Amount]) = (
	SELECT MIN(SumOfAmount)
	FROM (
		SELECT SUM(D2.[Amount]) AS 'SumOfAmount'
		FROM [Donations] AS D2
		GROUP BY D2.[DepartmentId]
		) AS SumOfAmount
);
		
--4. Вивести прізвища лікарів, ставка яких більша, ніж у лікаря
--“Thomas Gerada”.

SELECT D.[Surname] + ' ' + D.[Name] AS 'Доктор', D.[Salary] AS 'Ставка'
FROM [Doctors] AS D
WHERE D.[Salary] > (
	SELECT D2.[Salary] FROM [Doctors] AS D2 
	WHERE D2.[Surname] = 'Gerada'
)

--5. Вивести назви палат, місткість яких більша, ніж середня
--місткість у палатах відділення “Microbiology”.
SELECT W.[Name] AS 'Палата', W.[Places] AS 'Місткість'
FROM [Wards] AS W
JOIN [Departments] AS D ON W.[DepartmentId] = D.[Id]
WHERE W.[Places] >= (
	SELECT AVG(W2.[Places]) 
	FROM [Wards] AS W2
	JOIN [Departments] AS D2 ON W2.[DepartmentId] = D2.[Id]
	WHERE D2.[Name] = 'Microbiology')
AND D.[Name] <> 'Microbiology'

--6. Вивести повні імена лікарів, зарплати яких (сума ставки та
--надбавки) перевищують більш ніж на 10000 зарплату лікаря
--Anthony Davis.
SELECT D.[Surname] + ' ' + D.[Name] AS 'Доктор', (D.[Salary] + D.[Premium]) AS 'Зарплата'
FROM [Doctors] AS D
WHERE (D.[Salary] + D.[Premium]) > (
	SELECT (D2.[Salary] + D2.[Premium]) + 10000
	FROM [Doctors] AS D2
	WHERE D2.[Surname] = 'Davis' AND D2.[Name] = 'Anthony'
)

--7. Вивести назви відділень, у яких проводить обстеження
--лікар Joshua Bell.

SELECT DISTINCT S.[Name] AS 'Відділення'
FROM [Specializations] AS S
JOIN [DoctorsSpecializations] AS DS ON S.[Id] = DS.[SpecializationId]
JOIN [DoctorsExaminations] AS DE ON DS.[DoctorId] = DE.[DoctorId]
JOIN [Doctors] AS D ON DS.[DoctorId] = D.[Id]
WHERE D.[Surname] = 'Bell' AND D.[Name] = 'Joshua'
	--- другий варіант ---
	SELECT DISTINCT S.[Name] AS 'Відділення'
	FROM [Specializations] AS S
	WHERE S.[Id] IN (
		SELECT DS.[SpecializationId]
		FROM [DoctorsSpecializations] AS DS
		JOIN [DoctorsExaminations] AS DE ON DS.[DoctorId] = DE.[DoctorId]
		JOIN [Doctors] AS D ON DS.[DoctorId] = D.[Id]
		WHERE D.[Surname] = 'Bell' AND D.[Name] = 'Joshua'
	)

--8. Вивести назви спонсорів, які не робили пожертвування
--відділенням “Neurology” та “Oncology”.

SELECT S.[Name] AS 'Назва спонсору'
FROM [Sponsors] AS S
WHERE S.[Id] NOT IN (
    SELECT D.[SponsorId]
    FROM [Donations] AS D
    JOIN [Departments] AS DP ON D.[DepartmentId] = DP.[Id]
    WHERE DP.[Name] IN ('Neurology', 'Oncology')
)
--9. Вивести прізвища лікарів, які проводять обстеження у
--період з 12:00 до 15:00.
SELECT D.[Surname] + ' ' + D.[Name] AS 'Лікарь'
FROM [Doctors] AS D
JOIN [DoctorsExaminations] AS DE ON D.[Id] = DE.[DoctorId]
WHERE CAST(DE.[StartTime] AS TIME) >= '12:00:00' AND CAST(DE.[EndTime] AS TIME) <= '15:00:00';
	--- другий варіант --- 
	SELECT D.[Surname] + ' ' + D.[Name] AS 'Лікарь'
	FROM [Doctors] AS D
	WHERE D.[Id] IN (
		SELECT [DoctorId]
		FROM [DoctorsExaminations] AS DE
		WHERE CAST(DE.[StartTime] AS TIME) >= '12:00:00' AND CAST(DE.[EndTime] AS TIME) <= '15:00:00'
	);

SELECT * FROM [Wards]
SELECT * FROM [Vacations]
SELECT * FROM [Donations]
SELECT * FROM [Sponsors]
SELECT * FROM [DoctorsSpecializations]
SELECT * FROM [Specializations]
SELECT * FROM [Doctors]
SELECT * FROM [Departments]
SELECT * FROM [DoctorsExaminations]
SELECT * FROM [Examinations]

--DROP TABLE [Wards]
--DROP TABLE [Vacations]
--DROP TABLE [Donations]
--DROP TABLE [Sponsors]
--DROP TABLE [DoctorsSpecializations]
--DROP TABLE [Specializations]
--DROP TABLE [Doctors]
--DROP TABLE [Departments]
--DROP TABLE [DoctorsExaminations]
--DROP TABLE [Examinations]