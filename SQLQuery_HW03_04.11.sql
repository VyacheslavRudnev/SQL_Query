CREATE DATABASE Academy
GO
USE Academy
CREATE TABLE [Departments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
	CONSTRAINT CHK_Financing CHECK ([Financing] >= 0),
);
CREATE TABLE [Faculties]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Dean] NVARCHAR(MAX) NOT NULL CHECK ([Dean] !=''),
	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
);
CREATE TABLE [Groups]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(10) NOT NULL UNIQUE CHECK ([Name] !=''),
	[Rating] INT NOT NULL,
	[Year] INT NOT NULL,
	CONSTRAINT CHK_Rating CHECK ([Rating] > 0 AND [Rating] <=5),
	CONSTRAINT CHK_Year CHECK ([Year] > 0 AND [Year] <=5),
);
CREATE TABLE [Teachers]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[EmploymentDate] DATE NOT NULL CHECK ([EmploymentDate] > '1990-01-01'),
	[IsAssistant] BIT NOT NULL DEFAULT(0),
	[IsProfessor] BIT NOT NULL DEFAULT(0),
	[Name] NVARCHAR(MAX) NOT NULL CHECK ([Name] !=''),
	[Position] NVARCHAR(MAX) NOT NULL CHECK ([Position] !=''),
	[Premium] MONEY NOT NULL DEFAULT(0),
	[Salary] MONEY NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL CHECK ([Surname] !=''),
	CONSTRAINT CHK_Premium CHECK ([Premium] > 0),
	CONSTRAINT CHK_Salary CHECK ([Salary] >= 0),
);
INSERT INTO [Departments]([Financing],[Name])
VALUES
	(49000, N'Кафедра інформатики'),
    (40000, N'Кафедра економіки'),
    (33000, N'Кафедра медицини'),
    (9000, N'Кафедра фізики'),
    (10000, N'Кафедра хімії'),
    (15000, N'Кафедра історії'),
    (25000, N'Кафедра математики'),
    (11000, N'Кафедра філології'),
    (21000, N'Кафедра біології'),
    (5000, N'Кафедра психології');

INSERT INTO [Faculties]([Dean],[Name])
VALUES
	(N'Іванов Іван Іванович', N'Факультет інформатики'),
    (N'Петрова Олена Михайлівна', N'Факультет економіки'),
    (N'Сидоров Михайло Петрович', N'Факультет медицини'),
    (N'Коваленко Анна Василівна', N'Факультет фізики'),
    (N'Зайцев Олег Максимович', N'Факультет хімії'),
    (N'Мельник Наталія Олександрівна', N'Факультет історії'),
    (N'Григоренко Павло Вікторович', N'Факультет математики'),
    (N'Кузьмин Іван Олександрович', N'Факультет філології'),
    (N'Павленко Сергій Андрійович', N'Факультет біології'),
    (N'Волкова Юлія Олексіївна', N'Факультет психології');

INSERT INTO [Groups] ([Name], [Rating], [Year])
VALUES
    (N'Group 1A', 4, 1),
    (N'Group 2B', 3, 2),
    (N'Group 1C', 5, 1),
    (N'Group 3D', 2, 3),
    (N'Group 2E', 4, 2),
    (N'Group 1F', 5, 1),
    (N'Group 3G', 3, 3),
    (N'Group 4H', 4, 4),
    (N'Group 3I', 5, 3),
    (N'Group 1J', 3, 1),
    (N'Group 4K', 4, 4),
    (N'Group 2L', 5, 2),
    (N'Group 3M', 2, 3),
    (N'Group 4N', 3, 4),
    (N'Group 2O', 4, 2),
    (N'Group 1P', 5, 1),
    (N'Group 4Q', 3, 4),
    (N'Group 3R', 4, 3),
    (N'Group 2S', 2, 2),
    (N'Group 1T', 3, 1);

INSERT INTO [Teachers] ([EmploymentDate], [IsAssistant], [IsProfessor], [Name], [Position], [Premium], [Salary], [Surname])
VALUES
    ('2000-03-15', 1, 0, N'Іван', N'Викладач', 500, 10500, N'Петров'),
    ('2005-06-10', 0, 1, N'Олена', N'Професор', 800, 8000, N'Іванова'),
    ('1999-11-20', 1, 0, N'Михайло', N'Викладач', 200, 7000, N'Сидоров'),
    ('2002-09-01', 1, 0, N'Анна', N'Викладач', 550, 6500, N'Коваленко'),
    ('2008-07-05', 0, 1, N'Павло', N'Професор', 1000, 9000, N'Григоренко'),
    ('1998-02-12', 1, 0, N'Наталія', N'Викладач', 150, 7500, N'Мельник'),
    ('2003-04-28', 0, 1, N'Олег', N'Професор', 120, 10000, N'Кузьмин'),
    ('2007-10-03', 1, 0, N'Людмила', N'Викладач', 650, 7200, N'Зайцева'),
    ('1995-08-15', 1, 0, N'Сергій', N'Викладач', 550, 6500, N'Павленко'),
    ('2000-01-30', 0, 1, N'Юлія', N'Професор', 155, 8500, N'Волкова'),
    ('2004-05-25', 0, 1, N'Віктор', N'Професор', 650, 8000, N'Дмитренко'),
    ('2006-12-18', 1, 0, N'Тетяна', N'Викладач', 600, 7000, N'Шевченко'),
    ('2001-08-22', 1, 0, N'Дмитро', N'Викладач', 600, 7000, N'Мороз'),
    ('2009-03-07', 0, 1, N'Оксана', N'Професор', 100, 9500, N'Коваль'),
    ('1997-06-14', 0, 1, N'Максим', N'Професор', 1000, 9000, N'Максимов');
