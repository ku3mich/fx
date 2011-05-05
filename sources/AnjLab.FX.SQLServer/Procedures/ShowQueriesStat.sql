if exists (select * from sysobjects where id = object_id(N'fx.ShowQueriesStat') and xtype in (N'P'))
drop procedure fx.ShowQueriesStat
go

/*
<summary>
	Shows server-wide performing queries statistic.
<summary>

<remarks>
	This stored procedure displays the top worst performing queries based on CPU, Execution Count,
    I/O and Elapsed_Time as identified using DMV information. This can be display the worst
    performing queries from an instance, or database perspective.   The number of records shown,
    the database, and the sort order are identified by passing pararmeters.
</remarks>

<author>
	Gregory A. Larsen
	Copyright © 2008 Gregory A. Larsen. All rights reserved.
</author>

<param name="Database">
	used to constraint the output to a specific database. If when calling this procedure 
	this parameter is set to a specific database name then only statements that are associated 
	with that database will be displayed. If the parameter is not set then this procedure will 
	return rows associated with any database.
</param>
<param name="Count">
	parameter allows you to control the number of rows returned by this procedure. If this parameter 
	is used then only the TOP x rows, where x is equal to the parameter will be returned, based on 
	the OrderBy parameter.
</param>
<param name="OrderBy">
	parameter identifies the sort order of the rows returned in descending order. This parameter 
	supports the following type: CPU, AE, TE, EC or AIO, TIO, ALR, TLR, ALW, TLW, APR, and TPR, where 
		"ACPU" represents Average CPU Usage
		"TCPU" represents Total CPU usage
		"AE"   represents Average Elapsed Time
		"TE"   represents Total Elapsed Time
		"EC"   represents Execution Count
		"AIO"  represents Average IOs
		"TIO"  represents Total IOs
		"ALR"  represents Average Logical Reads
		"TLR"  represents Total Logical Reads             
		"ALW"  represents Average Logical Writes
		"TLW"  represents Total Logical Writes
		"APR"  represents Average Physical Reads
		"TPR"  represents Total Physical Read
</param>

<example>
	Example 1. Top 6 statements in the master database base on Average CPU Usage
    exec fx.ShowQueriesStat @Database = 'master',@Count = 6,@OrderBy = 'ACPU';
  
	Example 2. Top 100 statements order by Average IO
	exec fx.ShowQueriesStat @Count = 100,@OrderBy = 'ALR';
   
	Example 3. Show top 100 statements by Average CPU
	exec fx.ShowQueriesStat 
</example>

*/

create procedure fx.ShowQueriesStat(
	@Database sysname = null,
	@Count int = 9999,
	@OrderBy nvarchar(4) = 'ACPU')
as
begin

	if @OrderBy not in ('ACPU','TCPU','AE','TE','EC','AIO','TIO','ALR','TLR','ALW','TWL','APR','TPR')
	begin
			raiserror('@OrderBy parameter not in APCU, TCPU, AE, TE, EC, AIO, TIO, ALR, TLR, ALW, TLW, APR or TPR', 16, 1)
			return -1 
	end

	select top (@Count)
         [Database Name]       = coalesce(db_name(st.[dbid]), db_name(cast(pa.value as int)), 'Resource'),
         [Statement]           = substring(
									[text],
									(isnull(statement_start_offset, 0) / 2 + 1),
									(case 
										when isnull(statement_end_offset, 0) in (-1, 0) then len([text])
										else statement_end_offset / 2
									end - (isnull(statement_start_offset, 0) / 2 + 1))),
         [Schema Name]          = object_schema_name(st.objectid, [dbid]),
         [Object Name]          = object_name(st.objectid, [dbid]),
         [Cached Plan objtype]  = [objtype],
         [Execution Count]      = execution_count,
         [Average IOs]          = fx.Div((total_logical_reads + total_logical_writes + total_physical_reads), execution_count),
         [Total IOs]            = total_logical_reads + total_logical_writes + total_physical_reads,
         [Avg Logical Reads]    = fx.Div(total_logical_reads, execution_count),
         [Total Logical Reads]  = total_logical_reads,
         [Avg Logical Writes]   = fx.Div(total_logical_writes, execution_count),
         [Total Logical Writes] = total_logical_writes, 
         [Avg Physical Reads]   = fx.Div(total_physical_reads, execution_count),
         [Total Physical Reads] = total_physical_reads,
         [Avg CPU]              = fx.Div(total_worker_time, execution_count),
         [Total CPU]            = total_worker_time,
         [Avg Elapsed Time]     = fx.Div(total_elapsed_time, execution_count),
         [Total Elasped Time]   = total_elapsed_time, 
         [Last Execution Time]  = last_execution_time  
    from sys.dm_exec_query_stats qs 
    inner join sys.dm_exec_cached_plans cp ON qs.plan_handle = cp.plan_handle
    cross apply sys.dm_exec_sql_text(qs.plan_handle) st
    cross apply sys.dm_exec_plan_attributes(qs.plan_handle) pa
    where pa.attribute = 'dbid' 
		and (@Database = coalesce(db_name(st.[dbid]), db_name(cast(pa.value as int)), 'Resource') 
		or @Database is null)
	order by case @OrderBy
		when 'ACPU' then fx.Div(total_worker_time, execution_count)
		when 'TCPU' then total_worker_time
		when 'AE'   then fx.Div(total_elapsed_time, execution_count)
		when 'TE'   then total_elapsed_time 
		when 'EC'   then execution_count
		when 'AIO'  then fx.Div((total_logical_reads + total_logical_writes + total_physical_reads), execution_count)
		when 'TIO'  then total_logical_reads + total_logical_writes + total_physical_reads
		when 'ALR'  then fx.Div(total_logical_reads, execution_count)
		when 'TLR'  then total_logical_reads
		when 'ALW'  then fx.Div(total_logical_writes, execution_count)
		when 'TLW'  then total_logical_writes 
		when 'APR'  then fx.Div(total_physical_reads, execution_count)
		when 'TPR'  then total_physical_reads
	end desc

 end

 go
 