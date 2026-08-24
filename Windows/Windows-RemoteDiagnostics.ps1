[CmdletBinding()]
param([Parameter(Mandatory)][string]$ComputerName)
Invoke-Command -ComputerName $ComputerName -ScriptBlock {
$os=Get-CimInstance Win32_OperatingSystem;$cpu=(Get-CimInstance Win32_Processor|Measure LoadPercentage -Average).Average
[pscustomobject]@{Computer=$env:COMPUTERNAME;OS=$os.Caption;Build=$os.BuildNumber;CPU=[math]::Round($cpu,1);LastBoot=$os.LastBootUpTime;IP=(Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue|Where IPAddress -notlike '169.254*'|Select -Expand IPAddress)-join ', '}
}
