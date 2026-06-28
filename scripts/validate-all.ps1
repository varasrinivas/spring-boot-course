<#
.SYNOPSIS
    Validates all modules in the Spring Boot & Microservices course.
.EXAMPLE
    .\validate-all.ps1
#>

$scriptDir = $PSScriptRoot
$htmlPath = Join-Path $scriptDir "..\course\index.html"

if(-not (Test-Path $htmlPath)){
    Write-Host "FATAL: course/index.html not found" -ForegroundColor Red; exit 1
}

$src = Get-Content $htmlPath -Raw -Encoding UTF8
$moduleIds = [regex]::Matches($src, '"id":\s*"(M\d{2})"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique

Write-Host "`n╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Spring Course · Full Validation                ║" -ForegroundColor Cyan
Write-Host "║  Found $($moduleIds.Count) modules                                  ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$totalPass = 0; $totalFail = 0; $totalWarn = 0

foreach($mid in $moduleIds){
    Write-Host "━━━ Validating $mid ━━━" -ForegroundColor Yellow
    & (Join-Path $scriptDir "validate-module.ps1") -ModuleId $mid
    # Count exit code
    if($LASTEXITCODE -eq 0){ $totalPass++ } else { $totalFail++ }
}

Write-Host "`n══════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  MODULES PASSED: $totalPass / $($moduleIds.Count)" -ForegroundColor $(if($totalFail -eq 0){"Green"}else{"Red"})
if($totalFail -gt 0){ Write-Host "  MODULES WITH FAILURES: $totalFail" -ForegroundColor Red }
Write-Host ""
