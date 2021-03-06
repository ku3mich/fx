/*
<documentation>
<summary>
	Performs tests defined for fx programable objects
</summary>

<remarks>
	The procedure extracts value of 'example' tag of object's XML documentation
	(see fx.help for more information) and tries to perform SQL code of examples
	defined there. If there no valid documentation for an object or no examples
	the procedure skips it. Examples should be valid SQL code else test will be failed.
	Test fails in case of any exceptions risen during performing. All results,
	including catched exceptions are included into output table
	
	NOTE:
	- test for fx.scriptEncriptedObject fails if not performed in dedicated access mode (DAC)
	- test for fx.scriptDiagram fails if diagram supporting table are not installed for database
</remarks>

<returns>
	Table with the following colums:
	- Object
	- Result  : 0 if test failed or skipped, 1 if test passed
	- Message : test passed or gatched exception
	The table is sorted by object's name
</returns>

<author>
	Alex Zakharov
	Copyright (c) AnjLab 2011, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>
</documentation>
*/

	set nocount on
	set quoted_identifier on

	declare @Object sysname
		
	declare @Documentation xml, @Code nvarchar(max), @Message nvarchar(max)
	declare @Tests table([Object] sysname, [Result] bit, [Message] varchar(max))
	
	set @Message = space(0)
	
	insert into @Tests([Object])
	select a.name from sysobjects a
	inner join sys.schemas b on b.schema_id = a.uid and a.xtype in (N'P', N'TF', N'FN')
		and b.name = 'fx' 
	
	declare Test cursor for select [Object] from @Tests
	open Test
	fetch next from Test into @Object
	
	while @@fetch_status = 0
	begin
	
		begin try
	
			-- extract documentation XML from object body stored in syscommnts
			begin try

				;with data([Text]) as (
					select [Text] = (
						select [text] 
						from syscomments 
						where id = object_id('fx.' + @Object)
						for xml path(''), type).value('.', 'varchar(max)'))

				select @Documentation = 
						substring([Text], 
							charindex('<documentation>', [Text], 0) , 
							charindex('</documentation>', [Text], 0) - charindex('<documentation>', [Text], 0) + 16) 
					from data	
			end try
			begin catch
				raiserror('Object''s documentation is absent or not well-formed.', 16, 1)	
			end catch
			
			select top 1
				@Code = [Value]  
			from fx.getXMLElements(@Documentation) a
			where NodeName = 'example'
		
			if @Code is null raiserror('No tests defined', 16, 1)	
			else begin 
				set @Message =  'Test failed: '
				set @Code = replace(@Code, 'from', 'into #[' + cast(newid() as varchar(64)) + '] from' )
				--print @Code
				exec sp_executesql @Code 
				
			end
			
			update @Tests set [Result] = 1, [Message] = 'Test passed' where [Object] = @Object
			
		end try	
		begin catch
			update @Tests set [Result] = 0, [Message] = @Message + error_message() where [Object] = @Object
		end catch
		
		fetch next from Test into @Object
		set @Code = null
		set @Message = space(0)
	end
	
	close Test
	deallocate Test
	
	select * from @Tests order by [Object]
	go