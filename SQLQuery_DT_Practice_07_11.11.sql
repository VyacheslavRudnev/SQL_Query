CREATE DATABASE Hospital_2
GO
USE Hospital_2
CREATE TABLE [Departments]
(
    [Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Financing] MONEY NOT NULL DEFAULT 0,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_Name CHECK ([Name] !=''),
	CONSTRAINT CHK_Building CHECK ([Building] BETWEEN 1 AND 5),
	CONSTRAINT CHK_Financing CHECK ([Financing] >= 0),
);

CREATE TABLE [Diseases]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_DName CHECK ([Name] !=''),
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
CREATE TABLE [Examinations]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DayOfWeek] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_DayOfWeek CHECK ([DayOfWeek] BETWEEN 1 AND 7),
	CONSTRAINT CHK_EName CHECK ([Name] !=''),
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

CREATE TABLE [DoctorsExaminations]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Date] DATE NOT NULL DEFAULT GETDATE(),
	[DiseaseId] INT NOT NULL REFERENCES [Diseases]([Id]),
	[DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
	[ExaminationId] INT NOT NULL REFERENCES [Examinations]([Id]),
	[WardId] INT NOT NULL REFERENCES [Wards]([Id]),
	CONSTRAINT CHK_Date CHECK ([Date] <= GETDATE()),
);


CREATE TABLE [Inters]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
);

CREATE TABLE [Professors]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
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
	CONSTRAINT CHK_DDate CHECK ([Date] <= GETDATE())
);

CREATE TABLE [Vacations]
(
    [Id] INT PRIMARY KEY IDENTITY,
    [EndDate] DATE NOT NULL,
    [StartDate] DATE NOT NULL,
    [DoctorId] INT NOT NULL REFERENCES [Doctors]([Id]),
	CONSTRAINT CHK_EndDate CHECK ([EndDate] > [StartDate])
);


INSERT INTO [Departments] ([Building], [Name]) 
VALUES 
	(1, 'Cardiology'),			--1
	(2, 'Orthopedics'),			--2
	(2, 'Neurology'),			--3
	(3, 'Intensive Treatment'),	--4
	(4, 'Dermatology'),			--5
	(3, 'Emergency Medicine'),	--6
	(5, 'Ophthalmology'),		--7
	(5, 'Gastroenterology'),	--8
	(1, 'General Surgery'),		--9
	(5, 'Microbiology'),		--10
	(4, 'Oncology'),			--11
	(2, 'Physiotherapy');		--12

INSERT INTO [Doctors] ([Name], [Premium], [Salary], [Surname])
VALUES
	('John', 2000, 80000, 'Doe'),			--1
    ('Jane', 1500, 70000, 'Smith'),			--2
    ('Robert', 1000, 60000, 'Johnson'),		--3
    ('Emily', 1200, 75000, 'Williams'),		--4
    ('Michael', 1800, 85000, 'Brown'),		--5
    ('Olivia', 1600, 78000, 'Davis'),		--6
    ('William', 0, 72000, 'Miller'),		--7
    ('Ava', 1700, 82000, 'Moore'),			--8
    ('Daniel', 1100, 65000, 'Clark'),		--9
    ('Sophia', 1400, 73000, 'Taylor'),		--10
    ('Matthew', 1900, 88000, 'White'),		--11
    ('Emma', 1500, 76000, 'Anderson'),		--12
    ('Ethan', 1600, 79000, 'Hill'),			--13
    ('Mia', 1200, 71000, 'Ward'),			--14
    ('Helen', 2000, 90000, 'Williams'),		--15
	('Thomas', 1500, 65000, 'Gerada'),		--16
	('Anthony', 1600, 55000, 'Davis'),		--17
	('Joshua', 1700, 85000, 'Bell'),		--18
	('Anastasia', 1800, 70000, 'Kovalyova'),--19
	('Maxim', 1900, 55000, 'Petrov'),		--20
	('Alexander', 2000, 71000, 'Johnson'),	--21
	('Sophia', 2100, 62000, 'Miller'),		--22
	('Elena', 2200, 60000, 'Sidorova'),		--23
	('Alina', 2200, 45000, 'Fedunk'),		--24
	('Samuel', 2100, 44000, 'Torn');		--25

INSERT INTO [Diseases] ([Name])
VALUES
	('Flu'),
	('Migraine'),
	('Asthma'),
	('Diabetes'),
	('Hypertension'),
	('Arthritis'),
	('Bronchitis'),
	('Pneumonia'),
	('Eczema'),
	('Allergy'),
	('Gastritis'),
	('Hepatitis'),
	('Lupus'),
	('Osteoporosis'),
	('Anemia');

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
	('Oncology'),
	('Physiotherapy');

