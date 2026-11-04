#Requires -Version 5.1
# Veyon Bypass - runs as a normal user, no admin needed
param(
    [ValidateSet('off','watch','on','status')]
    [string]$Mode = 'status'
)

$pidFile = Join-Path $env:TEMP 'veyon-bypass.pid'
$names   = @('veyon-service','veyon-core','veyon-service-ui')

function Kill-Veyon {
    foreach ($n in $names) {
        Stop-Process -Name $n -Force -ErrorAction SilentlyContinue
    }
}

switch ($Mode) {
    'off' {
        # One-shot: kills Veyon now. (If the service auto-restarts, it comes back - use "watch" to keep it off.)
        Kill-Veyon
        Write-Host "Killed Veyon processes. Screen view is off."
    }
    'watch' {
        # Watchdog: keeps killing Veyon forever. This is the "disable completely" mode.
        if (Test-Path $pidFile) {
            $old = Get-Content $pidFile -ErrorAction SilentlyContinue
            if ($old) { Stop-Process -Id $old -Force -ErrorAction SilentlyContinue }
        }
        $PID | Out-File -FilePath $pidFile -Encoding ascii
        Write-Host "Veyon Bypass watchdog is running (PID $PID) - killing Veyon every 1.5s."
        while ($true) {
            Kill-Veyon
            Start-Sleep -Milliseconds 1500
        }
    }
    'on' {
        # Stops the watchdog -> Veyon service restarts by itself (or at next logon).
        if (Test-Path $pidFile) {
            $old = Get-Content $pidFile -ErrorAction SilentlyContinue
            if ($old) { Stop-Process -Id $old -Force -ErrorAction SilentlyContinue }
            Remove-Item $pidFile -ErrorAction SilentlyContinue
            Write-Host "Watchdog stopped. Veyon will restart on its own (or at next logon if it does not)."
        } else {
            Write-Host "No watchdog is running - Veyon is already fully under your control."
        }
    }
    'status' {
        $p = Get-Process -Name $names -ErrorAction SilentlyContinue
        if ($p) { $p | Format-Table Name, Id } else { Write-Host "No Veyon processes running." }
        if (Test-Path $pidFile) { Write-Host "Watchdog: RUNNING (PID $(Get-Content $pidFile))." }
        else { Write-Host "Watchdog: not running." }
    }
}