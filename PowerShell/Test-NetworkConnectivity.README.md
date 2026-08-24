# Test-NetworkConnectivity.ps1

## Purpose
Tests ICMP reachability and TCP connectivity to a selected port.

## Usage
```powershell
.\Test-NetworkConnectivity.ps1
.\Test-NetworkConnectivity.ps1 -ComputerName "server01","server02" -Port 443
```

## Safety
Read-only network diagnostics. Use only against systems you are authorized to test.
