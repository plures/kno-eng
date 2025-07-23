# Auto Memory Manager for Cursor - Self-Learning Error Prevention System
param(
  [string]$Action = "analyze",  # analyze, update, optimize, report
  [string]$ConfigPath = ".cursor/config.json",
  [string]$MemoryPath = ".cursor/error-memory.json",
  [string]$SnippetsPath = ".cursor/snippets/powershell.json"
)

# --- FIX: Always resolve $MemoryPath relative to workspace root ---
$workspaceRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $workspaceRoot ".cursor"))) {
    $workspaceRoot = Get-Location
}
$MemoryPath = Join-Path $workspaceRoot ".cursor/error-memory.json"
$ConfigPath = Join-Path $workspaceRoot ".cursor/config.json"
$SnippetsPath = Join-Path $workspaceRoot ".cursor/snippets/powershell.json"
# --- END FIX ---

# Initialize memory structure
$script:MemoryStructure = @{
  errorPatterns = @{
    powershell = @{
      syntax      = @{}
      validation  = @{}
      logic       = @{}
      performance = @{}
    }
  }
  snippets      = @{}
  rules         = @{
    prevention   = @{}
    enforcement  = @{}
    optimization = @{}
  }
  metrics       = @{
    errorsPrevented  = 0
    patternsLearned  = 0
    effectiveness    = 0.0
    lastOptimization = $null
  }
}

function Initialize-MemorySystem {
  if (-not (Test-Path $MemoryPath)) {
    $script:MemoryStructure | ConvertTo-Json -Depth 10 | Set-Content $MemoryPath
    Write-Host "Created new memory file: $MemoryPath" -ForegroundColor Green
  }
    
  if (-not (Test-Path $SnippetsPath)) {
    New-Item -Path (Split-Path $SnippetsPath) -ItemType Directory -Force | Out-Null
    @{} | ConvertTo-Json | Set-Content $SnippetsPath
    Write-Host "Created new snippets file: $SnippetsPath" -ForegroundColor Green
  }
}

function ConvertTo-Hashtable {
  param([Parameter(ValueFromPipeline)]$InputObject)
  
  if ($null -eq $InputObject) { return @{} }
  
  if ($InputObject -is [System.Collections.IDictionary]) {
    $result = @{}
    foreach ($key in $InputObject.Keys) {
      $result[$key] = ConvertTo-Hashtable -InputObject $InputObject[$key]
    }
    return $result
  }
  
  if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
    $result = @()
    foreach ($item in $InputObject) {
      $result += ConvertTo-Hashtable -InputObject $item
    }
    return $result
  }
  
  if ($InputObject -is [PSCustomObject]) {
    $result = @{}
    foreach ($prop in $InputObject.PSObject.Properties) {
      # Handle null values by converting them to empty strings or appropriate defaults
      $value = $prop.Value
      if ($null -eq $value) {
        # Use appropriate defaults based on property name
        switch ($prop.Name) {
          "patternsLearned" { $value = 0 }
          "errorsPrevented" { $value = 0 }
          "effectiveness" { $value = 0.0 }
          "lastOptimization" { $value = "" }
          default { $value = "" }
        }
      }
      $result[$prop.Name] = ConvertTo-Hashtable -InputObject $value
    }
    return $result
  }
  
  return $InputObject
}

function Add-ErrorPattern {
  param(
    [string]$Category,
    [string]$Pattern,
    [string]$Fix,
    [string]$Prevention,
    [int]$OccurrenceCount = 1,
    [string]$LastSeen = (Get-Date -Format "o")
  )
    
  $memory = Get-Content $MemoryPath | ConvertFrom-Json | ConvertTo-Hashtable
    
  # Ensure nested structure exists
  if (-not $memory.errorPatterns) { $memory.errorPatterns = @{} }
  if (-not $memory.errorPatterns.powershell) { $memory.errorPatterns.powershell = @{} }
  if (-not $memory.errorPatterns.powershell.$Category) {
    $memory.errorPatterns.powershell.$Category = @{}
  }
    
  $patternKey = $Pattern -replace '[^a-zA-Z0-9]', '_'
    
  if ($memory.errorPatterns.powershell.$Category.$patternKey) {
    # Update existing pattern
    $memory.errorPatterns.powershell.$Category.$patternKey.occurrenceCount += $OccurrenceCount
    $memory.errorPatterns.powershell.$Category.$patternKey.lastSeen = $LastSeen
    $memory.errorPatterns.powershell.$Category.$patternKey.effectiveness = 
    [math]::Round($memory.errorPatterns.powershell.$Category.$patternKey.errorsPrevented / 
      $memory.errorPatterns.powershell.$Category.$patternKey.occurrenceCount, 2)
  } else {
    # Add new pattern
    $memory.errorPatterns.powershell.$Category.$patternKey = @{
      pattern         = $Pattern
      fix             = $Fix
      prevention      = $Prevention
      occurrenceCount = $OccurrenceCount
      errorsPrevented = 0
      lastSeen        = $LastSeen
      effectiveness   = 0.0
      created         = (Get-Date -Format "o")
    }
    $memory.metrics.patternsLearned++
  }
    
  $memory | ConvertTo-Json -Depth 10 | Set-Content $MemoryPath
  Write-Host "Added/Updated error pattern: $patternKey" -ForegroundColor Green
}

