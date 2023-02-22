@echo off

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
