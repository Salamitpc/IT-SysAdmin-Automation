[CmdletBinding()]
param([string[]]$Name = @("microsoft.com","github.com","google.com"))

foreach ($n in $Name) {
    try {
        $r = Resolve-DnsName -Name $n -ErrorAction Stop
        [pscustomobject]@{ Name=$n; Status="Success"; Address=($r | Where-Object Type -in A,AAAA | Select-Object -ExpandProperty IPAddress) -join ", " }
    } catch {
        [pscustomobject]@{ Name=$n; Status="Failed"; Address=$null }
    }
}
