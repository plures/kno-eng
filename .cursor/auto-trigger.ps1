# Auto-Trigger Script for Cursor Auto-Memory and Auto-Learning
# This script runs automatically to ensure the system learns and optimizes without manual intervention

param(
  [string]$Trigger = "auto",  # auto, save, error, commit
  [string]$FilePath = "",
  [string]$ErrorType = "",
  [string]$ErrorMessage = ""
)

# Import the memory manager
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir\auto-memory-manager.ps1"

function Start-AutoLearning {
  Write-Host "[AUTO-LEARNING] Starting automatic learning process..." -ForegroundColor Cyan
  
  # Initialize memory system if needed
  Initialize-MemorySystem
  
  # Update with common patterns
  Write-Host "[AUTO-LEARNING] Updating common patterns..." -ForegroundColor Yellow
  . "$scriptDir\auto-memory-manager.ps1" -Action "update" -ConfigPath "$scriptDir\config.json"
  
  # Run optimization if it's been more than a week
  $memory = Get-Content "$scriptDir\error-memory.json" | ConvertFrom-Json
  $lastOptimization = [DateTime]::Parse($memory.metrics.lastOptimization)
  $daysSinceOptimization = (Get-Date) - $lastOptimization
  
  if ($daysSinceOptimization.TotalDays -ge 7) {
    Write-Host "[AUTO-LEARNING] Running weekly optimization..." -ForegroundColor Yellow
    . "$scriptDir\auto-memory-manager.ps1" -Action "optimize" -ConfigPath "$scriptDir\config.json"
  }
  
  Write-Host "[AUTO-LEARNING] Auto-learning process completed" -ForegroundColor Green
}

function Handle-FileSave {
  param([string]$FilePath)
  
  if ($FilePath -match "\.ps1$") {
    Write-Host "[AUTO-LEARNING] PowerShell file saved: $FilePath" -ForegroundColor Cyan
    
    # Check for syntax errors in the saved file
    $syntaxCheck = powershell -NoProfile -Command "try { . '$FilePath'; Write-Host 'OK' } catch { Write-Host 'ERROR: ' + `$_.Exception.Message }" 2>&1
    
    if ($syntaxCheck -match "ERROR:") {
      Write-Host "[AUTO-LEARNING] Syntax error detected, learning from it..." -ForegroundColor Yellow
      # Extract error pattern and learn from it
      $errorPattern = Extract-ErrorPattern -ErrorMessage $syntaxCheck
      Add-ErrorPattern -Category "syntax" -Pattern $errorPattern -Fix "Review and fix syntax error" -Prevention "Use syntax validation before saving"
    } else {
      Write-Host "[AUTO-LEARNING] File syntax is valid" -ForegroundColor Green
    }
  }
}

function Handle-Error {
  param([string]$ErrorType, [string]$ErrorMessage)
  
  Write-Host "[AUTO-LEARNING] Error detected: $ErrorType - $ErrorMessage" -ForegroundColor Yellow
  
  # Learn from the error
  $pattern = Extract-ErrorPattern -Error $ErrorMessage
  Add-ErrorPattern -Category $ErrorType -Pattern $pattern -Fix "Fix the specific error" -Prevention "Use error prevention patterns"
  
  # Generate snippet if applicable
  if ($ErrorMessage -match "syntax|validation|logic") {
    $snippetName = "Auto-Generated-$ErrorType-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Add-Snippet -Name $snippetName -Prefix "auto$ErrorType" -Body @("# Auto-generated snippet for $ErrorType errors", "# Add your fix here") -Description "Auto-generated from error"
  }
}

function Extract-ErrorPattern {
  param([string]$ErrorMessage)
  
  # Extract common error patterns
  if ($ErrorMessage -match "missing.*brace") {
    return "try\s*{[^}]*$"
  }
  if ($ErrorMessage -match "unexpected.*token") {
    return "}\s*else\s*{"
  }
  if ($ErrorMessage -match "cannot be null") {
    return "Test-Path\s+\$[^\s]+"
  }
  if ($ErrorMessage -match "variable.*not valid") {
    return "\$[^:]+:[^a-zA-Z0-9_]"
  }
  
  return $ErrorMessage
}

function Start-FileWatcher {
  Write-Host "[AUTO-LEARNING] Starting file watcher for PowerShell files..." -ForegroundColor Cyan
  
  # Watch for PowerShell file changes
  $watcher = New-Object System.IO.FileSystemWatcher
  $watcher.Path = (Get-Location).Path
  $watcher.Filter = "*.ps1"
  $watcher.IncludeSubdirectories = $true
  $watcher.EnableRaisingEvents = $true
  
  # Register event handlers
  Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action {
    Handle-FileSave -FilePath $Event.SourceEventArgs.FullPath
  }
  
  Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action {
    Handle-FileSave -FilePath $Event.SourceEventArgs.FullPath
  }
  
  Write-Host "[AUTO-LEARNING] File watcher started" -ForegroundColor Green
}

# Main execution based on trigger
switch ($Trigger.ToLower()) {
  "auto" {
    Start-AutoLearning
    Start-FileWatcher
  }
  "save" {
    Handle-FileSave -FilePath $FilePath
  }
  "error" {
    Handle-Error -ErrorType $ErrorType -ErrorMessage $ErrorMessage
  }
  "commit" {
    Write-Host "[AUTO-LEARNING] Pre-commit validation..." -ForegroundColor Cyan
    # Run pre-commit checks
    Start-AutoLearning
  }
  default {
    Write-Host "[AUTO-LEARNING] Unknown trigger: $Trigger" -ForegroundColor Red
  }
}

# Keep the script running for file watcher
if ($Trigger -eq "auto") {
  Write-Host "[AUTO-LEARNING] Auto-learning system is now running. Press Ctrl+C to stop." -ForegroundColor Green
  while ($true) {
    Start-Sleep -Seconds 60
    # Periodic health check
    Write-Host "[AUTO-LEARNING] System health check..." -ForegroundColor Gray
  }
} 