@echo off&setlocal enabledelayedexpansion
set targetfile=clink_dll_x64.dll
if not "x%~f1"=="x" set "targetfile=%~f1"
set /a findSid=0
for /f "usebackq  tokens=*" %%i in (`icacls "%targetfile%" /Q^|findstr "(DENY) (N)"`) do (
set "permsid=%%i"

REM set "permsid=!permsid:%targetfile% =!"
set "permsid=!permsid:%targetfile% =!"
for /f "usebackq tokens=1,2,* delims=:" %%a in ('!permsid!') do (
set "sid=%%a"
echo.&echo  对 !sid! 去除拒绝权限...
icacls "%targetfile%" /remove:d "!sid!" /Q>nul
if !ERRORLEVEL!==0 ( echo  ^>^>success ) else ( echo.&echo  remove from %targetfile% failure^! )
)
set /a "findSid=!findSid!+1"
icacls "%targetfile%" /grant:r Users:RX /Q>nul
)
if %findSid%==0 ( echo.&echo 没有被拒绝的SID ) else ( echo.&echo  共计去除 %findSid% 用户的拒绝权限^! )
if "x%~f1"=="x" ( echo.&echo 测试完毕，任意键退出&pause>nul ) else ( exit /b !ERRORLEVEL! )
