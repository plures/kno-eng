# Auto-Learning Integration for Cursor
param(
  [string]$ErrorType,
  [string]$ErrorMessage,
  [string]$FixedCode,
  [string]$Context = ""
)

# Import functions from auto-memory-manager
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

# Change to project root directory for proper path resolution
Push-Location $projectRoot

# Import the memory manager functions
. "$scriptDir\auto-memory-manager.ps1"

$memoryPath = ".cursor/error-memory.json"
$snippetsPath = ".cursor/snippets/powershell.json"

function Learn-FromError {
  param(
    [string]$ErrorType,
    [string]$ErrorMessage,
    [string]$FixedCode,
    [string]$Context
  )
    
  # Extract pattern from error
  $pattern = Extract-PatternFromError -ErrorType $ErrorType -ErrorMessage $ErrorMessage
    
  # Generate fix and prevention
  $fix = Generate-Fix -FixedCode $FixedCode -Context $Context
  $prevention = Generate-Prevention -ErrorType $ErrorType -Pattern $pattern
    
  # Add to memory
  Add-ErrorPattern -Category $ErrorType -Pattern $pattern -Fix $fix -Prevention $prevention
    
  # Generate snippet if applicable
  if ($FixedCode -match "function|try|catch") {
    $snippetName = "Auto-Generated-$ErrorType-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    $snippetBody = ConvertTo-Snippet -Code $FixedCode
    Add-Snippet -Name $snippetName -Prefix "auto$ErrorType" -Body $snippetBody -Description "Auto-generated from error fix"
  }
    
  Write-Host "Learned from error: $ErrorType" -ForegroundColor Green
  Write-Host "Pattern: $pattern" -ForegroundColor Cyan
  Write-Host "Fix: $fix" -ForegroundColor Yellow
}

function Extract-PatternFromError {
  param([string]$ErrorType, [string]$ErrorMessage)
    
  switch ($ErrorType.ToLower()) {
    "syntax" {
      if ($ErrorMessage -match "missing.*brace") {
        return "try\s*{[^}]*$"
      }
      if ($ErrorMessage -match "unexpected.*token") {
        return "}\s*else\s*{"
      }
    }
    "validation" {
      if ($ErrorMessage -match "cannot be null") {
        return "Test-Path\s+\$[^\s]+"
      }
    }
    default {
      return $ErrorMessage
    }
  }
}

function Generate-Fix {
  param([string]$FixedCode, [string]$Context)
    
  # Analyze the fixed code and generate a generic fix description
  if ($FixedCode -match "try.*catch") {
    return "Wrap operation in try-catch block with proper error handling"
  }
  if ($FixedCode -match "if.*null.*Test-Path") {
    return "Add null/empty validation before using Test-Path"
  }
    
  return "Review and fix the specific error pattern"
}

function Generate-Prevention {
  param([string]$ErrorType, [string]$Pattern)
    
  switch ($ErrorType.ToLower()) {
    "syntax" {
      return "Use code snippets and templates to ensure proper structure"
    }
    "validation" {
      return "Always validate inputs before using them in operations"
    }
    default {
      return "Review code before execution and use established patterns"
    }
  }
}

function ConvertTo-Snippet {
  param([string]$Code)
    
  # Convert code to snippet body array
  $lines = $Code -split "`n" | ForEach-Object { $_.Trim() }
    
  # Replace common patterns with snippet placeholders
  $snippetBody = @()
  foreach ($line in $lines) {
    if ($line -match "function\s+(\w+)") {
      $snippetBody += "function `$1 {"
    } elseif ($line -match "try\s*{") {
      $snippetBody += "try {"
      $snippetBody += "    `$1"
    } elseif ($line -match "catch\s*{") {
      $snippetBody += "} catch {"
      $snippetBody += "    Write-Error `"`$2: `$(`$_.Exception.Message)`""
    } elseif ($line -match "if\s*\(.*null.*\)") {
      $snippetBody += "if (`$null -eq `$Path -or [string]::IsNullOrWhiteSpace(`$Path)) {"
      $snippetBody += "    throw `"Path is null or empty`""
    } else {
      $snippetBody += $line
    }
  }
    
  return $snippetBody
}

# Execute learning
if ($ErrorType -and $ErrorMessage) {
  Learn-FromError -ErrorType $ErrorType -ErrorMessage $ErrorMessage -FixedCode $FixedCode -Context $Context
} else {
  Write-Host "Usage: .\auto-learn.ps1 -ErrorType 'syntax' -ErrorMessage 'Missing closing brace' -FixedCode 'try { ... } catch { ... }'" -ForegroundColor Yellow
}

# Restore original location
Pop-Location