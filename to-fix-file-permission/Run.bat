@echo off

set lastletter=%1
set lastletter=%lastletter:~-1%
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
icacls %1 /remove:d "Authenticated Users" /T
if "%lastletter%"=="\" icacls %1* /remove:d "Authenticated Users" /T