--Запити
--1. Вивести таблицю кафедр, але розташувати її поля у зво-
--ротному порядку.
SELECT [Name],[Financing] FROM [Departments];
--2. Вивести назви груп та їх рейтинги, використовуючи, як
--назви полів, що виводяться, “Group Name” та “Group Rating”
--відповідно.
SELECT [Name] AS [Group Name], [Rating] AS [Group Rating] FROM [Groups];
--3. Вивести для викладачів їхнє прізвище, відсоток ставки по
--відношенню до надбавки та відсоток ставки по відношенню
--до зарплати (сума ставки та надбавки).
SELECT 
	[Surname], 
	([Premium] / [Salary]) * 100 AS 'Відсоток ставки відносно надбавки',
    (([Salary] + [Premium]) / [Salary]) * 100 AS 'Відсоток ставки відносно зарплати'
FROM [Teachers];
--4. Вивести таблицю факультетів у вигляді одного поля у та-
--кому форматі: “The dean of faculty [faculty] is [dean].”.
SELECT 'The dean of faculty  ' + [Name] + '  is  ' + [Dean] AS 'Таблиця факультетів' FROM [Faculties]; 
--5. Вивести прізвища викладачів, які є професорами та ставка
--яких перевищує 8000.
SELECT [Surname] FROM [Teachers] 
WHERE [IsProfessor] = 1 AND [Salary] > 8000;
--6. Вивести назви кафедр, фонд фінансування яких менший
--за 11000 або більше 25000.
SELECT [Name] FROM [Departments] 
WHERE [Financing] NOT BETWEEN '11000' AND '25000'; -- або так WHERE [Financing] < 11000 OR [Financing] > 25000;
--7. Вивести назви факультетів, окрім факультету “Computer
--Science”.
SELECT [Name] FROM [Faculties] 
WHERE NOT [Name] = 'Факультет інформатики';
--8. Вивести прізвища та посади викладачів, які не є профе-
--сорами.
SELECT [Surname], [Position] FROM [Teachers]
WHERE NOT [IsProfessor] = 1;
--9. Вивести прізвища, посади, ставки та надбавки асистентів,
--у яких надбавка у діапазоні від 160 до 550.
SELECT [Surname], [Position], [Salary], [Premium] FROM [Teachers]
WHERE [IsAssistant] = 1 AND [Premium] BETWEEN 160 AND 550;
--10. Вивести прізвища та ставки асистентів.
SELECT [Surname], [Salary] FROM [Teachers]
WHERE [IsAssistant] = 1;
--11. Вивести прізвища та посади викладачів, які були прийняті
--на роботу до 01.01.2000.
SELECT [Surname], [Position] FROM [Teachers]
WHERE [EmploymentDate] < '2000-01-01';
--12. Вивести назви кафедр, які в алфавітному порядку розмі-
--щуються до кафедри “Software Development”(в моєму варіанті "Кафедра інформатики"). Поле, що ви-
--водиться повинно мати назву “Name of Department”.
SELECT [Name] AS [Name of Department] FROM [Departments]
WHERE [Name] < 'Кафедра інформатики'
ORDER BY [Name];
--13. Вивести прізвища асистентів, які мають зарплату (сума
--ставки та надбавки) не більше 9000.
SELECT [Surname] FROM [Teachers]
WHERE [IsAssistant] = 1 AND ([Premium] + [Salary]) < 9000;
--14. Вивести назви груп 4-го курсу, які мають рейтинг у діа-
--пазоні від 2 до 4.
SELECT [Name] FROM [Groups]
WHERE [Year] = 4 AND [Rating] BETWEEN 2 AND 4;
--15. Вивести прізвища асистентів зі ставкою менше 8000 або
--надбавкою менше 200.
SELECT [Surname] FROM [Teachers]
WHERE [IsAssistant] = 1 AND [Salary] < 8000 OR [Premium] < 200;