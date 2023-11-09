--CREATE DATABASE Hospital
--GO
--USE Hospital
--CREATE TABLE [Departments]
--(
--	[Id] INT PRIMARY KEY IDENTITY,
--	[Building] INT NOT NULL,
--	[Financing] MONEY NOT NULL DEFAULT(0),
--	[Floor] INT NOT NULL,
--	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
--	CONSTRAINT CHK_Building CHECK ([Building] > 0 AND [Building] < 6),
--	CONSTRAINT CHK_Financing CHECK ([Financing] > 0),
--	CONSTRAINT CHK_Floor CHECK ([Floor] > 0),
--);
--CREATE TABLE [Diseases]
--(
--	[Id] INT PRIMARY KEY IDENTITY,
--	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
--	[Severity] INT NOT NULL DEFAULT(1),
--	CONSTRAINT CHK_Severity CHECK ([Severity] > 0 ),
--);
--CREATE TABLE [Doctors]
--(
--	[Id] INT PRIMARY KEY IDENTITY,
--	[Name] NVARCHAR(MAX) NOT NULL CHECK ([Name] !=''),
--	[Phone] CHAR(10) NOT NULL,
--	[Premium] MONEY NOT NULL DEFAULT(0),
--	[Salary] MONEY NOT NULL,
--	[Surname] NVARCHAR(MAX) NOT NULL CHECK ([Surname] !=''),
--	CONSTRAINT CHK_Premium CHECK ([Premium] >= 0 ),
--	CONSTRAINT CHK_Salary CHECK ([Salary] > 0 ),
--);
--CREATE TABLE [Examinations]
--(
--	[Id] INT PRIMARY KEY IDENTITY,
--	[DayOfWeek] INT NOT NULL,
--	[EndTime] TIME NOT NULL,
--	[Name] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] !=''),
--	[StartTime] TIME NOT NULL,
--	CONSTRAINT CHK_DayOfWeek CHECK ([DayOfWeek] > 0 AND [DayOfWeek] < 8),
--	CONSTRAINT CHK_EndTime CHECK ([EndTime] > [StartTime]),
--	CONSTRAINT CHK_StartTime CHECK ([StartTime] > '07:59:59' AND [StartTime] < '18:00:01'),
--);
--CREATE TABLE [Wards]
--(
--	[Id] INT PRIMARY KEY IDENTITY,
--	[Building] INT NOT NULL,
--	[Floor] INT NOT NULL CHECK ([Floor] > 0),
--	[Name] NVARCHAR(20) NOT NULL UNIQUE CHECK ([Name] !=''),
--	CONSTRAINT CHK_Buildings CHECK ([Building] > 0 AND [Building] < 6),
--);
--INSERT INTO [Departments] ([Building], [Financing], [Floor], [Name])
--VALUES
--    (1, 50000, 3, N'Відділ хірургії'),
--    (2, 30000, 2, N'Відділ анестезіології'),
--    (3, 20000, 4, N'Терапевтичний відділ'),
--    (5, 29000, 1, N'Відділ травматології'),
--    (1, 28000, 5, N'Відділ гінекології'),
--    (2, 20000, 3, N'Відділ радіології'),
--    (3, 42000, 2, N'Відділ кардіології'),
--    (4, 48000, 5, N'Відділ неврології'),
--    (5, 60000, 1, N'Відділ онкології'),
--    (1, 25000, 4, N'Відділ дерматології');

--INSERT INTO [Diseases] ([Name], [Severity])
--VALUES
--    (N'Грип', 2),
--    (N'Гепатит', 3),
--    (N'Діабет', 2),
--    (N'Астма', 2),
--    (N'Інсульт', 4),
--    (N'Серцева недостатність', 3),
--    (N'Ангіна', 3),
--    (N'Гіпертонія', 2),
--    (N'Артрит', 2),
--    (N'Грижа', 2),
--    (N'Остеоартроз', 2),
--    (N'Пневмонія', 3),
--    (N'Бронхіт', 2),
--    (N'Грибок', 1),
--    (N'Шизофренія', 4),
--    (N'Депресія', 3),
--    (N'Біполярний розлад', 4),
--    (N'Рак', 5),
--    (N'Інфаркт', 4);

