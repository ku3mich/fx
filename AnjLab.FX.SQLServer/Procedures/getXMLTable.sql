if exists (select * from sysobjects where id = object_id(N'fx.getXMLTable') and xtype in (N'P'))
	drop procedure fx.getXMLTable

set quoted_identifier on
go

/*
<documentation>

<summary>
	Returns XML data as table
</summary>

<remarks>
	XML attributes are presented as columns
	XML namespaces are not supported
</remarks>

<parameters>
<param name="XMLData">Source XML</param>
</parameters>

<example>
	-- Example 1
		declare @XMLData xml
		set @XMLData = (select * from fx.Countries for xml auto, root)
		exec fx.getXMLTable @XMLData
	
</example>

<author>
	Alex Zakharov
	Copyright (c) AnjLab 2011, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>

</documentation>
*/

create procedure fx.getXMLTable(@XMLData xml) as
begin
	
	set nocount on
	declare @SQL nvarchar(max)
	
	select 
		NodeID,
		ParentNodeId,
		NodeName,
		NodePosition,
		[Value],
		AttributeName,
		AttributeValue
	into #Table
	from fx.getXMLElements(@XMLData) a
	cross apply (
		select 0 as Position, null as AttributeName, null as AttributeValue
		union 
		select * from fx.getXMLAttributes(a.[Query])) b
	

	set @SQL = (
		select N'[' + ltrim(rtrim([AttributeName])) + N'],' as 'data()' 
		from (select distinct AttributeName from #Table) as a
		for xml path('')) 

	if len(@SQL) > 0 
	begin
		set @SQL = N'select * from #Table a pivot (max(AttributeValue) for AttributeName in (' + 
			substring(@SQL, 1, len(@SQL) - 1) + ')) b'
	
		exec sp_executesql @SQL
	
	end else
		select 				
			NodeID,
			ParentNodeId,
			NodeName,
			NodePosition,
			[Value]
		from #Table

	drop table #Table
end

go
