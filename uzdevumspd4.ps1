# --- Configuration ---
$sourceFile = "C:\Users\A250632AK\Documents\Errors.txt"  # Update with actual path from Task 3
$backupDir = "C:\Users\A250632AK\Documents\BackupFolder"      # Folder to store the zip
$date = Get-Date -Format "yyyy-MM-dd"
$zipFileName = "Report_$date.zip"
$destinationZip = Join-Path -Path $backupDir -ChildPath $zipFileName

# --- Main Script ---
# Create backup directory if it doesn't exist
if (!(Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir
}

# Create the archive
if (Test-Path -Path $sourceFile) {
    # If file exists, compress it. -Force overwrites if run twice in one day
    Compress-Archive -Path $sourceFile -DestinationPath $destinationZip -Force
    Write-Host "Archive created: $destinationZip" -ForegroundColor Green
    
    # Read and output the size in KB
    $fileInfo = Get-Item -Path $destinationZip
    $sizeKB = $fileInfo.Length / 1KB
    Write-Host ("Archive size: {0:N2} KB" -f $sizeKB) -ForegroundColor Cyan
} else {
    Write-Warning "Source file $sourceFile not found."
}
