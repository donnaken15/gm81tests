@echo off
cls
tcc -shared console.c
IF ERRORLEVEL 1 PAUSE
