@echo off
title Veyon Bypass - one-shot kill
echo Killing Veyon now (screen view off until it restarts)...
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0veyon-bypass.ps1" -Mode off
timeout /t 2 >nul