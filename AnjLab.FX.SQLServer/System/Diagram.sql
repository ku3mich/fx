set nocount on
set quoted_identifier on
 
/*
<documentation>
<summary>
	Creating diagram 'fx'
</summary>
<remarks>
	Will attempt to create [sysdiagrams] table if it doesn't already exist
</remarks>
<generated>
	2011-06-29 19:08
</generated>
</documentation>
*/
 
if not exists (select * from sys.tables where name = 'sysdiagrams')
begin
	-- creates the first time you add a diagram to a 2005/2008 database
		create table[dbo].[sysdiagrams](
			[Name] [sysName] not null,
			[principal_id] [int] not null,
			[diagram_id] [int] identity(1,1) not null,
			[version] [int] null,
			[definition] [varbinary](max) null,
			primary key clustered([diagram_id] asc)with (pad_Index  = off, ignore_dup_key = off)  ,
			constraint [UK_principal_Name] unique nonclustered ([principal_id] asc, [Name] asc)
		) 
		exec sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value = 1 , @level0type = N'SCHEMA',@level0Name = N'dbo', @level1type = N'TABLE',@level1Name = N'sysdiagrams'
end
-- Target table will now exist, if it didn't before
set nocount on
declare @newid int
 
/*
Output the insert that _creates_ the diagram record, with a non-null [definition],
important because .WRITE *cannot* be called against a null value (in the WHILE loop)
so we insert 0x so that .WRITE has something to append to...
*/
 
begin try
insert into sysdiagrams ([Name], [principal_id], [version], [definition]) values ('fx', 1, 1, 0x)

		set @newid = scope_identity()
end try
begin catch
	print N'Error occured: '  + error_Message()
	return