function Add-Snippet {
  param(
    [string]$Name,
    [string]$Prefix,
    [string[]]$Body,
    [string]$Description,
    [string]$Category = "general"
  )
    
  $snippets = Get-Content $SnippetsPath | ConvertFrom-Json | ConvertTo-Hashtable
    
  $snippets.$Name = @{
    prefix      = $Prefix
    body        = $Body
    description = $Description
    category    = $Category
    created     = (Get-Date -Format "o")
    usageCount  = 0
  }
    
  $snippets | ConvertTo-Json -Depth 10 | Set-Content $SnippetsPath
  Write-Host "Added snippet: $Name" -ForegroundColor Green
}

function Add-Rule {
  param(
    [string]$Category,
    [string]$Name,
    [string]$Rule,
    [string]$Description,
    [int]$Priority = 5
  )
    
  $memory = Get-Content $MemoryPath | ConvertFrom-Json | ConvertTo-Hashtable
  
  # Ensure nested structure exists
  if (-not $memory.rules) { $memory.rules = @{} }
  if (-not $memory.rules.$Category) {
    $memory.rules.$Category = @{}
  }
    
  $memory.rules.$Category.$Name = @{
    rule        = $Rule
    description = $Description
    priority    = $Priority
    created     = (Get-Date -Format "o")
    enabled     = $true
  }
    
  $memory | ConvertTo-Json -Depth 10 | Set-Content $MemoryPath
  Write-Host "Added rule: $Name" -ForegroundColor Green
}

function Optimize-MemorySystem {
  $memory = Get-Content $MemoryPath | ConvertFrom-Json | ConvertTo-Hashtable
    
  # Ensure metrics object exists and is properly initialized
  if (-not $memory.metrics) {
    $memory.metrics = @{
      patternsLearned  = 0
      errorsPrevented  = 0
      effectiveness    = 0.0
      lastOptimization = ""
    }
  } else {
    # Ensure all required metrics properties exist
    if (-not $memory.metrics.patternsLearned) { $memory.metrics.patternsLearned = 0 }
    if (-not $memory.metrics.errorsPrevented) { $memory.metrics.errorsPrevented = 0 }
    if (-not $memory.metrics.effectiveness) { $memory.metrics.effectiveness = 0.0 }
    if (-not $memory.metrics.lastOptimization) { $memory.metrics.lastOptimization = "" }
  }
  
  # Remove old, ineffective patterns (older than 30 days and effectiveness < 0.3)
  $cutoffDate = (Get-Date).AddDays(-30)
  $removedCount = 0
    
  foreach ($category in $memory.errorPatterns.powershell.Keys) {
    $patternsToRemove = @()
    foreach ($pattern in $memory.errorPatterns.powershell.$category.Keys) {
      $patternData = $memory.errorPatterns.powershell.$category.$pattern
      $lastSeen = [DateTime]::Parse($patternData.lastSeen)
            
      if ($lastSeen -lt $cutoffDate -and $patternData.effectiveness -lt 0.3) {
        $patternsToRemove += $pattern
      }
    }
        
    foreach ($pattern in $patternsToRemove) {
      $memory.errorPatterns.powershell.$category.Remove($pattern)
      $removedCount++
    }
  }
    
  # Optimize snippet usage
  $snippets = Get-Content $SnippetsPath | ConvertFrom-Json | ConvertTo-Hashtable
  $unusedSnippets = @()
    
  foreach ($snippet in $snippets.Keys) {
    if ($snippets.$snippet.usageCount -eq 0 -and 
      [DateTime]::Parse($snippets.$snippet.created) -lt $cutoffDate) {
      $unusedSnippets += $snippet
    }
  }
    
  foreach ($snippet in $unusedSnippets) {
    $snippets.Remove($snippet)
  }
    
  # Update metrics
  $memory.metrics.lastOptimization = (Get-Date -Format "o")
  $memory.metrics.effectiveness = [math]::Round(
    ($memory.metrics.errorsPrevented / [math]::Max($memory.metrics.patternsLearned, 1)) * 100, 2
  )
    
  $memory | ConvertTo-Json -Depth 10 | Set-Content $MemoryPath
  $snippets | ConvertTo-Json -Depth 10 | Set-Content $SnippetsPath
    
  Write-Host "Memory optimization completed:" -ForegroundColor Green
  Write-Host "  - Removed $removedCount ineffective patterns" -ForegroundColor Yellow
  Write-Host "  - Removed $($unusedSnippets.Count) unused snippets" -ForegroundColor Yellow
  Write-Host "  - Overall effectiveness: $($memory.metrics.effectiveness)%" -ForegroundColor Cyan
}

