# Auto-Memory and Auto-Learning Startup Script
# This script automatically starts the auto-learning system when the project is opened

Write-Host "Starting Auto-Memory and Auto-Learning System..." -ForegroundColor Cyan

# Get the script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Start the auto-trigger system in the background
$autoTriggerJob = Start-Job -ScriptBlock {
  param($ScriptDir)
  Set-Location $ScriptDir
  . "$ScriptDir\auto-trigger.ps1" -Trigger "auto"
} -ArgumentList $scriptDir

Write-Host "Auto-learning system started in background (Job ID: $($autoTriggerJob.Id))" -ForegroundColor Green

# Initialize the memory system
Write-Host "Initializing memory system..." -ForegroundColor Yellow
. "$scriptDir\auto-memory-manager.ps1" -Action "update"

Write-Host "Auto-Memory and Auto-Learning System is now active!" -ForegroundColor Green
Write-Host "The system will automatically:" -ForegroundColor Cyan
Write-Host "  - Learn from errors and fixes" -ForegroundColor White
Write-Host "  - Generate snippets and patterns" -ForegroundColor White
Write-Host "  - Optimize memory weekly" -ForegroundColor White
Write-Host "  - Provide IntelliSense suggestions" -ForegroundColor White
Write-Host "  - Prevent common mistakes" -ForegroundColor White

# Store the job ID for later reference
$jobInfo = @{
  JobId      = $autoTriggerJob.Id
  StartTime  = Get-Date
  ScriptPath = $scriptDir
}
$jobInfo | ConvertTo-Json | Set-Content "$scriptDir\auto-learning-job.json"

Write-Host "Job information saved to: $scriptDir\auto-learning-job.json" -ForegroundColor Gray 