# Find-LockedOutAccounts.ps1

## Purpose
Finds Active Directory account lockouts and reports the **CallerComputerName** recorded in domain controller Security Event ID **4740**. This is usually the most useful first clue for determining which workstation or server is generating repeated bad-password attempts.

## Requirements
- ActiveDirectory PowerShell module
- Permission to read Security logs on domain controllers
- Domain connectivity

## Examples

Find lockouts from the last 24 hours:

```powershell
.\Find-LockedOutAccounts.ps1
```

Investigate one account over the last 8 hours:

```powershell
.\Find-LockedOutAccounts.ps1 -Identity jsmith -Hours 8
```

Also attempt DNS resolution of the caller:

```powershell
.\Find-LockedOutAccounts.ps1 -Identity jsmith -Hours 24 -ResolveCallerName
```

## How it works
1. Discovers all domain controllers.
2. Queries each DC's Security log for Event ID 4740.
3. Reads `TargetUserName` and `CallerComputerName` from the event.
4. Reports the domain controller that recorded the event.
5. Optionally attempts DNS resolution of the caller computer.

## Important limitation
The DC event normally identifies the **source computer**, not the exact application or process causing the bad password. Once the source machine is known, investigate saved credentials, Windows Credential Manager, mapped drives, services, scheduled tasks, Outlook/mobile profiles, scripts, and other applications using the account. For deeper investigation, correlate the source machine's Security events such as 4625 and relevant application/service logs.

## Operational use
This is intended as a first-response troubleshooting tool for helpdesk and systems administrators dealing with repeated AD account lockouts.
