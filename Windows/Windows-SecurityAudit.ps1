[CmdletBinding()]
param()
$fw=Get-NetFirewallProfile | Select Name,Enabled
$admins=Get-LocalGroupMember Administrators -ErrorAction SilentlyContinue | Select Name,ObjectClass
$bitlocker=if(Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue){Get-BitLockerVolume|Select MountPoint,VolumeStatus,ProtectionStatus,EncryptionPercentage}
$defender=Get-MpComputerStatus -ErrorAction SilentlyContinue | Select AntivirusEnabled,RealTimeProtectionEnabled,AntivirusSignatureLastUpdated
[pscustomobject]@{Computer=$env:COMPUTERNAME;FirewallEnabled=(($fw|Where Enabled -eq $false).Name -join ', ');LocalAdmins=($admins.Name -join '; ');BitLocker=($bitlocker|ConvertTo-Json -Compress);Defender=($defender|ConvertTo-Json -Compress)}