--INSERT INTO [Doctors] ([Name], [Phone], [Premium], [Salary], [Surname])
--VALUES
--    (N'Іван', '1234567890', 500, 80000, N'Петров'),
--    (N'Олена', '9876543210', 300, 75000, N'Іванова'),
--    (N'Михайло', '5678901234', 1000, 90000, N'Сидоров'),
--    (N'Анна', '3456789012', 200, 72000, N'Коваленко'),
--    (N'Павло', '4567890123', 600, 85000, N'Григоренко'),
--    (N'Наталія', '2345678901', 700, 82000, N'Мельник'),
--    (N'Олег', '6789012345', 400, 78000, N'Кузьмин'),
--    (N'Людмила', '7890123456', 800, 92000, N'Зайцева'),
--    (N'Сергій', '8901234567', 300, 75000, N'Павленко'),
--    (N'Юлія', '0123456789', 500, 80000, N'Волкова'),
--    (N'Віктор', '1234509876', 200, 72000, N'Дмитренко'),
--    (N'Тетяна', '2345678901', 100, 70000, N'Шевченко'),
--    (N'Дмитро', '3456789012', 300, 75000, N'Мороз'),
--    (N'Оксана', '4567890123', 600, 85000, N'Коваль'),
--    (N'Максим', '5678901234', 400, 78000, N'Максимов'),
--    (N'Євгенія', '6789012345', 500, 80000, N'Скрипка'),
--    (N'Роман', '7890123456', 800, 92000, N'Романов'),
--    (N'Марія', '8901234567', 700, 82000, N'Попова'),
--    (N'Віталій', '0123456789', 300, 75000, N'Жуков'),
--    (N'Ганна', '1234509876', 200, 72000, N'Заєць');

--INSERT INTO [Examinations] ([DayOfWeek], [EndTime], [Name], [StartTime])
--VALUES
--    (1, '09:30:00', N'КТ сканування голови', '08:00:00'),
--    (2, '12:00:00', N'УЗД черевної порожнини', '10:30:00'),
--    (3, '15:30:00', N'Рентген грудної клітки', '14:00:00'),
--    (4, '11:45:00', N'МРТ спинного мозку', '10:00:00'),
--    (5, '17:00:00', N'ЕКГ серця', '16:00:00'),
--    (6, '14:30:00', N'Аналіз крові на біохімію', '13:00:00'),
--    (7, '16:30:00', N'УЗД шлунку', '15:00:00'),
--    (1, '10:30:00', N'Мамографія молочних залоз', '09:00:00'),
--    (2, '13:45:00', N'Реакція Вестерна на ВІЛ', '12:30:00'),
--    (3, '17:30:00', N'Ендоскопія шлунка', '16:00:00'),
--    (4, '10:45:00', N'Томографія легень', '09:00:00'),
--    (5, '15:15:00', N'Аналіз сечі', '14:00:00'),
--    (6, '16:30:00', N'Електрокардіографія', '15:00:00'),
--    (7, '14:00:00', N'Кровний тиск', '13:00:00');

--INSERT INTO [Wards] ([Building], [Floor], [Name])
--VALUES
--    (1, 3, N'Палата 101'),
--    (2, 2, N'Палата 202'),
--    (3, 4, N'Палата 305'),
--    (4, 1, N'Палата 401'),
--    (1, 5, N'Палата 502'),
--    (2, 3, N'Палата 603'),
--    (3, 2, N'Палата 707'),
--    (4, 5, N'Палата 801'),
--    (5, 1, N'Палата 903'),
--    (1, 4, N'Палата 1001'),
--    (2, 2, N'Палата 1103'),
--    (3, 4, N'Палата 1205'),
--    (4, 1, N'Палата 1301'),
--    (1, 5, N'Палата 1402'),
--    (2, 3, N'Палата 1503');

