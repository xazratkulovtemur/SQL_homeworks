declare @inputdate date =getdate()

;with cte as (
	--declare @inputdate date ='2025-03-14'
	select DATEFROMPARTS(year(@inputdate), month(@inputdate), 1) as [date],
	datename(WEEKDAY,DATEFROMPARTS(year(@inputdate), month(@inputdate), 1)) as weekdayname,
	DATEPART(WEEKDAY, DATEFROMPARTS(year(@inputdate), month(@inputdate), 1)) as weekdaynum,
	1 as weeknumber
	union all

	select DATEADD(day, 1, [date]),
	datename(weekday, dateadd(day, 1, [date])),
	datepart(weekday,dateadd(day, 1, [date])),
	case
		when datepart(weekday, DATEADD(day, 1, [date]))>weekdaynum then weeknumber
		else weeknumber+1
	end
	from cte
	where [date]<eomonth(@inputdate)
)
select 
max(case when weekdayname='Sunday' then day(date) end) as Sunday,
max(case when weekdayname='Monday' then day(date) end) as Monday,
max(case when weekdayname='Tuesday' then day(date) end) as Tuesday,
max(case when weekdayname='Wednesday' then day(date) end) as Wednesday,
max(case when weekdayname='Thursday' then day(date) end) as Thursday,
max(case when weekdayname='Friday' then day(date) end) as Friday,
max(case when weekdayname='Saturday' then day(date) end) as Saturday 
from cte
group by weeknumber
order by weeknumber