INSERT INTO [Inters] ([DoctorId])
VALUES
	(3),
	(9),
	(14),
	(17),
	(20),
	(22),
	(23),
	(24),
	(25);
	

INSERT INTO [Professors] ([DoctorId])
VALUES
	(1),
	(2),
	(4),
	(5),
	(6),
	(7),
	(8),
	(10),
	(11),
	(12),
	(13),
	(15),
	(16),
	(18),
	(19),
	(21);

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
	(23, 8),
	(24, 12),
	(25, 12);

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
	('Ward A1', 5, 1),	--1
	('Ward A2', 11, 1), --2
	('Ward A3', 15, 1),	--3
	('Ward B1', 22, 2),	--4
	('Ward B2', 11, 2),	--5
	('Ward S1', 8, 3),	--6
	('Ward R1', 5, 4),	--7	
	('Ward R2', 8, 4),	--8
	('Ward R3', 8, 4),	--9
	('Ward B3', 16, 2),	--10
	('Ward B4', 22, 2),	--11
	('Ward C1', 5, 5),	--12
	('Ward C2', 10, 5),	--13
	('Ward C3', 15, 5),	--14
	('Ward X1', 8, 6),	--15
	('Ward D1', 10, 7),	--16
	('Ward D2', 9, 7),	--17
	('Ward D3', 5, 7),	--18
	('Ward R4', 16, 4),	--19
	('Ward B5', 6, 2),	--20
	('Ward G1', 10, 8),	--21
	('Ward GS1', 6, 9),	--22
	('Ward GS2', 8, 9),	--23
	('Ward M1', 10, 10),	--24
	('Ward M2', 15, 10),	--25
	('Ward O1', 6, 11),	--26
	('Ward O2', 8, 11),	--27
	('Ward F1', 6, 12),	--28
	('Ward F2', 9, 12),	--29
	('Ward A4', 8, 1);	--30
	
INSERT INTO [DoctorsExaminations] ([Date], [DiseaseId], [DoctorId], [ExaminationId], [WardId])
VALUES
	('2023-02-28', 1, 1, 1, 1),
	('2023-03-25', 1, 1, 2, 2),
	('2023-04-20', 2, 2, 3, 3),
	('2023-05-19', 2, 2, 4, 4),
	('2023-05-15', 3, 14, 5, 5),
	('2023-06-10', 3, 14, 6, 6),
	('2023-07-06', 3, 14, 7, 7),
	('2023-08-28', 4, 14, 1, 8),
	('2023-09-20', 4, 3, 2, 9),
	('2023-10-19', 5, 4, 3, 10),
	('2023-11-17', 5, 5, 4, 11),
	('2023-10-05', 6, 6, 5, 12),
	('2023-10-09', 6, 7, 6, 13),
	('2023-01-16', 7, 8, 7, 14),
	('2023-01-26', 7, 9, 1, 15),
	('2023-03-05', 8, 10, 2, 16),
	('2023-04-08', 8, 11, 3, 17),
	('2023-05-10', 9, 12, 4, 18),
	('2023-06-20', 9, 13, 5, 19),
	('2023-07-04', 10, 14, 6, 20),
	('2023-08-22', 10, 15, 7, 21),
	('2023-09-09', 11, 16, 1, 22),
	('2023-10-08', 11, 17, 2, 23),
	('2023-10-15', 12, 18, 3, 24),
	('2023-11-01', 12, 19, 4, 25),
	('2023-11-05', 13, 20, 5, 26),
	('2023-11-10', 13, 21, 6, 1),
	('2023-10-28', 14, 22, 7, 2),
	('2023-09-16', 15, 23, 1, 3);



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
--1. Вивести назви та місткості палат, розташованих у 5-му
--корпусі, місткістю 5 і більше місць, якщо в цьому корпусі
--є хоча б одна палата місткістю понад 14 місць.

SELECT W.[Name] AS 'Назва палати', W.[Places] AS 'Місткість'
FROM [Wards] AS W
WHERE W.[DepartmentId] IN (
	SELECT [Id]
	FROM [Departments]
	WHERE [Building] = 5)
AND W.[Places] >= 5
AND EXISTS (
	SELECT 1
	FROM [Wards] AS W
	WHERE W.[DepartmentId] IN (
        SELECT [Id]
        FROM [Departments]
        WHERE [Building] = 5
    )
    AND W.[Places] > 14
)

--2. Вивести назви відділень, у яких проводилося хоча б одне
--обстеження за останній тиждень.

