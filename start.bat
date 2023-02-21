@echo off
cd /d C:\Users\Matei\Desktop\Server
set RAM=4096
if defined %~1 set RAM=%~1
java -Xmx%RAM%M -Xms%RAM%M -jar minecraft_server.1.19.3.jar