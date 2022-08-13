::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJHCH+0wjFDhNSxOLMiWzBbp8
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSTk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErTXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXrZg==
::ZQ05rAF9IAHYFVzEqQITMRxDRQoLxpsy8VqZGCd+BSICW4V9
::eg0/rx1wNQPfEVWB+kM9LVsJDCebO3yzCIou3ca2x+ODpwMYTOdf
::fBEirQZwNQPfEVWB+kM9LVsJDCebO3yzCIou3ca2x+ODpy0=
::cRolqwZ3JBvQF1fEqQITMRxDRQrCOmSoRpEV+u34++WVu8jtm2fVsAoiEvgGxyqWAI3ncRPFBv2hVk3M65OPsZd1im8=
::dhA7uBVwLU+EWN99IMbq2Z6ZiI1P3uNdzDLoIIg=
::YQ03rBFzNR3SWATEcrvkrMGlyclGtaZYOZEV+/yb
::dhAmsQZ3MwfNWATE/EMzIxBRVSSTLSW5Cbh8
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRmn7UUnIRUZZA2GOe5KyTD2IG0CJ4o=
::Zh4grVQjdCyDJHCH+0wjFBhNSxOLMiayD7EZpu3j6oo=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal ENABLEDELAYEDEXPANSION
set "installconf=%~dp0cygwin_installion_path.txt"
for /F  %%i in (%installconf%) do (
   REM echo %%i
   set "installPath=%%~fi" 
   set "installDrive=%%~di"
)
REM set "DirectoryRunWrapper=H:\cygwin64\DirectoryRun.bat"
set "DirectoryRunWrapper=%installDrive%\cygwin64\bin\bash.exe"
set "exeHost=%~f0x"
set "args=%*"
set "myself=%~df0"
REM echo %myself%

if "x%exeHost:~-5%"=="x.exex" (
REM echo 替换路径
set "args=!args:%myself%=!" 
)
REM echo -----!args!------------
REM echo %%-----%args%------------
REM pause
REM exit /b
REM 是否有附加的命令行参数
set "alternativeParams=%args%"
REM 注意传入的参数中如果有管道符|和&符，字符前面需要加^转义，符合bat转义原则
REM eg1：ls -al^|wc-l
REM eg2：ping -c 10 114.114.114.114 ^&^& paths
if exist "%DirectoryRunWrapper%"  (
REM "%DirectoryRunWrapper%" "%CD%" 
"%DirectoryRunWrapper%" --login -i -c "%alternativeParams%;"
) else (
@color 0c
echo.
echo %%DirectoryRunWrapper%% ==^> %DirectoryRunWrapper% 不存在！
REM mshta "javascript:alert('%%DirectoryRunWrapper%% ==^> %DirectoryRunWrapper% 不存在！');window.close()"
mshta "vbscript:msgbox("%%DirectoryRunWrapper%%==^>%DirectoryRunWrapper%不存在！"&vbCrlf&"请确认Cygwin安装路径或检查配置文件%installconf%!",64,"Cygwin安装路径不存在！")&window.close()"
REM mshta "vbscript:msgbox("DirectoryRunWrapper不存在，请确认Cygwin安装路径或检查配置文件！",64,"Cygwin安装路径不存在")&window.close()"
REM pause
timeout /5 /NOBREAK||ping -n 5 127.0.0.1 >nul
)
