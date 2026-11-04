# Veyon Bypass

Turn Veyon off **without admin privileges**.

Veyon's screen viewer runs as a service, so a normal logged-in student usually can't stop it — you'd need admin rights or the teacher's password. Veyon Bypass runs a tiny watchdog as your normal user that keeps killing the Veyon processes over and over, so the screen view stays off even if the service tries to restart them.

No installation, no admin prompt, no config — just double-click a .bat file.

## The four buttons

| File | What it does |
|---|---|
| `DISABLE veyon.bat` | Starts the watchdog. Veyon is killed every 1.5 s and stays off until you re-enable it. |
| `ENABLE veyon.bat` | Stops the watchdog. Veyon restarts by itself (or at next logon) and works again. |
| `KILL veyon now.bat` | Kills Veyon **once**, no watchdog — for a quick moment of privacy. |
| `STATUS.bat` | Shows which Veyon processes are running and whether the watchdog is alive. |

All four are wrappers around `veyon-bypass.ps1`.

## Usage

1. Copy all the files into a folder (e.g. on your desktop).
2. Double-click **`DISABLE veyon.bat`** — the window flashes and closes. Veyon is now bypassed.
3. When you want Veyon back, double-click **`ENABLE veyon.bat`**.
4. Double-click **`STATUS.bat`** any time to check what's going on.

## How it works

The watchdog loops every **1.5 seconds** and force-kills `veyon-service`, `veyon-core` and `veyon-service-ui`. Even if the service restarts a process instantly, it's killed again within 1.5 s — so the teacher never sees your screen.

The watchdog saves its PID to `%TEMP%\veyon-bypass.pid`. `ENABLE` reads that file and stops exactly that process, then Veyon comes back on its own. Nothing else on the system is touched.

## Requirements

- Windows 10 / 11
- PowerShell 5.1 (built into Windows — nothing to install)
- No administrator rights needed

## Limitations

- While the watchdog runs, you lose Veyon's features (screen view, remote control, messages) — that's the point. The teacher can still see you in the student list.
- If your session is locked or disconnected, the watchdog only sees processes in your own session. In the normal case — logged in and working — it's fine.
