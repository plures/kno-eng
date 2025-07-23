# Scheduled Optimization Script
param(
  [string]$Schedule = "Weekly",
  [string]$Day = "Sunday",
  [string]$Time = "02:00"
)

$memoryPath = ".cursor/error-memory.json"

# Import functions from auto-memory-manager
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

# Change to project root directory for proper path resolution
Push-Location $projectRoot

# Import the memory manager functions
. "$scriptDir\auto-memory-manager.ps1"

# Check if optimization is needed (run weekly by default)
$memory = Get-Content $memoryPath | ConvertFrom-Json | ConvertTo-Hashtable
$lastOptimization = $memory.metrics.lastOptimization

if ($lastOptimization -and $lastOptimization -ne "") {
  $lastOptDate = [DateTime]::Parse($lastOptimization)
  $daysSinceLastOpt = (Get-Date) - $lastOptDate
    
  if ($daysSinceLastOpt.Days -ge 7) {
    Write-Host "Running scheduled optimization..." -ForegroundColor Yellow
    & "$scriptDir\auto-memory-manager.ps1" -Action "optimize"
        
    # Generate and save report
    $reportPath = ".cursor/optimization-reports/$(Get-Date -Format 'yyyy-MM-dd').txt"
    New-Item -Path (Split-Path $reportPath) -ItemType Directory -Force | Out-Null
    & "$scriptDir\auto-memory-manager.ps1" -Action "report" | Out-File $reportPath
        
    Write-Host "Scheduled optimization completed. Report saved to: $reportPath" -ForegroundColor Green
  } else {
    Write-Host "Optimization not needed yet. Last run: $($lastOptDate.ToString('yyyy-MM-dd'))" -ForegroundColor Cyan
  }
} else {
  Write-Host "No previous optimization found. Running initial optimization..." -ForegroundColor Yellow
  & "$scriptDir\auto-memory-manager.ps1" -Action "optimize"
}

# Restore original location
Pop-Location