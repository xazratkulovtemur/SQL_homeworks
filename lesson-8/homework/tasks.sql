-- Create the table
CREATE TABLE Groupings (
    StepNumber INT,
    Status VARCHAR(10)
);

-- Insert the sample data
INSERT INTO Groupings (StepNumber, Status)
VALUES 
    (1, 'Passed'),
    (2, 'Passed'),
    (3, 'Passed'),
    (4, 'Passed'),
    (5, 'Failed'),
    (6, 'Failed'),
    (7, 'Failed'),
    (8, 'Failed'),
    (9, 'Failed'),
    (10, 'Passed'),
    (11, 'Passed'),
    (12, 'Passed');


--======================================

--TASKS
select min(StepNumber) as MinStepNumber, max(StepNumber) as MaxStepNumber, Status, Count(*) as [Consecutive count]
from
	(
		select 
			g.StepNumber,
			g.Status,
			g.StepNumber - row_number() over(partition by g.Status order by g.StepNumber) as GI
			from Groupings g
	) g1
group by g1.Status, g1.GI;




--===================================================

--second taskk
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);

INSERT INTO [dbo].[EMPLOYEES_N] ([EMPLOYEE_ID], [FIRST_NAME], [HIRE_DATE]) VALUES
-- 1970s hires (sparse)
(1, 'John', '1975-06-15'),
(2, 'Mary', '1977-11-22'),

-- 1980s hires (gap between 1980-1984)
(3, 'Robert', '1985-03-10'),
(4, 'Linda', '1985-03-10'), -- Same day hire
(5, 'James', '1987-09-18'),

-- 1990s hires (gap between 1992-1996)
(6, 'Patricia', '1990-02-28'),
(7, 'Michael', '1991-07-15'),
(8, 'Barbara', '1997-04-03'),
(9, 'William', '1998-12-17'),

-- 2000s hires (gap between 2001-2003)
(10, 'Elizabeth', '2000-01-08'),
(11, 'David', '2004-07-22'),
(12, 'Jennifer', '2005-03-10'),
(13, 'Richard', '2005-08-05'),
(14, 'Susan', '2008-02-14'),

-- 2010s hires (gap between 2012-2014)
(15, 'Joseph', '2010-11-30'),
(16, 'Jessica', '2011-05-19'),
(17, 'Thomas', '2015-01-15'),
(18, 'Sarah', '2016-06-08'),
(19, 'Charles', '2017-09-12'),
(20, 'Karen', '2018-02-20'),

-- 2020s hires (gap between 2021-2023)
(21, 'Nancy', '2020-05-10'),
(22, 'Daniel', '2020-07-22'),
(23, 'Lisa', '2024-11-05'),
(24, 'Matthew', '2024-12-30'),
(25, 'Betty', '2025-03-15'),

-- Additional hires to make >30 records
(26, 'Donald', '1979-04-22'),
(27, 'Dorothy', '1989-10-31'),
(28, 'Paul', '1999-08-14'),
(29, 'Sandra', '2009-06-09'),
(30, 'Mark', '2019-04-01'),
(31, 'Emily', '2025-01-10'),
(32, 'Christopher', '1986-05-05'),
(33, 'Donna', '2006-09-19'),
(34, 'George', '2016-03-03'),
(35, 'Michelle', '2025-02-28');





SELECT 
    CAST(prev.Year + 1 AS VARCHAR) + ' - ' + CAST(next.Year - 1 AS VARCHAR) AS Years
FROM (
    -- Get all years with hiring activity (plus boundaries)
    SELECT Year FROM (
        SELECT DISTINCT YEAR(HIRE_DATE) AS Year 
        FROM [dbo].[EMPLOYEES_N]
        WHERE YEAR(HIRE_DATE) BETWEEN 1975 AND 2025
        UNION
        SELECT 1974 AS Year -- Lower boundary
        UNION
        SELECT 2026 AS Year -- Upper boundary
    ) AS years_with_boundaries
) AS prev
JOIN (
    -- Same subquery as above to join with itself
    SELECT Year FROM (
        SELECT DISTINCT YEAR(HIRE_DATE) AS Year 
        FROM [dbo].[EMPLOYEES_N]
        WHERE YEAR(HIRE_DATE) BETWEEN 1975 AND 2025
        UNION
        SELECT 1974 AS Year
        UNION
        SELECT 2026 AS Year
    ) AS years_with_boundaries
) AS next ON prev.Year < next.Year
-- Find where there's a gap between years
WHERE NOT EXISTS (
    SELECT 1 
    FROM (
        SELECT DISTINCT YEAR(HIRE_DATE) AS Year 
        FROM [dbo].[EMPLOYEES_N]
        WHERE YEAR(HIRE_DATE) BETWEEN 1975 AND 2025
    ) AS middle
    WHERE middle.Year > prev.Year AND middle.Year < next.Year
) 
-- Only show gaps of at least 1 year
AND next.Year - prev.Year > 1
ORDER BY prev.Year + 1;



select 
cast(prev.year+1 as varchar) +  '  - ' + cast(next.year-1 as varchar) as Year_interval
from
(
	select year 
		from(
			select distinct year(HIRE_DATE) as year
			from [dbo].[EMPLOYEES_N]
			where year(HIRE_DATE) between 1975 and 2025
			union 
			select 1974 as year
			union 
			select 2026 as year
		) as year_with_boundires
) as prev
join 
(
	select year from 
		(
			select distinct year(HIRE_DATE) as year
			from [dbo].[EMPLOYEES_N]
			where year(HIRE_DATE) between 1975 and 2025
			union 
			select 1974 as year
			union
			select 2026 as year
		) as year_with_boundires
) as next
on prev.year<next.year
where not exists (
	select 1 from (
		select distinct year(HIRE_DATE) as year
		from [dbo].[EMPLOYEES_N]
		where year(HIRE_DATE) between 1975 and 2025
		) as middle
	where middle.year>prev.year and middle.year<next.year
)
and next.year-prev.year>1
order by prev.year
