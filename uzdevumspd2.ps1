$daysBack = 7
$logName = "System"
$outputFile = "$HOME\Documents\Errors.txt"
$startTime = (Get-Date).AddDays(-$daysBack)


# Kļudu limeņa notikumu meklešana (2. limenis)
$events = Get-WinEvent -FilterHashtable @{
LogName = $logName
Level = 2
StartTime = $startTime
} -ErrorAction SilentlyContinue


$report = @()
$report += "Sistemas kļudu ziņojums par pedejam $daysBack dienām"
$report += "Izveidošanas datums: $(Get-Date)"
$report += "-------------------------------------------------------"

if ($events.Count -gt 10) {
$report += "[KRITISKI] Sistema ir nestabila! (Atrastas kļudas: $($events.Count))"
} else {
$report += "[OK] Kļudu limenis ir normals. (Atrastas kļudas: $($events.Count))"
}

$report += "------------------------------------------------------"
$report += ""

if ($events) {
foreach ($event in $events) {
$report += "Laiks: $($event.TimeCreated)"
$report += "Ziņojums: $($event.Message)"
$report += "-------------------------------------------------------"
}
} else {
$report += "Nav atrastas kļudas."
}


$report | Out-File -FilePath $outputFile -Encoding utf8
Write-Host "Ziņojums saglabats: $outputFile" -ForegroundColor Green