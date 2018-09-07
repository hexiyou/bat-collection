@Echo Off
REM 脚本名称:一键启动
REM Quick launch Program Batch File 
REM :::::::::::::@Author hexiyou.cn@gmail.com :::::::::::::

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------   


REM 1.检测并启动 frp
set frpPath="H:\vendor\frp_0.13.0_windows_amd64"
if exist "%frpPath%\frpc.exe" (
pushd %frpPath%
tasklist|find "frpc" &&  ( echo.&echo frpc 进程存在，重载进程...& frpc.exe -c frpc.ini --reload ) || ( echo.&echo 未检测到 frpc 进程，启动... &start %~dp0WscriptRun.vbs "frpc.exe -c frpc.ini" )
)

REM 2.检测并启动锐速（需管理员权限）
if exist "H:\etc\serverSpeeder\serverSpeeder_v3.11.12.3_UI3.7.20.0_Win_All\64位\64位通用版\ServerSpeeder\serverSpeeder.bat" (
 REM 检测并等待启动完成
 tasklist |find "AppexAcceleratorUI.exe" ||( pushd "H:\etc\serverSpeeder\serverSpeeder_v3.11.12.3_UI3.7.20.0_Win_All\64位\64位通用版\ServerSpeeder"  & start /WAIT serverSpeeder.bat  )
)

REM 3. 检测并启动 Snipaste
if exist "H:\Extra\Snipaste\Snipaste.x64\Snipaste.exe" (
  tasklist |find "Snipaste.exe" || start "" "H:\Extra\Snipaste\Snipaste.x64\Snipaste.exe"
)


REM 4. 检测并启动 FastStoneCapture
if exist "H:\Extra\FastStoneCapturePortable8.5\FSCapture.exe" (
  tasklist |find "FSCapture.exe" || start "" "H:\Extra\FastStoneCapturePortable8.5\FSCapture.exe"
)



REM 4. 检测并启动 TotalCommander
if exist "H:\Extra\TotalCMD649.0a\Totalcmd64.exe" (
  tasklist |find "Totalcmd64.exe" || start "" "H:\Extra\TotalCMD649.0a\Totalcmd64.exe"
)


REM 5. 检测并启动 shadowsocks
if exist "D:\Extra\ShadowsocksR-4.5.4-win\ShadowsocksR-dotnet4.0.exe" (
  tasklist |find "ShadowsocksR-dotnet" || start "" "D:\Extra\ShadowsocksR-4.5.4-win\ShadowsocksR-dotnet4.0.exe"
)

pause
