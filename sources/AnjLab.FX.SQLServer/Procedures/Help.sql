set nocount on

declare @Documentation xml
declare @Table table (Element nvarchar(100), Name nvarchar(100), [Value] nvarchar(max), HasChildren bit)
declare @Element nvarchar(100), @Name nvarchar(100), @Value nvarchar(max), @HasChildren bit
;
with data(Test) as (
	select Test = (
		select [text] 
		from syscomments 
		where id = object_id('fx.ScriptData')
		for xml path(''), type).value('.','varchar(max)')
)

select @Documentation = 
	substring(Test, 
		charindex('<documentation>', Test, 0) , 
		charindex('</documentation>', Test, 0) - charindex('<documentation>', Test, 0) + 16) 
from data

;
with xml_data as (
    select
        Element     = cast(node.value('fn:local-name(.)', 'varchar(100)') as varchar(100)),
        Name        = node.value('@name', 'nvarchar(100)'),
        [Value]     = node.value('.', 'nvarchar(max)'),
        HasChildren = case when cast(node.query('*') as nvarchar(max)) = space(0) then 0 else 1 end,
        children    = node.query('*')
   from @Documentation.nodes('/*') AS roots(node)
   union all
   select
        Element     = cast(node.value('fn:local-name(.)', 'varchar(100)') as varchar(100)),
        Name        = node.value('@name', 'nvarchar(100)'),
        [Value]     = node.value('.', 'nvarchar(max)'),
        HasChildren = case when cast(node.query('*') as nvarchar(max)) = space(0) then 0 else 1 end,
        children    = node.query('*')
    from xml_data x
    cross apply x.children.nodes('*') AS child(node)
)
	insert into @Table
	select Element, [Name], [Value], HasChildren
	from xml_data
	option (MAXRECURSION 1000)

declare cur_data cursor for 
select * from @Table 
where Element <> 'Documentation'

open cur_data
fetch next from cur_data into @Element, @Name, @Value, @HasChildren

while @@fetch_status = 0
begin
	
	if @Name is null print upper(@Element)
	if @Name is not null and @HasChildren = 0 print '	' + @Name + ': ' + @Value + nchar(10)
	if @Name is null and @HasChildren = 0 print @Value

	fetch next from cur_data into @Element, @Name, @Value, @HasChildren
end

close cur_data
deallocate cur_data