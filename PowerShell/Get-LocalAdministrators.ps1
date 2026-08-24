[CmdletBinding()]
param()

try {
    Get-LocalGroupMember -Group "Administrators" |
        Select-Object Name, ObjectClass, PrincipalSource
} catch {
    Write-Error "Unable to read local Administrators group: $($_.Exception.Message)"
}
