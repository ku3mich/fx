if exists (select * from sysobjects where id = object_id(N'fx.GetStringAsRowset') and xtype in (N'FN', N'IF', N'TF'))
drop function fx.GetStringAsRowset
go

/*
<summary>
	Returns rowset from string with delimiters
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2010, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<param name="String">String to be parsed</param>
<param name="Delimeter">Delimeter. Can be one or more chars</param>

<returns>Table with one column [Value]</returns>

<example>
	select * from fx.GetStringAsRowset(N'abc, d, e f', N',')
	> 
		abc
		d
		e f
</example>
*/

create function fx.GetStringAsRowset(@String nvarchar(max), @Delimiter nvarchar(10)) 
returns @Data table([Value] nvarchar(max)) as
begin

	with Data(Test) as (select Test = cast(N'<a>' + replace(@String, @Delimiter, N'</a><a>') + '</a>' as xml))
		insert into @Data
		select ltrim(Nodes.Node.value(N'.', N'nvarchar(255)')) as [Value]
		from Data
		cross apply Test.nodes (N'//a') Nodes(Node)

	return

end
