@echo off

rem elevate if not done already
set PWSH=powershell -c Start-Process -Wait -Verb RunAs -WindowStyle Maximized
net session 1>NUL 2>&1
if "%ERRORLEVEL%"=="0" goto :startup
echo %PWSH% -FilePath "%~f0"
if "%~1"=="" (%PWSH% -FilePath "%~0") else (%PWSH% -FilePath "%~0" -Args '%*')
goto :endoffile

:startup
rem figure out ram allocated
cd /d %~dp0
set RAM=%~1
if not defined RAM set RAM=4096
echo RAM allocated: %RAM%

rem start server
echo on
java -Xmx%RAM%M -Xms%RAM%M -jar minecraft_server.1.19.3.jar
@echo off

rem check for git, maybe update
git --version
if ERRORLEVEL 0 (
	git add *
	git commit -m "last update @ %DATE%"
	git push backup master
)

:endoffile
exit /b %ERRORLEVEL%
