cls

[string] $sqlServer   = "."  # Target SQL Server
[string] $sqlDatabase = "fx" # Target database
[string] $sqlUser     = "sa"
[string] $sqlPassword = "password1"

[string] $curDir      = (Get-Location -PSProvider FileSystem)
[string] $sqlFile     =  $curDir + "\fx.sql"

type ..\about.txt

.\SQLServer.ps1

write-host -foreground green ' * Building SQL file from sources'

$sources = Get-childitem ..\System\*.sql,..\Tables\Eng\*.sql,..\Functions\*.sql,..\Procedures\*.sql 
foreach ($file in $sources) {
	$fullpath = $file.fullname
	$content = Get-content $fullpath
	add-content $sqlFile $content
}

Write-Host -foreground green ' * Deploying schema'
Invoke-sqlcmd -Server $sqlServer -Database $sqlDatabase -User $sqlUser -Password $sqlPassword -InputFile $sqlFile

Write-Host -foreground green 'Done'

remove-item $sqlFile


