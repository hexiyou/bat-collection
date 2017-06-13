@echo off&setlocal ENABLEDELAYEDEXPANSION
set file=clipboard_files.txt
set out=formatfiles.txt

for /f "usebackq tokens=2 delims=	" %%a IN ("%file%") Do (
 REM echo %%a
 set oneline=%%a
   for /f "usebackq tokens=1,2 delims=:" %%f IN ('!oneline!') Do (
 echo %%f:%%g
)
)>>%out%

pause