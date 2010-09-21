if exists (select * from sysobjects where id = object_id(N'fx.Div') and xtype in (N'FN', N'IF', N'TF'))
drop function fx.Div
go


/*
<summary>
	Divides one number by another
</summary>

<notes>
	Comparing with standard dividing (/) this function has two features:
	- replaces zero divisor with null to avoid divide by zero error
	- converts dividend and divisor to float to get float result
</notes>

<author>
	Alex Zakharov
	Copyright © AnjLab 2010, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>

<param name="Divident">Divident</param>
<param name="Divisor">Divisor</param>

<returns>float or null if divisor is zero</returns>

<example>
	Example 1. Divide integer by integer
		print fx.Div(5, 2)
		> 2.5 Compare with print 5/2 that returns 2
	
	Example 2. Divide by zero
		print fx.Div(1, 0)
		returns nothing
</example>
*/

create function fx.Div(@Dividend float, @Divisor float) 
returns float as 
begin
	return @Dividend / case @Divisor when 0 then null else @Divisor end
end
