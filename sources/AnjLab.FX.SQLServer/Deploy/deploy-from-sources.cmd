@echo off
cls
rem color 1E

type ..\about.txt

if [%1]==[] (set server=.) else (set server=%1%)
if [%2]==[] (set database=fx) else (set database=%2%)
if [%3]==[] (set user=sa) else (set user=%3%)
if [%4]==[] (set password=password1) else (set password=%4%)
if [%5]==[] (set language=Eng) else (set language=%5)

for /f %%i in ("%0") do set curpath=%%~dpi
cd /d %curpath%

echo  * Installing database level objects...                                        
osql -S %server% -U %user% -P %password% -d %database% -n -i ..\System\Schema.sql
osql -S %server% -U %user% -P %password% -d %database% -n -i ..\System\Types.sql
echo  * Installing tables...                                                        
for /f "tokens=*" %%a in ('dir /b ..\tables\%language%\*.sql') do osql -S %server% -U %user% -P %password% -n -d %database% -i ..\tables\%language%\%%a  
echo  * Installing functions...                                                     
for /f "tokens=*" %%a in ('dir /b ..\functions\*.sql') do osql -S %server% -U %user% -P %password% -n -d %database% -i ..\functions\%%a 
echo  * Installing procedures...                                                    
for /f "tokens=*" %%a in ('dir /b ..\procedures\*.sql') do osql -S %server% -U %user% -P %password% -n -d %database% -i ..\procedures\%%a 

echo Done


pause