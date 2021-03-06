if exists (select * from sysobjects where id = object_id(N'fx.scriptDiagram') and xtype in (N'P'))
	drop procedure fx.scriptDiagram
	
set quoted_identifier on
go
/*
<documentation>
<summary>
	Script SQL Server diagrams 
</summary>

<remarks>
	Helpful Articles
	
	1) Upload / Download to Sql 2005
	http://staceyw.spaces.live.com/blog/cns!F4A38E96E598161E!404.entry
	
	2) MSDN: Using Large-Value Data Types
	http://msdn2.microsoft.com/en-us/library/ms178158.aspx
	
	3) original Script, Save, Export SQL 2000 Database Diagrams
	http://www.thescripts.com/forum/thread81534.html
	
</remarks>

<parameters>
<param name="Schema">Object's schema name</param>
<param name="Object">Name of the diagram</param>
<param name="PrintResult">Flag to determine should resulted script be printed to output</param>
<param name="Result">SQL statement</param>
</parameters>

<example>
	-- NOTE: Scalar-valued Function fx.getBinaryAsString must exist before this script is run
	exec fx.scriptDiagram 'dbo', 'General'
</example>

<author>
	Based on code of
	Craig Dunn
	inspired by usp_ScriptDatabaseDiagrams for Sql Server 2000 by Clay Beatty
</author>
</documentation>
*/

