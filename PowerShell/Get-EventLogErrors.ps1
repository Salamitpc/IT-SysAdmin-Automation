[CmdletBinding()]
param(
    [int]$Hours = 24,
    [int]$MaxEvents = 100
)

$start = (Get-Date).AddHours(-$Hours)
Get-WinEvent -FilterHashtable @{LogName="System"; Level=2; StartTime=$start} -MaxEvents $MaxEvents |
    Select-Object TimeCreated, Id, ProviderName, LevelDisplayName, Message
