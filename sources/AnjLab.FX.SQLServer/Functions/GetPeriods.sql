if exists (select * from sysobjects where id = object_id(N'fx.GetPeriods') and xtype in (N'FN', N'IF', N'TF'))
drop function fx.GetPeriods
go

/*
<summary>
	Returns set of date and time periods (hours, days, months, etc) between given start 
	and end dates
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2010, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<param name="Grouping">Grouping mode, i.e. period length. Possible values:
	1 - second
	2 - minute
	3 - hour
	4 - day
	5 - month
	6 - year
</param>
<param name="Start">Start of period</param>
<param name="Finish">End of period</param>

<returns>Table with four columns:
	PeriodNumber
	PeriodStart
	PeriodEnd
	PeriodLabel - value of hour, day, month, etc 
<returns>

<example>
	This example returns sequence of hours for last 24 hours
	select * from  fx.GetPeriods(3, dateadd(dd, -1, getDate()), getDate())
</example>
*/


create function fx.GetPeriods(@Grouping int, @Start datetime, @End datetime) 
returns @Table table(PeriodStart datetime, PeriodEnd datetime, PeriodNumber int, PeriodLabel nvarchar(100))
as
begin

	set @Start = fx.ReduceDate(@Grouping, @Start, 0)
	set @End = fx.ReduceDate(@Grouping, @End, 1)

	declare @Distance int
	set @Distance = case @Grouping 
		when 1 then datediff(ss, @Start, @End) + 1
		when 2 then datediff(mi, @Start, @End) + 1
		when 3 then datediff(hh, @Start, @End) + 1
		when 4 then datediff(dd, @Start, @End) + 1
		when 5 then datediff(mm, @Start, @End) + 1
		when 6 then datediff(yy, @Start, @End) + 1
		else 1
		end
		
	insert into @Table
	select 
		StartDate = [Date],
		EndDate = fx.ReduceDate(@Grouping, [Date], 1),
		PeriodNumber = RecordID,
		[Label] =case @Grouping
			when 1 then datename(ss, [Date])
			when 2 then datename(mi, [Date])
			when 3 then datename(hh, [Date])
			when 4 then datename(dd, [Date])
			when 5 then datename(mm, [Date])
			when 6 then datename(yy, [Date])
			else 'All data'
			end
	from (
		select RecordID, [Date] = case @Grouping
			when 1 then dateadd(ss, RecordID - 1, @Start)
			when 2 then dateadd(mi, RecordID - 1, @Start)
			when 3 then dateadd(hh, RecordID - 1, @Start)
			when 4 then dateadd(dd, RecordID - 1, @Start)
			when 5 then dateadd(mm, RecordID - 1, @Start)
			when 6 then dateadd(yy, RecordID - 1, @Start)
			else @Start
			end
		from fx.GetEmptyRowSet(@Distance)
	) as a
	order by [Date]
		
	return

end

	