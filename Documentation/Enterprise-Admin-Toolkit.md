# Enterprise Admin Toolkit

This repository now includes Windows, Active Directory, Microsoft 365/Entra ID, Intune, and security investigation tools.

## AD investigation
- `AD-AccountLockout-Investigator.ps1`: searches DC Security logs for event 4740 and reports caller computer.
- `AD-User-Audit.ps1`: reviews enabled state, last logon, creation/change dates, and password flags.
- `AD-Computer-Audit.ps1`: identifies stale computer accounts.
- `AD-PrivilegedGroup-Audit.ps1`: audits privileged group membership.
- `AD-RecentlyChangedAccounts.ps1`: reports recently created or changed users.

## Root-cause workflow for lockouts
1. Find event 4740 and CallerComputer.
2. On the caller machine inspect Security event 4625.
3. Check scheduled tasks and services running as the affected account.
4. Check mapped drives, applications, credential stores, mobile clients, and other systems using the account.
5. Do not assume the caller computer is the definitive root cause; 4740 identifies the caller recorded by the DC, not necessarily the exact process.

## Microsoft 365 / Entra ID
Scripts use Microsoft Graph and require appropriate delegated permissions. Review consent requirements before production use.

## Intune
Scripts use Microsoft Graph device-management APIs. They are reporting/audit focused and do not modify devices.

## Security
Run only against systems and tenants you are authorized to administer. Never store passwords, tokens, certificates, or other secrets in the repository.
