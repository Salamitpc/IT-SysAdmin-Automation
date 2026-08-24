# Script Documentation Guide

Each script is intended to be readable and reusable by a SysAdmin.

## Recommended workflow
1. Review the script before production use.
2. Test it against a lab computer.
3. Run `Get-Help .\Script.ps1 -Full` where comment-based help is available.
4. Use `-WhatIf` on scripts that support it.
5. Export results when auditing multiple systems.
6. Never hard-code credentials, tokens, or passwords.

## Portfolio value
These examples demonstrate Windows administration, PowerShell, troubleshooting, auditing, reporting, and safe automation practices.
