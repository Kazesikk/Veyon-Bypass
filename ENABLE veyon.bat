@echo off
title Veyon Bypass - re-enabling
echo Stopping Veyon Bypass watchdog (Veyon will start working again)...
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0veyon-bypass.ps1" -Mode on
echo.
pause