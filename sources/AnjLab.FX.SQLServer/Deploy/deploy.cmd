@echo off
type ..\about.txt

if [%1]==[] (set server=.) else (set server=%1%)
if [%2]==[] (set database=fx) else (set database=%2%)
if [%3]==[] (set user=sa) else (set user=%3%)
if [%4]==[] (set password=password1) else (set password=%4%)

for /f %%i in ("%0") do set curpath=%%~dpi
cd /d %curpath%


echo  * Building SQL file from sources
copy "..\System\*.sql"+"..\Tables\Eng\*.sql"+"..\Functions\*.sql"+"..\Procedures\*.sql" fx.sql >> out.txt
type fx.sql > fx.sql

echo  * Deplying schema
osql -S %server% -U %user% -P %password% -d %database% -n -i fx.sql 

echo Done

del fx.sql
del out.txt
pause