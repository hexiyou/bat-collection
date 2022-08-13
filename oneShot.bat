@echo off
REM 管理员获取所有权 truly 脚本
REM Note1：双引号兼容路径包含空格的情况
REM Note2：执行本脚本需从外部传入路径参数，并以管理员权限运行
set "lastletter=%*"
set "oldpath=%*"
dir /ad "%lastletter%" >nul 2>nul&&(set "lastletter=%lastletter%\"&echo.&echo   递归处理文件夹：)||(echo.&echo 处理文件：)
::暂存原始路径
set "target=%lastletter%"
::::::::::::::::::::::::::::::
set lastletter=%lastletter:~-1%
echo 	Target：=^> %target%

::::::::::::::Do Commands::::::::::::::::::::
::@echo on
if "%lastletter%"=="\" takeown /F "%target%*" /R /D Y
REM 下面这行，文件名带空格无法正确处理，文件夹带空格不影响效果，待寻找解决方案
if not "%lastletter%"=="\" takeown /F "%target%"
:::::::::::::::::::::::::::: 删除所有的拒绝权限的用户 begin
icacls "%oldpath%" /remove:d Everyone /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d Everyone /T
:::::::::::::::::::::::::::: 删除所有的拒绝权限的用户 end
if "%lastletter%"=="\" icacls "%target%*" /remove:d "NULL SID" /T
icacls "%target%" /remove:d "CREATOR OWNER" /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d "CREATOR OWNER" /T
icacls "%target%" /remove:d "CREATOR GROUP" /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d "CREATOR GROUP" /T
icacls "%target%" /remove:d "Administrator" /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d "Administrator" /T
icacls "%target%" /remove:d 未知账户 /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d 未知账户 /T
icacls "%target%" /remove:d SYSTEM /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d SYSTEM /T
icacls "%target%" /remove:d Users /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d Users /T
icacls "%target%" /remove:d Administrators /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d Administrators /T
icacls "%target%" /remove:d None /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d None /T
icacls "%target%" /remove:d "Authenticated Users" /T
if "%lastletter%"=="\" icacls "%target%*" /remove:d "Authenticated Users" /T
:::::::::::::::::::::::: 当前管理员用户处理 Begin
REM icacls "%oldpath%" /grant:r Administrator:f /T
REM if "%lastletter%"=="\" icacls "%target%*" /grant:r Administrator:f /T
REM 授予当前登录用户完全控制权限，用于适配管理员用户名不是 Administrator 的情况
REM 参数为文件夹时，最后一个字符不能为反斜杠，否则会报错,不带反斜杠，顺便处理文件夹本身
icacls "%oldpath%" /grant:r %username%:f /T
REM 处理文件夹下边的子文件，不包括根文件夹本身
if "%lastletter%"=="\" icacls "%target%*" /grant:r %username%:f /T
:::::::::::::::::::::::: 当前管理员用户处理 end
:::::::::::::::::::::::: 授予普通用户读取和访问权限 begin
icacls "%oldpath%" /grant:r Users:rxm /T
if "%lastletter%"=="\" icacls "%target%*" /grant:r Users:rxm /T
REM 下边使用高级权限替换，可能有系统兼容性问题，未经严格测试
icacls "%oldpath%" /grant:r Users:(DE,RC,RD,WD,AD,X,RA,REA) /T
:::::::::::::::::::::::: 授予普通用户读取和访问权限 end
echo\&pause