SELECT DISTINCT D.[Name] AS 'Відділення'
FROM [Departments] AS D
JOIN [Wards] AS W ON D.[Id] = W.[DepartmentId]
JOIN [DoctorsExaminations] AS DE ON W.[Id] = DE.[WardId]
WHERE DE.[Date] >= DATEADD(WEEK, -7, GETDATE())

--3. Вивести назви захворювань, для яких не проводяться
--обстеження.
---- Змінюємо дані таблиці для перевірки запиту ----
	UPDATE [DoctorsExaminations]
	SET [DiseaseId] = 14
	WHERE [DiseaseId] = 9
--- перший вариіант запиту ----
SELECT D.[Name] AS 'Назва захворювання'
FROM [Diseases] AS D
WHERE D.[Id] NOT IN (SELECT DISTINCT DE.[DiseaseId] FROM [DoctorsExaminations] AS DE)
	---- другий варіант запиту ----
	SELECT D.[Name] AS 'Назва захворювання'
	FROM [Diseases] AS D
	WHERE NOT EXISTS (
		SELECT 1
		FROM [DoctorsExaminations] AS DE
		WHERE DE.[DiseaseId] = D.[Id]
	)
--4. Вивести повні імена лікарів, які не проводять обстеження.

--- Змінюємо дані таблиці [DoctorsExaminations] для перевірки запиту ----
	UPDATE [DoctorsExaminations]
	SET [DoctorId] = 
    CASE 
        WHEN [DoctorId] = 21 THEN 17
        WHEN [DoctorId] = 20 THEN 19
        ELSE [DoctorId] -- залишити без змін інші значення
    END
	WHERE [DoctorId] IN (20, 21)

--- запит ---
SELECT D.[Name] + ' ' + D.[Surname] AS 'Лікарі що не проводять обстеження'
FROM [Doctors] AS D
WHERE NOT EXISTS (
	SELECT 1
	FROM [DoctorsExaminations] AS DE
	WHERE DE.DoctorId = D.[Id]
	)

--- додаткова перевірка результатів запиту (лікарів) --- 
SELECT D.[Name] + ' ' + D.[Surname], DE.[ExaminationId]
FROM [Doctors] AS D 
LEFT JOIN [DoctorsExaminations] AS DE
ON D.[Id] = DE.[DoctorId]

--5. Вивести назви відділень, у яких не проводяться обстеження.

SELECT DISTINCT D.[Name] AS 'Відділення'
FROM [Departments] AS D
WHERE NOT EXISTS (
	SELECT 1
	FROM [DoctorsExaminations] AS DE
	WHERE DE.WardId = ANY (
		SELECT W.[Id] 
		FROM [Wards] AS W
		WHERE D.[Id] = W.[DepartmentId])
		)

--6. Вивести прізвища лікарів, які є інтернами.

SELECT D.[Surname] AS 'Прізвище'
FROM [Doctors] AS D
WHERE D.[Id] IN (SELECT I.[Id] FROM [Inters] AS I)

--7. Вивести прізвища інтернів, ставки яких більші, ніж ставка
--хоча б одного з лікарів.

SELECT D.[Surname] AS 'Прізвище'
FROM [Doctors] AS D
JOIN [Inters] AS I ON D.[Id] = I.[DoctorId]
WHERE EXISTS (SELECT 1 
	FROM [Doctors] AS D2
	WHERE D.[Salary] > D2.[Salary]
	)

--8. Вивести назви палат, чия місткість більша, ніж місткість
--кожної палати, що знаходиться в 3-му корпусі.

SELECT W.[Name] AS 'Палата', W.[Places] AS 'Місткість'
FROM [Wards] AS W
JOIN [Departments] AS DP ON W.[DepartmentId] = DP.[Id]
WHERE W.[Places] > (
	SELECT MAX(W2.[Places])
	FROM [Wards] AS W2
    JOIN [Departments] AS DP2 ON W2.[DepartmentId] = DP2.[Id]
    WHERE DP2.[Building] = 3)
AND DP.[Building] <> 3

--9. Вивести прізвища лікарів, які проводять обстеження у
--відділеннях “Ophthalmology” та “Physiotherapy”.

SELECT DISTINCT D.[Surname] AS 'Прізвище лікаря'
FROM [Doctors] AS D
JOIN [DoctorsExaminations] AS DE ON D.[Id] = DE.[DoctorId]
JOIN [Wards] AS W ON W.[Id] = DE.[WardId]
WHERE W.[DepartmentId] IN (
    SELECT [Id] FROM [Departments] WHERE [Name] IN ('Ophthalmology', 'Physiotherapy')
)
--10. Вивести назви відділень, у яких працюють інтерни та
--професори.

