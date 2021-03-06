if exists (select * from sysobjects where id = object_id(N'fx.getStringAsTable') and xtype in (N'FN', N'IF', N'TF'))
	drop function fx.getStringAsTable

set quoted_identifier on
go

/*
<documentation>
<summary>
	Returns rowset from string with delimiters
</summary>

<parameters>
<param name="String">String to be parsed</param>
<param name="Delimeter">Delimeter. Can be one or more chars</param>
</parameters>

<returns>
	Table with one column [Value]
</returns>

<example>
	select * from fx.getStringAsTable(N'abc, d, e f', N',')
	-- 
	--	abc
	--	d
	--	e f
</example>

<author>
	Alex Zakharov
	Copyright © AnjLab 2010, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>
</documentation>
*/

create function [fx].[getStringAsTable](@String nvarchar(max), @Delimiter nvarchar(10)) 
returns @Data table([Value] nvarchar(max)) as
begin

	while charindex(@Delimiter,@String) > 0
	begin
		insert into @Table	values(substring(@String,1,charindex(@Delimiter,@String)-1))

		set @String = substring(
			@String,
			charindex(@Delimiter,@String) + 1,
			len(@String) - charindex(@Delimiter,@String))
	end
	insert into @Table values(@String)
/*

	with Data(Test) as (select Test = cast(N'<a>' + replace(@String, @Delimiter, N'</a><a>') + '</a>' as xml))
		insert into @Data
		select ltrim(Nodes.Node.value(N'.', N'nvarchar(255)')) as [Value]
		from Data
		cross apply Test.nodes (N'//a') Nodes(Node)
*/
	return

end

go
