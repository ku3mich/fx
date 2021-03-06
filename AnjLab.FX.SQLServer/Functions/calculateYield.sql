if exists (select * from sysobjects where id = object_id(N'fx.calculateYield') and xtype in (N'FN', N'IF', N'TF'))
	drop function fx.calculateYield

set quoted_identifier on
go

/*
<documentation>
<summary>
	Returns yield (in %%), based on time period (taking into account leap years) 
	and revenue.
</summary>

<parameters>
<param name="Start">Period start date</param>
<param name="End">Period finish date</param>
<param name="PresentValue">Price at start date</param>
<param name="FutureValue">Price at end date</param>
</parameters>

<returns>
	Yield as percentage
</returns>

<example>
	-- This example shows yield for paper which price will grow up twice in next ~3 years (1000 days)
	print fx.calculateYield(getDate(), getDate() + 1000, 100.00, 200.00)
	-- 36.5191
</example>

<author>
	Alex Zakharov
	Copyright (c) AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>
</documentation>
*/

create function [fx].[calculateYield](@Start datetime, @End datetime, @PresentValue money, @FutureValue money) 
returns float as
begin

declare @Yield float

select @Yield = 
	100 * ((@FutureValue - @PresentValue ) / @PresentValue ) * 
	1 / (cast(sum([Days] * cast(LeapYear - 1 as bit)) as real) / 365 + cast(sum([Days] * LeapYear) as real) / 366)
from (
	select 
		datediff(dd, YearStartDate, YearEndDate) as [Days],
		fx.checkLeapYear(YearStartDate) as LeapYear
	from (
		select 
			YearStartDate = case Years when year(@Start) then @Start else '01/01/' + str(Years) end,
			YearEndDate   = case Years when year(@End)   then @End	 else '01/01/' + str(Years + 1) end
		from (
			select year(@Start) + RecordId - 1 as Years
			from fx.getEmptyTable(datediff(year, @Start, @End) + 1)
		) as a
	) as b
) as c


return @Yield

end

go