function Generate-Report {
  $memory = Get-Content $MemoryPath | ConvertFrom-Json | ConvertTo-Hashtable
  $snippets = Get-Content $SnippetsPath | ConvertFrom-Json | ConvertTo-Hashtable
    
  Write-Host "=== Auto Memory Manager Report ===" -ForegroundColor Cyan
  Write-Host "Generated: $(Get-Date)" -ForegroundColor White
  Write-Host ""
    
  Write-Host "Error Patterns:" -ForegroundColor Yellow
  foreach ($category in $memory.errorPatterns.powershell.Keys) {
    $count = $memory.errorPatterns.powershell.$category.Keys.Count
    Write-Host "  $category`: $count patterns" -ForegroundColor White
  }
    
  Write-Host ""
  Write-Host "Snippets:" -ForegroundColor Yellow
  Write-Host "  Total: $($snippets.Keys.Count)" -ForegroundColor White
    
  Write-Host ""
  Write-Host "Metrics:" -ForegroundColor Yellow
  Write-Host "  Patterns Learned: $($memory.metrics.patternsLearned)" -ForegroundColor White
  Write-Host "  Errors Prevented: $($memory.metrics.errorsPrevented)" -ForegroundColor White
  Write-Host "  Effectiveness: $($memory.metrics.effectiveness)%" -ForegroundColor White
    
  Write-Host ""
  Write-Host "Top Performing Patterns:" -ForegroundColor Yellow
  $topPatterns = @()
  foreach ($category in $memory.errorPatterns.powershell.Keys) {
    foreach ($pattern in $memory.errorPatterns.powershell.$category.Keys) {
      $patternData = $memory.errorPatterns.powershell.$category.$pattern
      $topPatterns += [PSCustomObject]@{
        Category      = $category
        Pattern       = $pattern
        Effectiveness = $patternData.effectiveness
        Occurrences   = $patternData.occurrenceCount
      }
    }
  }
    
  $topPatterns | Sort-Object Effectiveness -Descending | Select-Object -First 5 | ForEach-Object {
    Write-Host "  $($_.Category)/$($_.Pattern): $($_.Effectiveness)% ($($_.Occurrences) occurrences)" -ForegroundColor White
  }
}

# Main execution
Initialize-MemorySystem

switch ($Action.ToLower()) {
  "analyze" {
    Generate-Report
  }
  "update" {
    # Auto-add common PowerShell error patterns
    Add-ErrorPattern -Category "syntax" -Pattern "try\s*{[^}]*$" -Fix "Add missing catch or finally block" -Prevention "Use try-catch snippet template"
    Add-ErrorPattern -Category "syntax" -Pattern "Test-Path\s+\$[^\s]+" -Fix "Add null/empty validation before Test-Path" -Prevention "Always validate paths before using Test-Path"
    Add-ErrorPattern -Category "validation" -Pattern "ConvertFrom-Json\s+[^|]*$" -Fix "Add error handling for JSON parsing" -Prevention "Wrap ConvertFrom-Json in try-catch"
        
    # Auto-add useful snippets
    Add-Snippet -Name "Try-Catch Block" -Prefix "trycatch" -Body @('try {', '    `$1', '} catch {', '    Write-Error "`$2: `$($_.Exception.Message)"', '    throw', '}') -Description "Standardized try-catch block"
    Add-Snippet -Name "Path Validation" -Prefix "pathval" -Body @('if (`$null -eq `$Path -or [string]::IsNullOrWhiteSpace(`$Path)) {', '    throw "Path is null or empty"', '}', 'if (-not (Test-Path `$Path)) {', '    throw "Path does not exist: `$Path"', '}') -Description "Path validation template"
        
    # Auto-add rules
    Add-Rule -Category "prevention" -Name "SyntaxCheck" -Rule "Always run syntax check before committing PowerShell code" -Description "Prevent syntax errors from reaching production"
    Add-Rule -Category "enforcement" -Name "ErrorHandling" -Rule "All file operations must be wrapped in try-catch blocks" -Description "Ensure robust error handling"
        
    Write-Host "Memory system updated with common patterns and snippets" -ForegroundColor Green
  }
  "optimize" {
    Optimize-MemorySystem
  }
  "report" {
    Generate-Report
  }
}