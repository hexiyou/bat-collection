@echo off
REM 管理员获取所有权 wrapper 脚本
REM 引号兼容文件路径包含空格的情况
%~dp0sudo.exe -spawn cmd /c %~dp0oneShot.bat "%*"