-- 1. Вивести вміст таблиці палат.
SELECT * FROM [Wards]

--2. Вивести прізвища та телефони всіх лікарів.
SELECT [Surname], [Phone] FROM [Doctors]

--3. Вивести всі поверхи без повторень, на яких розміщуються
--палати.
SELECT DISTINCT [Floor] FROM [Wards]

--4. Вивести назви захворювань під ім’ям “Name of Disease”
--та ступінь їхньої тяжкості під ім’ям “Severity of Disease”.
SELECT [Name] AS [Name of Disease], [Severity] AS [Severity of Disease] FROM [Diseases]

--5. Використовувати вираз FROM для будь-яких трьох та-
--блиць бази даних, використовуючи для них псевдоніми.
SELECT [Name] AS [Name of Department] FROM [Departments]
SELECT [Name] AS [Name of Operations] FROM [Examinations]
SELECT [Building] AS [Hull] FROM [Wards]

--6. Вивести назви відділень, розташованих у корпусі 5 та які
--мають фонд фінансування менше 30000.
SELECT [Name] FROM [Departments] WHERE [Building] = 5 AND [Financing] < 30000 

--7. Вивести назви відділень, розташованих у 3-му корпусі з
--фондом фінансування у діапазоні від 12000 до 21000.
SELECT [Name] FROM [Departments] WHERE [Building] = 3 AND [Financing] BETWEEN 12000 AND 21000

--8. Вивести назви палат, розташованих у корпусах 4 та 5 на
--1-му поверсі.
SELECT [Name] FROM [Wards] WHERE [Floor] = 1 AND [Building] BETWEEN 4 AND 5

--9. Вивести назви, корпуси та фонди фінансування відділень,
--розташованих у корпусах 3 або 5 та які мають фонд фі-
--нансування менше 11000 або більше 25000.
SELECT [Name], [Building], [Financing] FROM [Departments] WHERE [Building] IN(3,5) AND [Financing] > 25000 OR [Financing] < 11000

--10. Вивести прізвища лікарів, чия зарплата (сума ставки та
--надбавки) перевищує 90000.
SELECT [Surname] FROM [Doctors] WHERE ([Salary] + [Premium]) > 90000 

--11. Вивести прізвища лікарів, у яких третя частина зарплати пе-
--ревищує сторазову надбавку. (змінив значення для перевірки)
SELECT [Surname] FROM [Doctors] WHERE ([Salary] / 3) > ([Premium] * 100)

--12. Вивести назви обстежень без повторень, які проводяться
--у перші три дні тижня з 12:00 до 16:00.
SELECT DISTINCT [Name] FROM [Examinations] WHERE ([DayOfWeek] BETWEEN 1 AND 3) AND [StartTime] > '12:00:00' AND [EndTime] < '16:00:00'

--13. Вивести назви та номери корпусів відділень, розташованих
--у корпусах 1, 3, 8 або 10.
SELECT [Name], [Building] FROM [Departments] WHERE [Building] IN (1,3,8,10)

--14. Вивести назви захворювань всіх ступенів тяжкості, крім
--1-го та 2-го.
SELECT [Name] FROM [Diseases] WHERE [Severity] > 2

--15. Вивести назви відділень, які не розташовуються в 1-му
--чи 3-му корпусі.
SELECT [Name] FROM [Departments] WHERE [Building] != 1 AND [Building] != 3

--16. Вивести назви відділень, що розташовуються в 1-му або
--3-му корпусі.
SELECT [Name] FROM [Departments] WHERE [Building] = 1 OR [Building] = 3
--або
SELECT [Name] FROM [Departments] WHERE [Building] IN (1,3)

--17. Вивести прізвища лікарів, що починаються на літеру «П».
SELECT [Surname] FROM [Doctors] WHERE [Surname] LIKE 'П%'

--DROP TABLE [Departments]
--DROP TABLE [Diseases]
--DROP TABLE [Doctors]
--DROP TABLE [Examinations]
--DROP TABLE [Wards]