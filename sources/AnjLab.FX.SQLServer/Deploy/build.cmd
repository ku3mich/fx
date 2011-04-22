@echo off
cls
color 1E

for /f %%i in ("%0") do set curpath=%%~dpi
cd /d %curpath%

copy /A "..\System\*.sql"+"..\Tables\Eng\*.sql"+"..\Functions\*.sql"+"..\Procedures\*.sql" fx.sql >> out.txt
del out.txt

