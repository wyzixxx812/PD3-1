
$defenderStatus = Get-MpComputerStatus

$rtpEnabled = $defenderStatus.RealTimeProtectionEnabled

$quickScanAge = $defenderStatus.QuickScanAge

if ($rtpEnabled -eq $false -or $quickScanAge -gt 3) {
Write-Host ">>> Sistema ir apdraudeta! <<<" -ForegroundColor Red
Write-Host "Sikaka informacija:" -ForegroundColor Red
Write-Host "- RealTimeProtection: $(if($rtpEnabled){"Iespejots"}else{"Atspejots"})" -ForegroundColor Red
Write-Host "- Dienas kops pedejas QuickScan: $quickScanAge" -ForegroundColor Red
}
else {

Write-Host ">>> Sistema ir drosa <<<" -ForegroundColor Green
Write-Host "RealTimeProtection: Iespejots. QuickScanAge: $quickScanAge dienas." -Prieksplana krasa zala
}