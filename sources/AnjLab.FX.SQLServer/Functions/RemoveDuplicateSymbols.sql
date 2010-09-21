if exists (select * from sysobjects where id = object_id(N'fx.RemoveDuplicateSymbols') and xtype in (N'FN', N'if', N'TF'))
	drop function fx.RemoveDuplicateSymbols
go

/*
<summary>
	Returns input string with replaced sequences of several the same given symbols
	with one symbol
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
	The main idea was discussed on http://sql.ru
</author>

<param name="String">Initial string</param>
<param name="Symbol">Symbol, whose sequences will be tuncated</param>

<returns>Truncated string</returns>

<example>
	print fx.RemoveDuplicateSymbols(N'       b    c d     e     ', N' ')
	> ' b c d e '
</example>
*/

create function fx.RemoveDuplicateSymbols(@String nvarchar(max), @Symbol nchar(1))
returns nvarchar(max) as
begin

	return 
		replace(
			replace(
				replace(@String, @Symbol + @Symbol, @Symbol + nchar(1))
				, nchar(1) + @Symbol, space(0))
			, nchar(1), space(0))

end
go