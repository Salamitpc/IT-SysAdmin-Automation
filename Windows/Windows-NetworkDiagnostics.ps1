[CmdletBinding()]
param([string[]]$Targets=@('dc01','microsoft.com'),[int[]]$Ports=@(53,443))
foreach($target in $Targets){$ping=Test-Connection $target -Count 2 -Quiet -ErrorAction SilentlyContinue; foreach($port in $Ports){$tcp=Test-NetConnection $target -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue; [pscustomobject]@{Target=$target;Ping=$ping;Port=$port;TcpReachable=$tcp}}}
