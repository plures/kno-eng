# Test script for auto-learn functionality
Write-Host "Testing Auto-Learn System..." -ForegroundColor Cyan

# Test 1: Syntax error learning
Write-Host "`nTest 1: Learning from syntax error..." -ForegroundColor Yellow
& "$PSScriptRoot\auto-learn.ps1" -ErrorType "syntax" -ErrorMessage "Unexpected token '}'" -FixedCode "if (`$condition) { `$action }"

# Test 2: Validation error learning  
Write-Host "`nTest 2: Learning from validation error..." -ForegroundColor Yellow
& "$PSScriptRoot\auto-learn.ps1" -ErrorType "validation" -ErrorMessage "Value cannot be null" -FixedCode "if (`$null -eq `$value) { throw 'Value is required' }"

# Test 3: Generate report
Write-Host "`nTest 3: Generating report..." -ForegroundColor Yellow
& "$PSScriptRoot\auto-memory-manager.ps1" -Action "report"

Write-Host "`nAuto-learn testing completed!" -ForegroundColor Green 