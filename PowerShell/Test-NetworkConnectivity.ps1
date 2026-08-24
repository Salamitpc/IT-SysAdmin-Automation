[CmdletBinding()]
param(
    [string[]]$ComputerName = @("1.1.1.1","8.8.8.8"),
    [int]$Port = 443
)

foreach ($target in $ComputerName) {
    $ping = Test-Connection -ComputerName $target -Count 2 -Quiet -ErrorAction SilentlyContinue
    $tcp = Test-NetConnection -ComputerName $target -Port $Port -InformationLevel Quiet -WarningAction SilentlyContinue
    [pscustomobject]@{
        Target = $target
        Ping = $ping
        TCPPort = $Port
        TCPReachable = $tcp
    }
}
