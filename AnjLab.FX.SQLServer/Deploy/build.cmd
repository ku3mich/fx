@echo off

for /f %%i in ("%0") do set curpath=%%~dpi
cd /d %curpath%

copy /A "..\System\Schema.sql"+"..\System\Types.sql"+"..\System\Diagram.sql"+"..\Tables\Eng\*.sql"+"..\Functions\*.sql"+"..\Procedures\*.sql" fx.sql >> out.txt
del out.txt

