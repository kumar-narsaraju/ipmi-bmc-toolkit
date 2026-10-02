<#  Quick BMC health report for Windows using the bundled ipmitool.exe
    Run:  powershell -ExecutionPolicy Bypass -File .\bmc-health-check.ps1 -BmcHost 10.0.0.50 -User admin
    Note: Windows build supports remote (lanplus) access only. #>
param([Parameter(Mandatory)][string]$BmcHost, [Parameter(Mandatory)][string]$User)
$exe = Join-Path $PSScriptRoot 'ipmitool.exe'
$sec = Read-Host "BMC password for $User" -AsSecureString
$env:IPMI_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
$report = "bmc-report-$BmcHost-$(Get-Date -Format yyyyMMdd-HHmmss).txt"
try {
  foreach ($c in @('mc info','chassis status','sdr elist','sel elist','fru print')) {
    "`n==== $c ====" | Tee-Object -FilePath $report -Append
    & $exe -I lanplus -H $BmcHost -U $User -E $c.Split(' ') 2>&1 | Tee-Object -FilePath $report -Append
  }
  Write-Host "`nSaved: $report"
} finally { Remove-Item Env:IPMI_PASSWORD -ErrorAction SilentlyContinue }
