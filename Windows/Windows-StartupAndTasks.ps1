[CmdletBinding()]
param([string]$Account)
$tasks=Get-ScheduledTask -ErrorAction SilentlyContinue | ForEach-Object { $i=Get-ScheduledTaskInfo $_.TaskName -TaskPath $_.TaskPath -ErrorAction SilentlyContinue; [pscustomobject]@{Task=$_.TaskPath+$_.TaskName;State=$_.State;LastRun=$i.LastRunTime;NextRun=$i.NextRunTime;Author=$_.Author;User=$_.Principal.UserId} }
if($Account){$tasks|Where-Object User -like "*$Account*"}else{$tasks|Sort LastRun -Descending}
