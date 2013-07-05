/* 
<summary>
	Scripts data for all tables and saves scripts as sql files
</summary>

<remarks>
	Supported object types:
	- Tables (including constraints and indexes)
	- Views
	- Stored procedures
	- Functions
	- Triggers
	
	Also, there are some limitations noted in stored procedures
	- fx.scriptObject
	- fx.scriptTable
	
	Encrypted objects are not supported. Use fx.scriptEncryptedObject 
	to get definition of encrypted object
	
	OLE automation procedures mast be switched on. See details in
	fx.writeStringToFile
</remarks>

<author>
	Alex Zakharov
	Copyright © AnjLab 2011, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>
*/


set nocount on

declare 
	@Schema sysname,
	@Type sysname,
	@Object sysname,
	@Folder nvarchar(max),
	@Text nvarchar(max)

set @Folder = 'D:\Test\Data'

print 'Start scripting'

declare AllObjects cursor for
	select b.name as SchemaName, a.name as ObjectName
	from sys.objects a
	inner join sys.schemas b on b.schema_id = a.schema_id
	where is_ms_shipped = 0 and a.type= 'U'
	
open AllObjects
fetch next from AllObjects into @Schema, @Object

while @@fetch_status = 0
begin
	
	print ' * ' + @Schema + N'.' + @Object
	
	exec fx.scriptData @Schema, @Object, @PrintResult = 0, @Result = @Text output
	set @Object = @Object + N'.sql'

	exec fx.writeStringToFile @Text, @Folder, @Object
	
	fetch next from AllObjects into @Schema, @Object

end

close AllObjects
deallocate AllObjects

print 'Done'

go
