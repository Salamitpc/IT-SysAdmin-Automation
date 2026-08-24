[CmdletBinding(SupportsShouldProcess)]
param([int]$OlderThanDays = 7)

$cutoff = (Get-Date).AddDays(-$OlderThanDays)
$paths = @($env:TEMP, "$env:WINDIR\Temp")

foreach ($path in $paths) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path -Force -File -Recurse -ErrorAction SilentlyContinue |
            Where-Object LastWriteTime -lt $cutoff |
            ForEach-Object {
                if ($PSCmdlet.ShouldProcess($_.FullName, "Delete temporary file")) {
                    Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
                }
            }
    }
}
