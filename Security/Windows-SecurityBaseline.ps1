[CmdletBinding()]
param()
$checks=@(
 [pscustomobject]@{Check='Firewall';Result=((Get-NetFirewallProfile|Where Enabled -eq $false).Name -join ', ')}
 [pscustomobject]@{Check='RDP';Result=(Get-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -ErrorAction SilentlyContinue).fDenyTSConnections}
 [pscustomobject]@{Check='SMBv1';Result=(Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -ErrorAction SilentlyContinue).State}
 [pscustomobject]@{Check='DefenderRealtime';Result=(Get-MpComputerStatus -ErrorAction SilentlyContinue).RealTimeProtectionEnabled}
)
$checks
