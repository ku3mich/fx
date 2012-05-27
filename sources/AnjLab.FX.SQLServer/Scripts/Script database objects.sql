/* 
<summary>
	Scripts database objects and saves scripts as sql files
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
	@BaseFolder nvarchar(max),
	@Folder nvarchar(255),
	@Text nvarchar(max)

set @BaseFolder = 'D:\Test\'

print 'Start scripting'

declare @ObjectTypes table(
	SystemName sysname collate Latin1_General_CI_AS_KS_WS,
	Folder nvarchar(255))
	
insert into @ObjectTypes values
	(N'U', N'Tables'),
	(N'V', N'Views'),
	(N'P', N'Programmability\Procedures'),
	(N'FN', N'Programmability\Functions'),
	(N'TF', N'Programmability\Functions'),
	(N'TR', N'Programmability\Triggers')

declare AllObjects cursor for
	select b.name as SchemaName, c.SystemName as TypeName, c.Folder, a.name as ObjectName
	from sys.objects a
	inner join sys.schemas b on b.schema_id = a.schema_id
	inner join @ObjectTypes c on c.SystemName = a.type
	where is_ms_shipped = 0
	
open AllObjects
fetch next from AllObjects into @Schema, @Type, @Folder, @Object

while @@fetch_status = 0
begin
	
	print ' * ' + @Schema + N'.' + @Object
	
	if @Type = 'U' 
		exec fx.scriptTable @Schema, @Object, @PrintResult = 0, @Result = @Text output
	else 
		exec fx.scriptObject @Schema, @Object, @PrintResult = 0, @Result = @Text output
		
	set @Folder = @BaseFolder + @Folder	
	set @Object = @Object + N'.sql'
	exec fx.writeStringToFile @Text, @Folder, @Object
	
	fetch next from AllObjects into @Schema, @Type, @Folder, @Object

end

close AllObjects
deallocate AllObjects

print 'Done'

go
