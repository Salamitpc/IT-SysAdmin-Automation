[CmdletBinding()]
param()
Connect-MgGraph -Scopes 'User.Read.All','Directory.Read.All'
Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled,AssignedLicenses,SignInActivity | Select DisplayName,UserPrincipalName,AccountEnabled,@{N='LicenseCount';E={$_.AssignedLicenses.Count}},@{N='LastSignIn';E={$_.SignInActivity.LastSignInDateTime}}
