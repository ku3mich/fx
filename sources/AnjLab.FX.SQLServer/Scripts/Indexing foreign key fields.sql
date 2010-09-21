/* 
<summary>
	Creates non-clustered indexes for all fields which are used in foreign keys,
	if they are not indexed. Index name template is ix<table name><column name>.
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>
*/

set nocount on 

declare ForeignKeys cursor for
	select s.name as schemaname, t.name as tabname, c.name as colname
	from sys.foreign_keys fk 
	inner join sys.tables t on t.object_id = fk.parent_object_id
	inner join sys.schemas s on s.schema_id = t.schema_id
	inner join sys.foreign_key_columns fkc on fkc.constraint_object_id = fk.object_id
	inner join sys.columns c on c.object_id = fkc.parent_object_id and c.column_id = fkc.parent_column_id


declare 
	@tabname nvarchar(255), 
	@colname nvarchar(255), 
	@schemaname nvarchar(255), 
	@sql nvarchar(max)

print 'Indexing columns used for foreign keys'

open ForeignKeys
fetch next from ForeignKeys into @schemaname, @tabname, @colname
while @@fetch_status = 0
begin
	-- check existance of index for given table which include only one (given) column
	if not exists (
		select i.object_id from sys.indexes i
		inner join sys.index_columns ic on ic.object_id = i.object_id and ic.index_id = i.index_id
		inner join sys.tables t on t.object_id = i.object_id
		inner join sys.columns c on c.object_id = i.object_id and c.column_id = ic.column_id
		where t.name = @tabname and c.name = @colname
		group by i.object_id, i.index_id
		having count(*) = 1)
	begin
		begin try
			set @sql = N'create nonclustered index ix'+ @tabname + @colname + N' on [' + @schemaname + N'].[' + @tabname + N']([' + @colname + N'] asc)'
			--print @sql
			exec sp_executesql @sql
			print N' * Index ' + N'ix' + @tabname + @colname + N' is created.'
		end try
		begin catch
			print N' * Error while creating index: ' + N'ix' + @tabname + @colname
		end catch
	end
	fetch next from ForeignKeys into @schemaname, @tabname, @colname
end

close ForeignKeys
deallocate ForeignKeys

print 'Done'

go