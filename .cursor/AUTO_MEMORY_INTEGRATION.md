# Auto Memory Management System - Integration Guide

## Overview

The Auto Memory Management System automatically learns from coding mistakes and prevents repeated errors by:
- Detecting and storing error patterns
- Creating reusable code snippets
- Implementing prevention rules
- Optimizing memory usage

## Components

### 1. Auto Memory Manager (`auto-memory-manager.ps1`)
**Main system for managing error patterns, snippets, and rules**

**Actions:**
- `update` - Adds common patterns, snippets, and rules
- `report` - Generates comprehensive system report
- `optimize` - Removes ineffective patterns and unused snippets
- `analyze` - Same as report

**Usage:**
```powershell
# Initialize with common patterns
.\.cursor\auto-memory-manager.ps1 -Action "update"

# Generate report
.\.cursor\auto-memory-manager.ps1 -Action "report"

# Optimize memory
.\.cursor\auto-memory-manager.ps1 -Action "optimize"
```

### 2. Auto Learn Integration (`auto-learn.ps1`)
**Automatically learns from errors and creates patterns/snippets**

**Usage:**
```powershell
# Learn from a syntax error
.\.cursor\auto-learn.ps1 -ErrorType "syntax" -ErrorMessage "Missing closing brace" -FixedCode "try { ... } catch { ... }"

# Learn from a validation error
.\.cursor\auto-learn.ps1 -ErrorType "validation" -ErrorMessage "Value cannot be null" -FixedCode "if (`$null -eq `$value) { throw 'Required' }"
```

### 3. Scheduled Optimization (`schedule-optimization.ps1`)
**Automatically optimizes memory system on schedule**

**Usage:**
```powershell
# Schedule daily optimization
.\.cursor\schedule-optimization.ps1 -Schedule "Daily" -Time "02:00"

# Schedule weekly optimization
.\.cursor\schedule-optimization.ps1 -Schedule "Weekly" -Day "Sunday" -Time "03:00"
```

## Integration with Cursor

### 1. Cursor Configuration
Add to your `.cursor/settings.json`:

```json
{
  "cursor.rules": {
    "errorPatterns": {
      "powershell": {
        "syntax": {
          "try_s________": {
            "pattern": "try\\s*{[^}]*$",
            "fix": "Add missing catch or finally block",
            "prevention": "Use try-catch snippet template"
          }
        }
      }
    },
    "snippets": {
      "Try-Catch Block": {
        "prefix": "trycatch",
        "body": [
          "try {",
          "    $1",
          "} catch {",
          "    Write-Error \"$2: $($_.Exception.Message)\"",
          "    throw",
          "}"
        ]
      }
    }
  }
}
```

### 2. Pre-commit Hook
Add to your `.git/hooks/pre-commit`:

```bash
#!/bin/bash
# Auto-learn from recent errors
cd "$(git rev-parse --show-toplevel)"
powershell -ExecutionPolicy Bypass -File ".cursor/auto-learn.ps1" -ErrorType "syntax" -ErrorMessage "$ERROR_MSG" -FixedCode "$FIXED_CODE"
```

### 3. VS Code Integration
Add to your VS Code settings:

```json
{
  "powershell.integratedConsole.extraArgs": [
    "-ExecutionPolicy", "Bypass",
    "-File", ".cursor/auto-memory-manager.ps1",
    "-Action", "update"
  ]
}
```

## Error Pattern Categories

### Syntax Errors
- **Pattern**: `try\s*{[^}]*$`
- **Fix**: Add missing catch or finally block
- **Prevention**: Use try-catch snippet template

### Validation Errors
- **Pattern**: `Test-Path\s+\$[^\s]+`
- **Fix**: Add null/empty validation before Test-Path
- **Prevention**: Always validate paths before using Test-Path

### Logic Errors
- **Pattern**: `ConvertFrom-Json\s+[^|]*$`
- **Fix**: Add error handling for JSON parsing
- **Prevention**: Wrap ConvertFrom-Json in try-catch

## Snippet Templates

### Try-Catch Block
```powershell
try {
    $1
} catch {
    Write-Error "$2: $($_.Exception.Message)"
    throw
}
```

### Path Validation
```powershell
if ($null -eq $Path -or [string]::IsNullOrWhiteSpace($Path)) {
    throw "Path is null or empty"
}
if (-not (Test-Path $Path)) {
    throw "Path does not exist: $Path"
}
```

### Function Template
```powershell
function $1 {
    param(
        [Parameter(Mandatory = $false)]
        [string]$Parameter1,
        
        [Parameter(Mandatory = $false)]
        [switch]$Switch1,
    )
    
    try {
        $2
    } catch {
        Write-Error "$1 failed: $($_.Exception.Message)"
        throw
    }
}
```

## Prevention Rules

### SyntaxCheck
- **Rule**: Always run syntax check before committing PowerShell code
- **Priority**: 5
- **Category**: prevention

### ErrorHandling
- **Rule**: All file operations must be wrapped in try-catch blocks
- **Priority**: 5
- **Category**: enforcement

## Metrics and Reporting

The system tracks:
- **Patterns Learned**: Total number of error patterns discovered
- **Errors Prevented**: Number of errors prevented by the system
- **Effectiveness**: Percentage of errors prevented vs. patterns learned
- **Top Performing Patterns**: Most effective error patterns

## Best Practices

1. **Regular Updates**: Run `update` action weekly to add new common patterns
2. **Optimization**: Run `optimize` action monthly to clean up ineffective patterns
3. **Learning**: Use `auto-learn.ps1` whenever you fix an error to improve the system
4. **Reporting**: Generate reports regularly to track system effectiveness
5. **Integration**: Integrate with your development workflow for maximum benefit

## Troubleshooting

### Common Issues

1. **Path Resolution**: Ensure scripts run from project root directory
2. **JSON Corruption**: Run `optimize` action to fix corrupted memory files
3. **Function Import**: Make sure auto-memory-manager.ps1 is dot-sourced properly
4. **Permissions**: Ensure PowerShell execution policy allows script execution

### Error Messages

- **"Cannot find path"**: Check if memory files exist in `.cursor/` directory
- **"Property cannot be found"**: Run `update` action to initialize memory structure
- **"ConvertTo-Hashtable not found"**: Ensure auto-memory-manager.ps1 is imported

## Future Enhancements

1. **Machine Learning**: Implement ML-based pattern recognition
2. **IDE Integration**: Direct integration with VS Code, Cursor, and other IDEs
3. **Team Sharing**: Share learned patterns across team members
4. **Language Support**: Extend to other programming languages
5. **Real-time Learning**: Learn from errors as they occur during development 