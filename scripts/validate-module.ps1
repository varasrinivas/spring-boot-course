<#
.SYNOPSIS
    Validates a single module in the Spring Boot & Microservices course.
.PARAMETER ModuleId
    Module ID to validate, e.g. M01, M15, M32
.EXAMPLE
    .\validate-module.ps1 -ModuleId M01
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$ModuleId
)

$ErrorActionPreference = "Continue"
$htmlPath = Join-Path $PSScriptRoot "..\course\index.html"
$pass = 0; $fail = 0; $warn = 0
$results = @()

function Test-Check {
    param([string]$Name, [bool]$Condition, [string]$Detail = "")
    $script:results += [PSCustomObject]@{
        Check  = $Name
        Status = if($Condition){"PASS"}else{"FAIL"}
        Detail = $Detail
    }
    if($Condition){$script:pass++} else {$script:fail++}
}

function Test-Warn {
    param([string]$Name, [string]$Detail)
    $script:results += [PSCustomObject]@{Check=$Name;Status="WARN";Detail=$Detail}
    $script:warn++
}

Write-Host "`n╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Spring Course · Module Validator · $ModuleId          ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# ── 1. File exists ──
Test-Check "HTML file exists" (Test-Path $htmlPath) $htmlPath
if(-not (Test-Path $htmlPath)){
    Write-Host "FATAL: course/index.html not found" -ForegroundColor Red; exit 1
}
$src = Get-Content $htmlPath -Raw -Encoding UTF8

# ── 2. Module exists in MODS array ──
$modPattern = "`"id`":\s*`"$ModuleId`""
Test-Check "Module $ModuleId in MODS array" ($src -match $modPattern)

# ── 3. Extract module JSON (basic check) ──
$hasTitle = $src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,400}?`"title`":\s*`"([^`"]+)`""
Test-Check "Module has title" $hasTitle $(if($hasTitle){$Matches[1]}else{"not found"})

# ── 4. Has track field ──
Test-Check "Has track field" ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,200}`"track`":")

# ── 5. Has track_color field ──
Test-Check "Has track_color" ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,300}`"track_color`":\s*`"#[0-9a-fA-F]{6}`"")

# ── 6. Has objectives array ──
Test-Check "Has objectives" ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,500}`"objectives`":\s*\[")

# ── 7. Has intro ──
Test-Check "Has intro" ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,1000}`"intro`":")

# ── 8. Has concepts array ──
Test-Check "Has concepts array" ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,6000}`"concepts`":\s*\[")

# ── 9. Has at least one visual type ──
$mid = $ModuleId.ToLower()
Test-Check "Has visual reference" ($src -match "`"visual`":\s*`"$mid-")

# ── 10. renderVisual case exists ──
Test-Check "renderVisual case exists" ($src -match "case\s+`"$mid-")

# ── 11. Has comingFrom section ──
$cfSearch = "`"id`":\s*`"$ModuleId`"[\s\S]{0,16000}`"comingFrom`""
Test-Check "Has Coming From Java" ($src -match $cfSearch)

# ── 12. Has keyTakeaways ──
$ktSearch = "`"id`":\s*`"$ModuleId`"[\s\S]{0,18000}`"keyTakeaways`""
Test-Check "Has key takeaways" ($src -match $ktSearch)

# ── 13. Prior-Auth domain references in code ──
$domainTerms = "PriorAuth|Authorization|prior.?auth|Patient|Provider|RequestedService|authNumber|CPT"
$hasDomain = ($src -match "`"id`":\s*`"$ModuleId`"[\s\S]{0,16000}($domainTerms)")
if($ModuleId -eq "M00") { $hasDomain = $true }  # M00 intro doesn't need code
Test-Check "Prior-Auth domain in content" $hasDomain

# ── 14. SVG accessibility ──
$svgAccessible = ($src -match "case\s+`"$mid-[\s\S]{0,200}role=.img")
if($src -notmatch "case\s+`"$mid-") { $svgAccessible = $true }  # no visual = skip
Test-Check "SVG has role=img" $svgAccessible

$ariaLabel = ($src -match "case\s+`"$mid-[\s\S]{0,300}aria-label=")
if($src -notmatch "case\s+`"$mid-") { $ariaLabel = $true }
Test-Check "SVG has aria-label" $ariaLabel

# ── 15. No external JS/CSS (except Google Fonts) ──
$extScripts = [regex]::Matches($src, '<script\s+src="([^"]+)"')
$badExt = $extScripts | Where-Object { $_.Groups[1].Value -notmatch "googleapis" }
Test-Check "No external scripts" ($badExt.Count -eq 0) $(if($badExt.Count -gt 0){$badExt[0].Groups[1].Value}else{"clean"})

# ── 16. Fraunces font loaded ──
Test-Check "Fraunces font loaded" ($src -match "Fraunces")

# ── 17. JetBrains Mono font loaded ──
Test-Check "JetBrains Mono loaded" ($src -match "JetBrains\+Mono|JetBrains Mono")

# ── 18. Reduced motion respected ──
Test-Check "prefers-reduced-motion" ($src -match "prefers-reduced-motion")

# ── 19. File size under cap ──
# Single-file course by design (validator + self-contained rule depend on MODS/renderVisual
# living in index.html). Full 37-module course lands ~740KB, fine for a browser; cap 1.5MB.
$sizeKB = [math]::Round((Get-Item $htmlPath).Length / 1KB, 1)
Test-Check "File size < 1.5MB" ($sizeKB -lt 1536) "${sizeKB}KB"

# ── 20. Labs exist (warning only) ──
$labU = Join-Path $PSScriptRoot "..\labs\$ModuleId-lab-understand.md"
$labB = Join-Path $PSScriptRoot "..\labs\$ModuleId-lab-build.md"
if(-not (Test-Path $labU)) { Test-Warn "Understand lab missing" $labU }
if(-not (Test-Path $labB)) { Test-Warn "Build lab missing" $labB }

# ── REPORT ──
Write-Host "`n─── RESULTS ──────────────────────────────────────" -ForegroundColor Gray
$results | ForEach-Object {
    $color = switch($_.Status){"PASS"{"Green"}"FAIL"{"Red"}"WARN"{"Yellow"}}
    $icon  = switch($_.Status){"PASS"{"✓"}"FAIL"{"✗"}"WARN"{"⚠"}}
    Write-Host "  $icon " -NoNewline -ForegroundColor $color
    Write-Host "$($_.Check)" -NoNewline
    if($_.Detail){ Write-Host " → $($_.Detail)" -ForegroundColor DarkGray }
    else { Write-Host "" }
}

Write-Host "`n─── SUMMARY ──────────────────────────────────────" -ForegroundColor Gray
Write-Host "  PASS: $pass  FAIL: $fail  WARN: $warn" -ForegroundColor $(if($fail -eq 0){"Green"}else{"Red"})
Write-Host ""

exit $fail
