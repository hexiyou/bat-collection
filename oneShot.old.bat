@echo off
REM 管理员获取所有权 truly 脚本
REM 本脚本不匹配带空格的路径或者路径是文件夹需递归处理的情况，已经弃用
set "lastletter=%*"
REM set lastletter=%lastletter:~-1%
if "%lastletter%"=="\" takeown /F %1 /R /D Y
if not "%lastletter%"=="\" takeown /F %1
if "%lastletter%"=="\" icacls %1* /remove:d "NULL SID" /T
icacls %1 /remove:d "CREATOR OWNER" /T
if "%lastletter%"=="\" icacls %1* /remove:d "CREATOR OWNER" /T
icacls %1 /remove:d "CREATOR GROUP" /T
if "%lastletter%"=="\" icacls %1* /remove:d "CREATOR GROUP" /T
icacls %1 /remove:d "Administrator" /T
if "%lastletter%"=="\" icacls %1* /remove:d "Administrator" /T
icacls %1 /remove:d 未知账户 /T
if "%lastletter%"=="\" icacls %1* /remove:d 未知账户 /T
icacls %1 /remove:d SYSTEM /T
if "%lastletter%"=="\" icacls %1* /remove:d SYSTEM /T
icacls %1 /remove:d Users /T
if "%lastletter%"=="\" icacls %1* /remove:d Users /T
icacls %1 /remove:d Administrators /T
if "%lastletter%"=="\" icacls %1* /remove:d Administrators /T
icacls %1 /remove:d None /T
if "%lastletter%"=="\" icacls %1* /remove:d None /T
icacls %1 /remove:d "Authenticated Users" /T
if "%lastletter%"=="\" icacls %1* /remove:d "Authenticated Users" /T
icacls %1 /grant:r Administrator:f /T
if "%lastletter%"=="\" icacls %1* /grant:r Administrator:f /T
echo\&pause
