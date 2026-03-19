# 6_apkope.ps1 - Proactive System Maintenance
$logFile = "$HOME\Documents\Maintenance.log"
$drive = Get-PSDrive C
$freePercent = ($drive.Free / $drive.Used) * 100
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Calculate space before cleanup (approximate)
$tempDir = $env:TEMP
$beforeFree = $drive.Free

if ($freePercent -lt 25) {
    # Cleanup actions
    Remove-Item -Path "$tempDir\*" -Recurse -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    
    # Calculate space freed
    $afterFree = $drive.Free
    $freedGB = [Math]::Round(($afterFree - $beforeFree) / 1GB, 2)
    
    # Log cleanup result
    "[$timestamp] Cleanup completed. $freedGB GB freed." | Out-File -FilePath $logFile -Append
} else {
    # Log sufficient space
    "[$timestamp] Space sufficient." | Out-File -FilePath $logFile -Append
}
