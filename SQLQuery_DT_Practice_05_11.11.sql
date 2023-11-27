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
	(5, 'Ophthalmology');

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
    ('Helen', 2000, 90000, 'Williams');
	
INSERT INTO [Specializations] ([Name])
VALUES
	('Cardiology'),
	('Orthopedics'),
	('Neurology'),
	('Intensive Treatment'),
	('Dermatology'),
	('Emergency Medicine'),
	('Ophthalmology');

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
	(15, 7);

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
	(25000, '2023.11.13', 4, 3);

INSERT INTO [Vacations] ([EndDate], [StartDate], [DoctorId])
VALUES
	('2023-12-31', '2023-12-20', 1),
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
    ('2022-10-31', '2022-10-15', 15);
		
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
	('Ward A4', 8, 1);
	
INSERT INTO [DoctorsExaminations] ([EndTime], [StartTime], [DoctorId], [ExaminationId], [WardId])
VALUES
	('08:20:00', '08:00:01', 1, 15, 1),
	('08:40:00', '08:20:01', 1, 16, 2),
	('08:20:00', '08:00:01', 2, 17, 3),
	('08:40:00', '08:20:01', 2, 18, 20),
	('10:00:00', '09:00:00', 14, 19, 1),
	('11:00:00', '10:00:01', 14, 20, 2),
	('12:00:00', '11:00:01', 14, 21, 3),
	('13:00:00', '12:00:01', 14, 22, 20),
	('11:00:00', '09:00:00', 3, 23, 4),
	('11:00:00', '09:00:00', 4, 24, 5),
	('15:00:00', '09:00:00', 5, 15, 6),
	('15:00:00', '09:00:00', 6, 16, 6),
	('11:00:00', '09:00:00', 7, 17, 7),
	('10:00:00', '08:00:00', 8, 18, 8),
	('11:00:00', '10:00:00', 9, 15, 9),
	('15:00:00', '11:00:00', 10, 16, 10),
	('15:00:00', '14:00:00', 11, 17, 11),
	('15:00:00', '08:00:00', 12, 18, 12),
	('09:30:00', '09:00:00', 13, 19, 13),
	('11:30:00', '11:00:00', 14, 20, 14),
	('13:00:00', '12:00:00', 15, 21, 15);

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
--1. Вивести кількість палат, місткість яких більша за 10.

SELECT COUNT(*) AS 'Палати з місткісттю більше 10'
FROM [Wards] AS W
WHERE W.[Places] > 10

--2. Вивести назви корпусів та кількість палат у кожному з них.

SELECT DP.[Building] AS 'Номер корпусу', COUNT(W.[DepartmentId]) AS 'Кільіксть палат'
FROM [Departments] AS DP, [Wards] AS W
WHERE DP.[Id] = W.[DepartmentId]
GROUP BY DP.[Building]
	--- другий варіант ---
	SELECT DP.[Building] AS 'Номер корпусу', COUNT(W.[DepartmentId]) AS 'Кільіксть палат'
	FROM [Departments] AS DP
	JOIN [Wards] AS W ON DP.[Id] = W.[DepartmentId]
	GROUP BY DP.[Building]

--3. Вивести назви відділень та кількість палат у кожному з них.

SELECT DP.[Name] AS 'Назва відділення', COUNT(W.[DepartmentId]) AS 'Кільіксть палат'
FROM [Departments] AS DP, [Wards] AS W
WHERE DP.[Id] = W.[DepartmentId]
GROUP BY DP.[Name]
--- другий варіант ---
	SELECT DP.[Name] AS 'Назва відділення', COUNT(W.[DepartmentId]) AS 'Кільіксть палат'
	FROM [Departments] AS DP
	JOIN [Wards] AS W ON DP.[Id] = W.[DepartmentId]
	GROUP BY DP.[Name]

--4. Вивести назви відділень та сумарну надбавку лікарів у
--кожному з них.
SELECT S.[Name] AS 'Назва відділення', SUM(D.[Premium]) AS 'Сумарна надбавка'
FROM [Specializations] AS S, [Doctors] AS D, [DoctorsSpecializations] AS DS
WHERE S.[Id] = DS.[SpecializationId] AND D.[Id] = DS.[DoctorId]
GROUP BY S.[Name]
--- другий варіант ---
	SELECT S.[Name] AS 'Назва відділення', SUM(D.[Premium]) AS 'Сумарна надбавка'
	FROM [Specializations] AS S
	JOIN [DoctorsSpecializations] AS DS ON S.[Id] = DS.[SpecializationId]
	JOIN [Doctors] AS D ON D.[Id] = DS.[DoctorId]
	GROUP BY S.[Name]

--5. Вивести назви відділень, у яких проводять обстеження 5
--та більше лікарів.

SELECT DP.[Name] AS 'Назва відділення'
FROM [Departments] AS DP, [Wards] AS W, [DoctorsExaminations] AS DE
WHERE DP.[Id] = W.[DepartmentId] AND W.[Id] = DE.[WardId]
GROUP BY DP.[Name]
HAVING COUNT(DE.[DoctorId])>=5
	--- другий варіант ---
	SELECT DP.[Name] AS 'Назва відділення'
	FROM [Departments] AS DP
	JOIN [Wards] AS W ON DP.[Id] = W.[DepartmentId]
	JOIN [DoctorsExaminations] AS DE ON W.[Id] = DE.[WardId]
	GROUP BY DP.[Name]
	HAVING COUNT(DE.[DoctorId])>=5
--6. Вивести кількість лікарів та їх сумарну зарплату (сума
--ставки та надбавки).
SELECT COUNT(*) AS 'Кількість лікарів', SUM([Premium]) + SUM([Salary]) AS 'Сумарна зарплата'
FROM [Doctors]

--7. Вивести середню зарплату (сума ставки та надбавки) лікарів.

SELECT AVG([Premium])+ AVG([Salary])AS 'Середня зарплата'
FROM [Doctors]

--8. Вивести назви палат із мінімальною місткістю.

SELECT W.[Name] AS 'Назва'
FROM [Wards] AS W
WHERE W.[Places] = (SELECT MIN(W.[Places]) FROM [Wards] AS W);

--9. Вивести в яких із корпусів 1, 6, 7 та 8 (частини корпусів не передбачено умовами завдання, тому взяв корпуси 2, 4, 5), сумарна кількість
--місць у палатах перевищує 20. При цьому враховувати лише палати з кількістю місць більше 8.

SELECT DP.[Building] AS 'Номер корпусу', SUM(W.[Places]) AS 'Кількість мість'
FROM [Wards] AS W
JOIN [Departments] AS DP ON DP.[Id] = W.[DepartmentId]
WHERE DP.[Building] IN (2, 4, 5) AND W.[Places] > 8
GROUP BY DP.[Building]
HAVING SUM(W.[Places]) > 20;

DROP TABLE [Wards]
DROP TABLE [Vacations]
DROP TABLE [Donations]
DROP TABLE [Sponsors]
DROP TABLE [DoctorsSpecializations]
DROP TABLE [Specializations]
DROP TABLE [Doctors]
DROP TABLE [Departments]
DROP TABLE [DoctorsExaminations]
DROP TABLE [Examinations]