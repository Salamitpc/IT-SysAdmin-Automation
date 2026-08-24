[CmdletBinding()]
param([int]$InactiveDays=90,[int]$PasswordExpiryDays=14)
Import-Module ActiveDirectory
$cut=(Get-Date).AddDays(-$InactiveDays)
$users=Get-ADUser -Filter * -Properties LastLogonDate,Enabled,PasswordNeverExpires,PasswordExpired,msDS-UserPasswordExpiryTimeComputed,WhenCreated
$users|Select-Object SamAccountName,Name,Enabled,LastLogonDate,WhenCreated,PasswordNeverExpires,PasswordExpired,@{N='PasswordExpires';E={if($_.'msDS-UserPasswordExpiryTimeComputed'){[datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed')}}},@{N='Inactive';E={$_.LastLogonDate -lt $cut -or !$_.LastLogonDate}}