create procedure fx.scriptDiagram
(
	@Schema  sysname = N'dbo',
	@Object  sysname = N'fx',
	@PrintResult bit = 1,
	@Result nvarchar(max) = null output
)
as
begin

	set nocount on

	declare
		@DiagramID		int,
		@Index			int,
		@Size			int,
		@Chunk			int,
		@TextToPrint nvarchar(max)

	set @Result = space(0)
	-- set start Index, and Chunk 'constant' value
	set @Index = 1  -- 
	set @Chunk = 32	-- values that work: 2, 6
					-- values that fail: 15,16, 64

	-- Get PK DiagramID using the diagram's Name (which is what the user is familiar with)
	select 
		@DiagramID = diagram_id,	
		@Size = datalength([definition]) 
	from sysdiagrams 
	where [Name] = @Object

	if @DiagramID is null
	begin
		raiserror('Specified diagram is not found.', 16, 1)
		return -1
	end
	else -- Diagram exists
	begin
		-- Now with the DiagramID, do all the work
		set @Result = @Result + N'set nocount on' + nchar(13)
		set @Result = @Result + N'set quoted_identifier on' + nchar(13) + nchar(13)
		set @Result = @Result + N'/*' + nchar(13)
		set @Result = @Result + N'<documentation>' + nchar(13)
		set @Result = @Result + N'<summary>'   + nchar(13) + nchar(9) + N'Creating diagram ''' + @Object + '''' + nchar(13) + N'</summary>' + nchar(13)
		set @Result = @Result + N'<remarks>'   + nchar(13) + nchar(9) + N'Will attempt to create [sysdiagrams] table if it doesn''t already exist' + nchar(13) + N'</remarks>' + nchar(13)
		set @Result = @Result + N'<generated>' + nchar(13) + nchar(9) + left(convert(varchar(23), getDate(), 121), 16) + nchar(13) + '</generated>' + nchar(13)
		set @Result = @Result + N'</documentation>' + nchar(13)
		set @Result = @Result + N'*/' + nchar(13) + nchar(13)
		set @Result = @Result + N'if not exists (select * from sys.tables where name = ''sysdiagrams'')' + nchar(13)
		set @Result = @Result + N'begin' + nchar(13)
		set @Result = @Result + N'	-- creates the first time you add a diagram to a 2005/2008 database' + nchar(13)
		set @Result = @Result + N'		create table[dbo].[sysdiagrams](' + nchar(13)
		set @Result = @Result + N'			[Name] [sysName] not null,' + nchar(13)
		set @Result = @Result + N'			[principal_id] [int] not null,' + nchar(13)
		set @Result = @Result + N'			[diagram_id] [int] identity(1,1) not null,' + nchar(13)
		set @Result = @Result + N'			[version] [int] null,' + nchar(13)
		set @Result = @Result + N'			[definition] [varbinary](max) null,' + nchar(13)
		set @Result = @Result + N'			primary key clustered([diagram_id] asc)with (pad_Index  = off, ignore_dup_key = off)  ,' + nchar(13)
		set @Result = @Result + N'			constraint [UK_principal_Name] unique nonclustered ([principal_id] asc, [Name] asc)' + nchar(13)
		set @Result = @Result + N'		) ' + nchar(13)
		set @Result = @Result + N'		exec sys.sp_addextendedproperty @name = N''microsoft_database_tools_support'', @value = 1 , @level0type = N''SCHEMA'',@level0Name = N''dbo'', @level1type = N''TABLE'',@level1Name = N''sysdiagrams''' + nchar(13)
		set @Result = @Result + N'end' + nchar(13)
		set @Result = @Result + N'-- Target table will now exist, if it didn''t before' + nchar(13)
		set @Result = @Result + N'set nocount on' + nchar(13)
		set @Result = @Result + N'declare @newid int' + nchar(13)
		set @Result = @Result + nchar(13) + N'/*' + nchar(13)
		set @Result = @Result + N'Output the insert that _creates_ the diagram record, with a non-null [definition],' + nchar(13)
		set @Result = @Result + N'important because .WRITE *cannot* be called against a null value (in the WHILE loop)' + nchar(13)
		set @Result = @Result + N'so we insert 0x so that .WRITE has something to append to...' + nchar(13)
		set @Result = @Result + N'*/' + nchar(13)
		set @Result = @Result + nchar(13)
		set @Result = @Result + N'begin try' + nchar(13)

		select top 1 @Result = @Result + N'insert into sysdiagrams ([Name], [principal_id], [version], [definition]) values (''' + 
			[Name] + N''', ' + cast (principal_id as nvarchar(100)) + N', ' + cast([version] as nvarchar(100)) + ', 0x)' + char(13) + char(10)
		from sysdiagrams where diagram_id = @DiagramID

		set @Result = @Result + N'		set @newid = scope_identity()' + nchar(13)
		set @Result = @Result + N'end try' + nchar(13)
		set @Result = @Result + N'begin catch' + nchar(13)
		set @Result = @Result + N'	print N''Error occured: ''  + error_Message()' + nchar(13)
		set @Result = @Result + N'	return' + nchar(13)
		set @Result = @Result + N'end catch' + nchar(13)
		set @Result = @Result + N'begin try' + nchar(13)

		while @Index < @Size
		begin
			-- Output as many UPDATE statements as required to append all the diagram binary
			-- data, represented as hexadecimal strings
			select @Result = @Result + 
				 N'	update sysdiagrams set [definition] .Write ('
				+ N' 0x' + upper(fx.getBinaryAsString (substring ([definition], @Index, @Chunk)))
				+ N', null, 0) where diagram_id = @newid -- Index:' + cast(@Index as nvarchar(100))
				+ nchar(13)
			from	sysdiagrams 
			where	diagram_id = @DiagramID

			set @Index = @Index + @Chunk
		end
		set @Result = @Result + N'end try' + nchar(13)
		set @Result = @Result + N'begin catch' + nchar(13)
		set @Result = @Result + N'	-- if we got here, the [definition] updates didn''t complete, so delete the diagram row' + nchar(13)
		set @Result = @Result + N'	-- (and hope it doesn''t fail!)' + nchar(13)
		set @Result = @Result + N'	delete from sysdiagrams where diagram_id = @newid' + nchar(13)
		set @Result = @Result + N'	print N''Error occured: '' + Error_Message() + '' ''' + nchar(13)
		set @Result = @Result + N'	return' + nchar(13)
		set @Result = @Result + N'end catch' + nchar(13)
		set @Result = @Result + nchar(13)
		set @Result = @Result + N'go' + nchar(13)
		set @Result = @Result + nchar(13)
	end

	if @PrintResult = 1 exec fx.printString @Result
	
	return 0
end

go
