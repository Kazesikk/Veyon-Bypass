@echo off
title Veyon Bypass - status
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0veyon-bypass.ps1" -Mode status
echo.
pause