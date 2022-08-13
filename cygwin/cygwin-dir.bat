@echo off
REM 请保持本文件为ANSI编码
REM 供cygwin中dcygwin命令作为参数调用使用；
REM 详见 aliaswinapp 中 favorite-dirs 函数；
set "tDir=%1"
for /f "usebackq tokens=*" %%i in (`cygpath -aw %tDir%^|iconv -s -f UTF-8 -t GBK`) do (
   set "wDir=%%i"
)
REM echo %wDir%
pushd "%wDir%"
cygwin.bat
