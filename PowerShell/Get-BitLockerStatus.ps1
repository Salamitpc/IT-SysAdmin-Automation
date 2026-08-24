[CmdletBinding()]
param()

if (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue) {
    Get-BitLockerVolume |
        Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage, EncryptionMethod
} else {
    Write-Error "BitLocker PowerShell cmdlets are not available on this system."
}
