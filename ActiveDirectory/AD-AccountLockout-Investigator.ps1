[CmdletBinding()]
param([string]$Identity,[int]$Hours=24,[switch]$ResolveCallerName)
$start=(Get-Date).AddHours(-$Hours)
$dcs=Get-ADDomainController -Filter *
$events=foreach($dc in $dcs){Get-WinEvent -ComputerName $dc.HostName -FilterHashtable @{LogName='Security';Id=4740;StartTime=$start} -ErrorAction SilentlyContinue | ForEach-Object {
 $xml=[xml]$_.ToXml(); $data=@{}; $xml.Event.EventData.Data | ForEach-Object {$data[$_.Name]=$_.InnerText}
 if(!$Identity -or $data.TargetUserName -like $Identity){$caller=$data.CallerComputerName; if($ResolveCallerName -and $caller){try{$caller=[System.Net.Dns]::GetHostEntry($caller).HostName}catch{}}
 [pscustomobject]@{LockedAccount=$data.TargetUserName;LockoutTime=$_.TimeCreated;CallerComputer=$caller;DomainController=$dc.HostName;Domain=$data.TargetDomainName;EventId=$_.Id}}}
$events|Sort-Object LockoutTime -Descending
