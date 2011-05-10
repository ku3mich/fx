if exists (select * from sysobjects where id = object_id(N'fx.GetXMLTable') and xtype in (N'P'))
drop procedure fx.GetXMLTable
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
	Example 1
		declare @XMLData xml
		set @XMLData = (select * from fx.Countries for xml auto, root)
		exec fx.GetXMLTable @XMLData
	
	Example 2: Parse XHTML	
		declare @XMLData xml
		set @XMLData = '
			<html>
				<head><title>Page title</title></head>
				<body bgcolor = "silver">
					<h1 id = "1">This is test page</h1>
					<hr id = "2"/>
					<div id = "3">
						<p id = "4" name = "first p">This is <b>first </b><u>paragraph</u></p>
						<p id = "5" name = "second p">This is second paragraph.
							<br/>
							<table id = "6" name = "my table" width="300px" border = "1">
								<tr><td align = "center" colspan = "2">This is wide cell</td></tr>
								<tr><td>cell 1.1</td><td>cell 1.2</td></tr>
								<tr><td>cell 2.1</td><td>cell 2.2</td></tr>
							</table>
						</p>
						<ul id = "7">
							<li>For more information visit <a href = "http://anjlab.com" target = "_new">our website</a></li>
							<li>Or AnjLab.FX <a href = "https://github.com/anjlab/fx">repository on GitHub</a></li>
						</ul>
					</div>
				</body>
			</html>'
		exec fx.GetXMLTable @XMLData
</example>

<author>
	Alex Zakharov
	Copyright © AnjLab 2011, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
</author>

</documentation>
*/

create procedure fx.GetXMLTable(@XMLData xml) as
begin
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
	from fx.GetXMLElements(@XMLData) a
	cross apply (
		select 0 as Position, null as AttributeName, null as AttributeValue
		union 
		select * from fx.GetXMLAttributes(a.[Query])) b
	

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
