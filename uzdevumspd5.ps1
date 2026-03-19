# Requires the Microsoft.WinGet.Client PowerShell module (available in the PowerShell Gallery)
# To install the module, run: Install-Module -Name Microsoft.WinGet.Client -Force -Scope CurrentUser

# Check if the module is installed, if not, install it.
if (-not (Get-Module -ListAvailable -Name Microsoft.WinGet.Client)) {
    Write-Host "Installing Microsoft.WinGet.Client module..."
    Install-Module -Name Microsoft.WinGet.Client -Force -Scope CurrentUser
    Import-Module Microsoft.WinGet.Client
} else {
    Import-Module Microsoft.WinGet.Client
}

Write-Host "Checking for available updates using the WinGet module..." -ForegroundColor Cyan

# Get all packages with updates available
$updates = Get-WinGetPackage | Where-Object { $_.IsUpdateAvailable }

# Output the information about the software that can be updated
if ($updates.Count -gt 0) {
    Write-Host "`nSoftware with updates available:" -ForegroundColor Yellow
    $updates | Format-Table Name, InstalledVersion, AvailableVersion, Source -AutoSize

    # Output the total count
    Write-Host "`nThere are $($updates.Count) programs on the system that need to be updated." -ForegroundColor Green
} else {
    Write-Host "`nNo software updates available." -ForegroundColor Green
}
