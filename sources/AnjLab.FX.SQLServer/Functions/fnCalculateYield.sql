if exists (select * from sysobjects where id = object_id(N'fx.fnCalculateYield') and xtype in (N'FN', N'IF', N'TF'))
drop function fx.fnCalculateYield
go

/*
<summary>
	This funtion returns yield (in %%), based on time period (taking into account leap years) 
	and revenue.
<summary>

<author>
	Alex Zakharov
	Copyright � AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<date>09\27\2007</date>

<example>
	NOTE: table valued function fx.fnGetEmptyRowSet and scalar function fx.fnCheckLeapYear
	must be created before using.
	PRINT fx.fnCalculateYield(getDate(), getDate()+1000, 100.00, 200.00)
</example>
*/

CREATE FUNCTION fx.fnCalculateYield(@StartDate datetime, @EndDate datetime, @PresentValue money, @FutureValue money) 
RETURNS real AS
BEGIN

DECLARE @Yield real

SELECT @Yield = 
	100 * ((@FutureValue - @PresentValue ) / @PresentValue ) * 
	1/(cast(sum(Days * cast(LeapYear - 1 as bit)) as real)/365 + cast(sum(Days * LeapYear) as real)/366)
FROM (
	SELECT 
		datediff(day, YearStartDate, YearEndDate) as Days,
		fx.fnCheckLeapYear(YearStartDate) as LeapYear
	FROM (
		SELECT 
			YearStartDate = CASE Years WHEN year(@StartDate) THEN @StartDate ELSE '01/01/' + str(Years) END,
			YearEndDate   = CASE Years WHEN year(@EndDate)   THEN @EndDate	 ELSE '01/01/' + str(Years + 1) END
		FROM (
			SELECT Year(@StartDate) + RecordId - 1 as Years
			FROM fx.fnGetEmptyRowSet(datediff(year, @StartDate, @EndDate) + 1)
		) as a
	) as b
) as c


RETURN @Yield

END

GO
