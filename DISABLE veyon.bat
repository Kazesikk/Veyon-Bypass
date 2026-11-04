@echo off
title Veyon Bypass - disabling
echo Starting Veyon Bypass watchdog (keeps Veyon fully disabled, no admin needed)...
start "" powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0veyon-bypass.ps1" -Mode watch
timeout /t 2 >nul