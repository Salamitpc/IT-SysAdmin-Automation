[CmdletBinding()]
param([string[]]$Groups=@('Domain Admins','Enterprise Admins','Administrators','Account Operators'))
Import-Module ActiveDirectory
foreach($group in $Groups){try{Get-ADGroupMember $group -Recursive | Select-Object @{N='Group';E={$group}},Name,SamAccountName,ObjectClass,DistinguishedName}catch{Write-Warning "Unable to query $group"}}
