set nocount on
print 'Removing FX schema'

if exists(select * from sys.schemas where name = 'fx')
begin

	declare @SQL nvarchar(255)
	declare Objects cursor for 
		select 'drop ' + case o.type
			when 'U' then 'table '
			when 'P' then 'procedure '
			when 'FN' then 'function '
			when 'TF' then 'function '
			when 'V' then 'view '
			end + 'fx.' + o.name as Command from sys.objects o
		inner join sys.schemas s on s.schema_id = o.schema_id
		where s.name = 'fx' and o.type in ('U', 'P', 'FN', 'TF', 'V')
	union all
		select 'drop type fx.' + t.name as Command from sys.types t
		inner join sys.schemas s on s.schema_id = t.schema_id
		where s.name = 'fx'
	union all
		select 'delete from sysdiagrams where [Name] = ''fx''' as Command
	union all
		select 'drop schema fx' as Command

	open Objects
	fetch next from Objects into @SQL
	while @@fetch_status = 0
	begin
		begin try
			exec sp_executesql @SQL
		end try
		begin catch
			print 'Error oocured during executing a command: ' + @SQL
			print 'Exception: ' + error_message()
		end catch
		fetch next from Objects into @SQL
	end

	close Objects
	deallocate Objects
	print 'Done'

end 	
else print 'FX schema is not found'