SELECT DISTINCT DP.[Name] AS 'Відділення'
FROM [Departments] AS DP
JOIN [Wards] AS W ON DP.[Id] = W.[DepartmentId]
JOIN [DoctorsExaminations] AS DE ON W.[Id] = DE.[WardId]
JOIN [Doctors] AS D ON D.[Id] = DE.[DoctorId]
LEFT JOIN [Inters] AS I ON D.[Id] = I.[DoctorId]
LEFT JOIN [Professors] AS P ON D.[Id] = P.[DoctorId]
WHERE I.[Id] IS NOT NULL OR P.[Id] IS NOT NULL

--11. Вивести повні імена лікарів та відділення у яких вони
--проводять обстеження, якщо відділення має фонд фінан-
--сування понад 20000.
	--- додаю в таблицю загублені дані ----
	UPDATE [Departments]
	SET [Financing] = 
		CASE 
			WHEN [Name] = 'Cardiology' THEN 100000.00
			WHEN [Name] = 'Orthopedics' THEN 45000.00
			WHEN [Name] = 'Neurology' THEN 60000.00
			WHEN [Name] = 'Intensive Treatment' THEN 33000.00
			WHEN [Name] = 'Dermatology' THEN 10000.00
			WHEN [Name] = 'Emergency Medicine' THEN 100000.00
			WHEN [Name] = 'Ophthalmology' THEN 15000.00
			WHEN [Name] = 'Gastroenterology' THEN 10000.00
			WHEN [Name] = 'General Surgery' THEN 85000.00
			WHEN [Name] = 'Microbiology' THEN 20000.00
			WHEN [Name] = 'Oncology' THEN 100000.00
			ELSE [Financing]
		END
	WHERE [Name] IN ('Cardiology', 'Orthopedics', 'Neurology', 'Intensive Treatment', 'Dermatology', 
	'Emergency Medicine', 'Ophthalmology', 'Gastroenterology', 'General Surgery', 'Microbiology', 'Oncology', 'Physiotherapy');

SELECT DISTINCT D.[Name] + ' ' + D.[Surname] AS 'Лікар', DP.[Name] AS 'Відділення'
FROM [Doctors] AS D
JOIN [DoctorsExaminations] AS DE ON D.[Id] = DE.[DoctorId]
JOIN [Wards] AS W ON W.[Id] = DE.[WardId]
JOIN [Departments] AS DP ON DP.[Id] = W.[DepartmentId]
WHERE DP.Financing > 20000

--12. Вивести назву відділення, в якому проводить обстеження
--лікар із найбільшою ставкою.

SELECT DP.[Name] AS 'Відділення', D.[Surname], D.[Salary] --  D.[Surname], D.[Salary] додано для перевірки
FROM [Departments] AS DP
JOIN [Wards] AS W ON DP.[Id] = W.[DepartmentId]
JOIN [DoctorsExaminations] AS DE ON W.[Id] = DE.[WardId]
JOIN [Doctors] AS D ON D.[Id] = DE.[DoctorId]
WHERE DP.[Id] = (
    SELECT TOP 1 DP2.[Id] FROM [Departments] AS DP2
    JOIN [Wards] AS W2 ON DP2.[Id] = W2.[DepartmentId]
    JOIN [DoctorsExaminations] AS DE2 ON W2.[Id] = DE2.[WardId]
    JOIN [Doctors] AS D2 ON D2.[Id] = DE2.[DoctorId]
    ORDER BY D2.[Salary] DESC
)
		--- другий варіант запиту ---
		SELECT DP.[Name] AS 'Відділення', D.[Surname], D.[Salary] --  D.[Surname], D.[Salary] додано для перевірки
		FROM [Doctors] AS D
		JOIN [DoctorsExaminations] AS DE ON D.[Id] = DE.[DoctorId]
		JOIN [Wards] AS W ON W.[Id] = DE.[WardId]
		JOIN [Departments] AS DP ON DP.[Id] = W.[DepartmentId]
		WHERE D.[Salary] = (SELECT MAX([Salary]) FROM [Doctors])

--13. Вивести назви захворювань та кількість проведених за
--ними обстежень

SELECT DS.[Name], COUNT(DE.[DiseaseId]) 
FROM [Diseases] AS DS
JOIN [DoctorsExaminations] AS DE ON DS.[Id] = DE.[DiseaseId]
GROUP BY DS.[Name]






--SELECT * FROM [Wards]
--SELECT * FROM [Vacations]
--SELECT * FROM [Donations]
--SELECT * FROM [Sponsors]
--SELECT * FROM [DoctorsSpecializations]
--SELECT * FROM [Specializations]
--SELECT * FROM [Doctors]
--SELECT * FROM [Departments]
--SELECT * FROM [DoctorsExaminations]
--SELECT * FROM [Examinations]

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