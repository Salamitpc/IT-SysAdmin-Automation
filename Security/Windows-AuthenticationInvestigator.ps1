[CmdletBinding()]
param([int]$Hours=24,[string]$User)
$start=(Get-Date).AddHours(-$Hours)
Get-WinEvent -FilterHashtable @{LogName='Security';Id=4625;StartTime=$start} -ErrorAction SilentlyContinue | ForEach-Object {$x=[xml]$_.ToXml();$d=@{};$x.Event.EventData.Data|ForEach-Object{$d[$_.Name]=$_.InnerText};if(!$User -or $d.TargetUserName -like $User){[pscustomobject]@{Time=$_.TimeCreated;User=$d.TargetUserName;Domain=$d.TargetDomainName;Workstation=$d.WorkstationName;IpAddress=$d.IpAddress;LogonType=$d.LogonType;Status=$d.Status;SubStatus=$d.SubStatus}}}
