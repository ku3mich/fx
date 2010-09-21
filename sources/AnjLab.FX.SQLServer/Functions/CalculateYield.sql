if exists (select * from sysobjects where id = object_id(N'fx.CalculateYield') and xtype in (N'FN', N'IF', N'TF'))
drop function fx.CalculateYield
go

/*
<summary>
	Returns yield (in %%), based on time period (taking into account leap years) 
	and revenue.
<summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<param name="Start">Period start date</param>
<param name="End">Period finish date</param>
<param name="PresentValue">Price at start date</param>
<param name="FutureValue">Price at end date</param>

<returns>Yield as percentage</returns>

<example>
	This example shows yield for paper which price will grow up twice in next ~3 years (1000 days)
	print fx.CalculateYield(getDate(), getDate() + 1000, 100.00, 200.00)
	> 36.5191
</example>
*/

create function fx.CalculateYield(@Start datetime, @End datetime, @PresentValue money, @FutureValue money) 
returns float as
begin

declare @Yield float

select @Yield = 
	100 * ((@FutureValue - @PresentValue ) / @PresentValue ) * 
	1/(cast(sum([Days] * cast(LeapYear - 1 as bit)) as real)/365 + cast(sum([Days] * LeapYear) as real)/366)
from (
	select 
		datediff(dd, YearStartDate, YearEndDate) as [Days],
		fx.CheckLeapYear(YearStartDate) as LeapYear
	from (
		select 
			YearStartDate = case Years when year(@Start) then @Start else '01/01/' + str(Years) end,
			YearEndDate   = case Years when year(@End)   then @End	 else '01/01/' + str(Years + 1) end
		from (
			select year(@Start) + RecordId - 1 as Years
			from fx.GetEmptyRowSet(datediff(year, @Start, @End) + 1)
		) as a
	) as b
) as c


return @Yield

end

GO
