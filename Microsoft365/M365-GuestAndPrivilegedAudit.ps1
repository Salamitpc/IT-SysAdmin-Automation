[CmdletBinding()]
param()
Connect-MgGraph -Scopes 'Directory.Read.All','RoleManagement.Read.Directory','User.Read.All'
Write-Output '=== Guest Users ==='
Get-MgUser -Filter "userType eq 'Guest'" -All -Property DisplayName,UserPrincipalName,AccountEnabled,CreatedDateTime | Select DisplayName,UserPrincipalName,AccountEnabled,CreatedDateTime
Write-Output '=== Directory Role Members ==='
Get-MgDirectoryRole -All | ForEach-Object {$r=$_.DisplayName; Get-MgDirectoryRoleMember -DirectoryRoleId $_.Id -All | Select @{N='Role';E={$r}},Id}
