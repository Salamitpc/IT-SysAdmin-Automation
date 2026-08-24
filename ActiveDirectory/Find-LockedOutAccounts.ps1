[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$Identity,

    [Parameter(Mandatory=$false)]
    [ValidateRange(1,168)]
    [int]$Hours = 24,

    [Parameter(Mandatory=$false)]
    [switch]$ResolveCallerName
)

<#!
.SYNOPSIS
Finds Active Directory account lockouts and identifies the originating computer recorded by the domain controller.

.DESCRIPTION
Queries every available domain controller for Security Event ID 4740 (A user account was locked out).
The event's CallerComputerName is the key field used to identify the workstation/server that generated the lockout.

This script identifies the source machine recorded by the domain controller. It does not, by itself, identify the
exact process, service, scheduled task, phone, mapped drive, or saved credential causing the bad password.

.REQUIREMENTS
- ActiveDirectory PowerShell module
- Permission to read Security event logs on domain controllers
- Appropriate domain access

.EXAMPLE
.\Find-LockedOutAccounts.ps1

.EXAMPLE
.\Find-LockedOutAccounts.ps1 -Identity jsmith -Hours 8

.EXAMPLE
.\Find-LockedOutAccounts.ps1 -Identity jsmith -Hours 24 -ResolveCallerName
#>

$ErrorActionPreference = 'Stop'

if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    throw 'ActiveDirectory PowerShell module is not installed.'
}
Import-Module ActiveDirectory

$startTime = (Get-Date).AddHours(-$Hours)
$domainControllers = Get-ADDomainController -Filter * | Sort-Object HostName

if (-not $domainControllers) {
    throw 'No domain controllers were found.'
}

$results = foreach ($dc in $domainControllers) {
    try {
        $events = Get-WinEvent -ComputerName $dc.HostName -FilterHashtable @{
            LogName   = 'Security'
            Id        = 4740
            StartTime = $startTime
        } -ErrorAction Stop

        foreach ($event in $events) {
            $xml = [xml]$event.ToXml()
            $data = @{}
            foreach ($node in $xml.Event.EventData.Data) {
                $data[$node.Name] = $node.'#text'
            }

            $targetUser = $data['TargetUserName']
            if ($Identity -and $targetUser -notlike $Identity) {
                continue
            }

            $caller = $data['CallerComputerName']
            $resolved = $null
            if ($ResolveCallerName -and $caller) {
                try {
                    $resolved = [System.Net.Dns]::GetHostEntry($caller).HostName
                } catch {
                    $resolved = 'DNS resolution failed'
                }
            }

            [pscustomobject]@{
                LockoutTime       = $event.TimeCreated
                LockedOutAccount  = $targetUser
                CallerComputer    = $caller
                ResolvedCaller    = $resolved
                DomainController  = $dc.HostName
                TargetDomain      = $data['TargetDomainName']
                EventId            = $event.Id
            }
        }
    }
    catch [Exception] {
        Write-Warning "Could not query $($dc.HostName): $($_.Exception.Message)"
    }
}

if ($results) {
    $results | Sort-Object LockoutTime -Descending | Format-Table -AutoSize
    Write-Host "`nTip: The CallerComputer field is the machine recorded by the DC for the lockout." -ForegroundColor Cyan
    Write-Host 'If the same machine repeatedly appears, investigate saved credentials, mapped drives, services, scheduled tasks, Outlook/mobile profiles, and other applications using the account.' -ForegroundColor Cyan
} else {
    Write-Host "No account lockout events (4740) found in the last $Hours hour(s)." -ForegroundColor Green
}