end catch
begin try
	update sysdiagrams set [definition] .Write ( 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900, null, 0) where diagram_id = @newid -- Index:1
	update sysdiagrams set [definition] .Write ( 0x0600000000000000000000000100000001000000000000000010000002000000, null, 0) where diagram_id = @newid -- Index:33
	update sysdiagrams set [definition] .Write ( 0x01000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:65
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:97
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:129
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:161
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:193
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:225
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:257
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:289
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:321
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:353
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:385
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:417
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:449
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:481
	update sysdiagrams set [definition] .Write ( 0xFDFFFFFF06000000FEFFFFFF040000000500000007000000FEFFFFFF08000000, null, 0) where diagram_id = @newid -- Index:513
	update sysdiagrams set [definition] .Write ( 0x09000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:545
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:577
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:609
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:641
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:673
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:705
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:737
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:769
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:801
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:833
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:865
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:897
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:929
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:961
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:993
	update sysdiagrams set [definition] .Write ( 0x52006F006F007400200045006E00740072007900000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1025
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1057
	update sysdiagrams set [definition] .Write ( 0x16000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1089
	update sysdiagrams set [definition] .Write ( 0x00000000000000000000000070FCBE4B6B36CC0103000000800A000000000000, null, 0) where diagram_id = @newid -- Index:1121
	update sysdiagrams set [definition] .Write ( 0x6600000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1153
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1185
	update sysdiagrams set [definition] .Write ( 0x04000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1217
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000002601000000000000, null, 0) where diagram_id = @newid -- Index:1249
	update sysdiagrams set [definition] .Write ( 0x6F00000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1281
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1313
	update sysdiagrams set [definition] .Write ( 0x040002010100000004000000FFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1345
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000050000000803000000000000, null, 0) where diagram_id = @newid -- Index:1377
	update sysdiagrams set [definition] .Write ( 0x010043006F006D0070004F0062006A0000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1409
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1441
	update sysdiagrams set [definition] .Write ( 0x12000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:1473
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000120000005F00000000000000, null, 0) where diagram_id = @newid -- Index:1505
	update sysdiagrams set [definition] .Write ( 0x01000000020000000300000004000000FEFFFFFF060000000700000008000000, null, 0) where diagram_id = @newid -- Index:1537
	update sysdiagrams set [definition] .Write ( 0x090000000A0000000B0000000C0000000D0000000E0000000F00000010000000, null, 0) where diagram_id = @newid -- Index:1569
	update sysdiagrams set [definition] .Write ( 0x11000000FEFFFFFF13000000FEFFFFFF15000000160000001700000018000000, null, 0) where diagram_id = @newid -- Index:1601
	update sysdiagrams set [definition] .Write ( 0x190000001A0000001B0000001C0000001D0000001E000000FEFFFFFFFEFFFFFF, null, 0) where diagram_id = @newid -- Index:1633
	update sysdiagrams set [definition] .Write ( 0x2100000022000000230000002400000025000000260000002700000028000000, null, 0) where diagram_id = @newid -- Index:1665
	update sysdiagrams set [definition] .Write ( 0xFEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1697
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1729
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1761
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1793
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1825
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1857
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1889
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1921
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1953
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:1985
	update sysdiagrams set [definition] .Write ( 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, null, 0) where diagram_id = @newid -- Index:2017
	update sysdiagrams set [definition] .Write ( 0x000428000A0E100C05000080020000000F00FFFF02000000007D000053600000, null, 0) where diagram_id = @newid -- Index:2049
	update sysdiagrams set [definition] .Write ( 0xAA3F0000C16F00005F4F0000DE805B10F195D011B0A000AA00BDCB5C00000800, null, 0) where diagram_id = @newid -- Index:2081
	update sysdiagrams set [definition] .Write ( 0x30000000000200000200000038002B00000009000000D9E6B0E91C81D011AD51, null, 0) where diagram_id = @newid -- Index:2113
	update sysdiagrams set [definition] .Write ( 0x00A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98, null, 0) where diagram_id = @newid -- Index:2145
	update sysdiagrams set [definition] .Write ( 0x273C25A2DA2D00002C0043200000000000000000000051444DD2011FD1118E63, null, 0) where diagram_id = @newid -- Index:2177
	update sysdiagrams set [definition] .Write ( 0x006097D2DF4834C9D2777977D811907000065B840D9C02000000680000000082, null, 0) where diagram_id = @newid -- Index:2209
	update sysdiagrams set [definition] .Write ( 0x010000003800A50900000700008001000000A2020000008000000E0000805363, null, 0) where diagram_id = @newid -- Index:2241
	update sysdiagrams set [definition] .Write ( 0x68477269648958020000CA080000436F756E7472696573202866782900000000, null, 0) where diagram_id = @newid -- Index:2273
	update sysdiagrams set [definition] .Write ( 0x2400A501000007000080020000006600000001800000436F6E74726F6C894F03, null, 0) where diagram_id = @newid -- Index:2305
	update sysdiagrams set [definition] .Write ( 0x0000110200000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:2337
	update sysdiagrams set [definition] .Write ( 0x214334120800000096240000A216000078563412070000001401000043006F00, null, 0) where diagram_id = @newid -- Index:2369
	update sysdiagrams set [definition] .Write ( 0x75006E0074007200690065007300200028006600780029000000720073006900, null, 0) where diagram_id = @newid -- Index:2401
	update sysdiagrams set [definition] .Write ( 0x6F006E003D0032002E0030002E0033003500300030002E0030002C0020004300, null, 0) where diagram_id = @newid -- Index:2433
	update sysdiagrams set [definition] .Write ( 0x75006C0074007500720065003D006E00650075007400720061006C002C002000, null, 0) where diagram_id = @newid -- Index:2465
	update sysdiagrams set [definition] .Write ( 0x5000750062006C00690063004B006500790054006F006B0065006E003D006200, null, 0) where diagram_id = @newid -- Index:2497
	update sysdiagrams set [definition] .Write ( 0x3700370061003500630035003600310039003300340065003000380039000000, null, 0) where diagram_id = @newid -- Index:2529
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:2561
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:2593
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000500000054000000, null, 0) where diagram_id = @newid -- Index:2625
	update sysdiagrams set [definition] .Write ( 0x2C0000002C0000002C00000034000000000000000000000096240000A2160000, null, 0) where diagram_id = @newid -- Index:2657
	update sysdiagrams set [definition] .Write ( 0x000000002D010000080000000C000000070000001C010000BC07000054060000, null, 0) where diagram_id = @newid -- Index:2689
	update sysdiagrams set [definition] .Write ( 0xD0020000840300007602000038040000460500002A03000046050000AE060000, null, 0) where diagram_id = @newid -- Index:2721
	update sysdiagrams set [definition] .Write ( 0x9204000000000000010000001515000066120000000000000600000006000000, null, 0) where diagram_id = @newid -- Index:2753
	update sysdiagrams set [definition] .Write ( 0x02000000020000001C010000AB0900000000000001000000C7110000FF050000, null, 0) where diagram_id = @newid -- Index:2785
	update sysdiagrams set [definition] .Write ( 0x00000000010000000100000002000000020000001C010000BC07000001000000, null, 0) where diagram_id = @newid -- Index:2817
	update sysdiagrams set [definition] .Write ( 0x00000000C7110000ED0300000000000000000000000000000200000002000000, null, 0) where diagram_id = @newid -- Index:2849
	update sysdiagrams set [definition] .Write ( 0x1C010000BC0700000000000000000000072C0000DE2000000000000000000000, null, 0) where diagram_id = @newid -- Index:2881
	update sysdiagrams set [definition] .Write ( 0x0D00000004000000040000001C010000BC07000024090000A005000078563412, null, 0) where diagram_id = @newid -- Index:2913
	update sysdiagrams set [definition] .Write ( 0x040000005A00000001000000010000000B000000000000000100000002000000, null, 0) where diagram_id = @newid -- Index:2945
	update sysdiagrams set [definition] .Write ( 0x030000000400000005000000060000000700000008000000090000000A000000, null, 0) where diagram_id = @newid -- Index:2977
	update sysdiagrams set [definition] .Write ( 0x030000006600780000000A00000043006F0075006E0074007200690065007300, null, 0) where diagram_id = @newid -- Index:3009
	update sysdiagrams set [definition] .Write ( 0x00000002000030220000CA030000020064000000FFFFFF000000000000000000, null, 0) where diagram_id = @newid -- Index:3041
	update sysdiagrams set [definition] .Write ( 0x3A0001000004BC023C6702000756657264616E61190041006E006A004C006100, null, 0) where diagram_id = @newid -- Index:3073
	update sysdiagrams set [definition] .Write ( 0x62002E004600580020006500780061006D0070006C0065002000640069006100, null, 0) where diagram_id = @newid -- Index:3105
	update sysdiagrams set [definition] .Write ( 0x6700720061006D00000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3137
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3169
	update sysdiagrams set [definition] .Write ( 0x0100FEFF030A0000FFFFFFFF0000000000000000000000000000000017000000, null, 0) where diagram_id = @newid -- Index:3201
	update sysdiagrams set [definition] .Write ( 0x4D6963726F736F66742044445320466F726D20322E300010000000456D626564, null, 0) where diagram_id = @newid -- Index:3233
	update sysdiagrams set [definition] .Write ( 0x646564204F626A6563740000000000F439B27100000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3265
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3297
	update sysdiagrams set [definition] .Write ( 0x0C00000000000000000000000100260000007300630068005F006C0061006200, null, 0) where diagram_id = @newid -- Index:3329
	update sysdiagrams set [definition] .Write ( 0x65006C0073005F00760069007300690062006C0065000000010000000B00FFFF, null, 0) where diagram_id = @newid -- Index:3361
	update sysdiagrams set [definition] .Write ( 0x1E00000000000000000000000000000000000000640000000000000000000000, null, 0) where diagram_id = @newid -- Index:3393
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000010000000100000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3425
	update sysdiagrams set [definition] .Write ( 0x000000000000D002000006002800000041006300740069007600650054006100, null, 0) where diagram_id = @newid -- Index:3457
	update sysdiagrams set [definition] .Write ( 0x62006C00650056006900650077004D006F006400650000000100000008000400, null, 0) where diagram_id = @newid -- Index:3489
	update sysdiagrams set [definition] .Write ( 0x000030000000200000005400610062006C00650056006900650077004D006F00, null, 0) where diagram_id = @newid -- Index:3521
	update sysdiagrams set [definition] .Write ( 0x640065003A00300000000100000008003A00000034002C0030002C0032003800, null, 0) where diagram_id = @newid -- Index:3553
	update sysdiagrams set [definition] .Write ( 0x0300440064007300530074007200650061006D00000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3585
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3617
	update sysdiagrams set [definition] .Write ( 0x160002000300000006000000FFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3649
	update sysdiagrams set [definition] .Write ( 0x000000000000000000000000000000000000000014000000A902000000000000, null, 0) where diagram_id = @newid -- Index:3681
	update sysdiagrams set [definition] .Write ( 0x53006300680065006D0061002000550044005600200044006500660061007500, null, 0) where diagram_id = @newid -- Index:3713
	update sysdiagrams set [definition] .Write ( 0x6C00740000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3745
	update sysdiagrams set [definition] .Write ( 0x26000200FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3777
	update sysdiagrams set [definition] .Write ( 0x00000000000000000000000000000000000000001F0000001600000000000000, null, 0) where diagram_id = @newid -- Index:3809
	update sysdiagrams set [definition] .Write ( 0x440053005200450046002D0053004300480045004D0041002D0043004F004E00, null, 0) where diagram_id = @newid -- Index:3841
	update sysdiagrams set [definition] .Write ( 0x540045004E005400530000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3873
	update sysdiagrams set [definition] .Write ( 0x2C0002010500000007000000FFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:3905
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000200000003602000000000000, null, 0) where diagram_id = @newid -- Index:3937
	update sysdiagrams set [definition] .Write ( 0x53006300680065006D0061002000550044005600200044006500660061007500, null, 0) where diagram_id = @newid -- Index:3969
	update sysdiagrams set [definition] .Write ( 0x6C007400200050006F0073007400200056003600000000000000000000000000, null, 0) where diagram_id = @newid -- Index:4001
	update sysdiagrams set [definition] .Write ( 0x36000200FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:4033
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000290000001200000000000000, null, 0) where diagram_id = @newid -- Index:4065
	update sysdiagrams set [definition] .Write ( 0x34002C0030002C0031003900380030002C0031002C0031003600320030002C00, null, 0) where diagram_id = @newid -- Index:4097
	update sysdiagrams set [definition] .Write ( 0x35002C0031003000380030000000200000005400610062006C00650056006900, null, 0) where diagram_id = @newid -- Index:4129
	update sysdiagrams set [definition] .Write ( 0x650077004D006F00640065003A00310000000100000008001E00000032002C00, null, 0) where diagram_id = @newid -- Index:4161
	update sysdiagrams set [definition] .Write ( 0x30002C003200380034002C0030002C0032003400370035000000200000005400, null, 0) where diagram_id = @newid -- Index:4193
	update sysdiagrams set [definition] .Write ( 0x610062006C00650056006900650077004D006F00640065003A00320000000100, null, 0) where diagram_id = @newid -- Index:4225
	update sysdiagrams set [definition] .Write ( 0x000008001E00000032002C0030002C003200380034002C0030002C0031003900, null, 0) where diagram_id = @newid -- Index:4257
	update sysdiagrams set [definition] .Write ( 0x380030000000200000005400610062006C00650056006900650077004D006F00, null, 0) where diagram_id = @newid -- Index:4289
	update sysdiagrams set [definition] .Write ( 0x640065003A00330000000100000008001E00000032002C0030002C0032003800, null, 0) where diagram_id = @newid -- Index:4321
	update sysdiagrams set [definition] .Write ( 0x34002C0030002C0031003900380030000000200000005400610062006C006500, null, 0) where diagram_id = @newid -- Index:4353
	update sysdiagrams set [definition] .Write ( 0x56006900650077004D006F00640065003A00340000000100000008003E000000, null, 0) where diagram_id = @newid -- Index:4385
	update sysdiagrams set [definition] .Write ( 0x34002C0030002C003200380034002C0030002C0031003900380030002C003100, null, 0) where diagram_id = @newid -- Index:4417
	update sysdiagrams set [definition] .Write ( 0x32002C0032003300340030002C00310031002C00310034003400300000000200, null, 0) where diagram_id = @newid -- Index:4449
	update sysdiagrams set [definition] .Write ( 0x000002000000000000000800000001CD061510CD06150000000000000000E40F, null, 0) where diagram_id = @newid -- Index:4481
	update sysdiagrams set [definition] .Write ( 0x0000010000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:4513
	update sysdiagrams set [definition] .Write ( 0x010003000000000000000C0000000B0000004E61BC0000000000000000000000, null, 0) where diagram_id = @newid -- Index:4545
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:4577
	update sysdiagrams set [definition] .Write ( 0xDBE6B0E91C81D011AD5100A0C90F573900000200A000BD4B6B36CC0100020000, null, 0) where diagram_id = @newid -- Index:4609
	update sysdiagrams set [definition] .Write ( 0x1048450000000000000000000000000000000000620100004400610074006100, null, 0) where diagram_id = @newid -- Index:4641
	update sysdiagrams set [definition] .Write ( 0x200053006F0075007200630065003D002E003B0049006E006900740069006100, null, 0) where diagram_id = @newid -- Index:4673
	update sysdiagrams set [definition] .Write ( 0x6C00200043006100740061006C006F0067003D00660078003B00500065007200, null, 0) where diagram_id = @newid -- Index:4705
	update sysdiagrams set [definition] .Write ( 0x7300690073007400200053006500630075007200690074007900200049006E00, null, 0) where diagram_id = @newid -- Index:4737
	update sysdiagrams set [definition] .Write ( 0x66006F003D0054007200750065003B0055007300650072002000490044003D00, null, 0) where diagram_id = @newid -- Index:4769
	update sysdiagrams set [definition] .Write ( 0x730061003B004D0075006C007400690070006C00650041006300740069007600, null, 0) where diagram_id = @newid -- Index:4801
	update sysdiagrams set [definition] .Write ( 0x650052006500730075006C00740053006500740073003D00460061006C007300, null, 0) where diagram_id = @newid -- Index:4833
	update sysdiagrams set [definition] .Write ( 0x65003B005000610063006B00650074002000530069007A0065003D0034003000, null, 0) where diagram_id = @newid -- Index:4865
	update sysdiagrams set [definition] .Write ( 0x390036003B004100700070006C00690063006100740069006F006E0020004E00, null, 0) where diagram_id = @newid -- Index:4897
	update sysdiagrams set [definition] .Write ( 0x61006D0065003D0022004D006900630072006F0073006F006600740020005300, null, 0) where diagram_id = @newid -- Index:4929
	update sysdiagrams set [definition] .Write ( 0x51004C00200053006500720076006500720020004D0061006E00610067006500, null, 0) where diagram_id = @newid -- Index:4961
	update sysdiagrams set [definition] .Write ( 0x6D0065006E0074002000530074007500640069006F0022000000008005000600, null, 0) where diagram_id = @newid -- Index:4993
	update sysdiagrams set [definition] .Write ( 0x0000660078000000000224001400000043006F0075006E007400720069006500, null, 0) where diagram_id = @newid -- Index:5025
	update sysdiagrams set [definition] .Write ( 0x730000000600000066007800000001000000D68509B3BB6BF2459AB8371664F0, null, 0) where diagram_id = @newid -- Index:5057
	update sysdiagrams set [definition] .Write ( 0x327008004E0000007B00310036003300340043004400440037002D0030003800, null, 0) where diagram_id = @newid -- Index:5089
	update sysdiagrams set [definition] .Write ( 0x380038002D0034003200450033002D0039004600410032002D00420036004400, null, 0) where diagram_id = @newid -- Index:5121
	update sysdiagrams set [definition] .Write ( 0x3300320035003600330042003900310044007D00000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5153
	update sysdiagrams set [definition] .Write ( 0x010003000000000000000C0000000B0000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5185
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5217
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5249
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5281
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5313
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5345
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5377
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5409
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5441
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5473
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5505
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5537
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5569
	update sysdiagrams set [definition] .Write ( 0x0000000000000000000000000000000000000000000000000000000000000000, null, 0) where diagram_id = @newid -- Index:5601
	update sysdiagrams set [definition] .Write ( 0x62885214, null, 0) where diagram_id = @newid -- Index:5633
end try
begin catch
	-- if we got here, the [definition] updates didn't complete, so delete the diagram row
	-- (and hope it doesn't fail!)
	delete from sysdiagrams where diagram_id = @newid
	print N'Error occured: ' + Error_Message() + ' '
	return
end catch
 
go
 
 
