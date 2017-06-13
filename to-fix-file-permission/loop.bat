@echo off&setlocal ENABLEDELAYEDEXPANSION
for /f %%i in (%~dp0clear_files.txt) do (
  call %~dp0Run.bat %%i
)

pause