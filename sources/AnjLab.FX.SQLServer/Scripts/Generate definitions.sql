/* 
<summary>
	Generates DDL definitions for all objects of given type in given scheme
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2010, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<param name="Schema">Schema name</param>
<param name="ObjectType">system type: V, TR, P, FN, TF</param>
*/


set nocount on

declare @Schema sysname, @ObjectType sysname, @Object sysname

set @Schema = 'fx'
set @ObjectType = 'FN'
 

declare Objects cursor for 
	select s.name, o.name 
	from sys.objects o 
	inner join sys.schemas s on s.schema_id = o.schema_id
	where o.type in (@ObjectType) and s.name = @Schema
	order by o.name
	
	
open Objects
fetch next from Objects into @Schema, @Object

while @@fetch_status = 0
begin
	--print @Object
	exec fx.ScriptObject @Schema, @Object, 1
	fetch next from Objects into @Schema, @Object
end

close Objects
deallocate Objects
	
	
	




	