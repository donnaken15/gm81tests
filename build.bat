@echo off
cls
tcc -shared console\console.c -o..\console.dll
tcc -shared rich_pres\rich_pres.c -o..\rich_pres.dll -Lrich_pres -ldiscord_rpc
IF ERRORLEVEL 1 PAUSE
