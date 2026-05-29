# Publish-Talk.ps1
# Publishes a talk from a local source folder to talks\<slug>\ and pushes to GitHub Pages.
#
# Handles two pieces of drift that bit us before:
#   1. Renames deck.html -> index.html on copy, so the folder URL resolves to the deck.
#   2. Rewrites src="deck.html..." and href="deck.html..." references in supporting files
#      (presenter.html, storyboard.html) so links keep working after the rename.
#
# Source keeps deck.html named deck.html so local file:// browsing works.
# This script is the only place that knows about the rename.
#
# Usage:
#   .\Publish-Talk.ps1 -Source "C:\path\to\source-folder" -Slug "frontier-firms-2026"
#   .\Publish-Talk.ps1 -Source "..." -Slug "..." -Message "Fix venue typo"
#   .\Publish-Talk.ps1 -Source "..." -Slug "..." -WhatIf      # dry run
#   .\Publish-Talk.ps1 -Source "..." -Slug "..." -NoPush      # commit locally, don't push

param(
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$Slug,
    [string]$Message,
    [switch]$NoPush,
    [switch]$WhatIf
)

$ErrorActionPreference = "Stop"
$repoDir = "C:\Users\jwallquist\talks"
$dest    = Join-Path $repoDir $Slug

# Validate inputs
if (-not (Test-Path $Source))                            { Write-Error "Source folder not found: $Source"; return }
if (-not (Test-Path (Join-Path $Source "deck.html")))    { Write-Error "Source must contain deck.html: $Source"; return }
if (-not (Test-Path $repoDir))                           { Write-Error "Talks repo clone not found: $repoDir"; return }

# Source filename -> destination filename. Order matters only for the log output.
$fileMap = [ordered]@{
    "deck.html"       = "index.html"
    "presenter.html"  = "presenter.html"
    "storyboard.html" = "storyboard.html"
}

if (-not $WhatIf) {
    New-Item -Path $dest -ItemType Directory -Force | Out-Null
}

Write-Host "Source: $Source"
Write-Host "Dest:   $dest"
Write-Host ""

$copied  = @()
$skipped = @()

foreach ($srcName in $fileMap.Keys) {
    $srcPath = Join-Path $Source $srcName
    $dstName = $fileMap[$srcName]
    $dstPath = Join-Path $dest $dstName

    if (-not (Test-Path $srcPath)) {
        $skipped += $srcName
        continue
    }

    if ($WhatIf) {
        Write-Host "[WhatIf] would copy  $srcName  ->  $Slug\$dstName" -ForegroundColor Yellow
        $copied += $srcName
        continue
    }

    # Read source, rewrite path references, write to dest.
    # Scoped to src=" and href=" attribute values so prose mentions stay untouched
    # (the deck has intentional 'deck.html' strings in a terminal mock graphic).
    $content = Get-Content -Path $srcPath -Raw
    $content = $content -replace '(?<=src=")deck\.html',  'index.html'
    $content = $content -replace "(?<=src=')deck\.html",  'index.html'
    $content = $content -replace '(?<=href=")deck\.html', 'index.html'
    $content = $content -replace "(?<=href=')deck\.html", 'index.html'
    [System.IO.File]::WriteAllText($dstPath, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  copied  $srcName  ->  $dstName" -ForegroundColor Cyan
    $copied += "$srcName -> $dstName"
}

Write-Host ""
Write-Host "Copied:  $($copied -join ', ')" -ForegroundColor Green
if ($skipped.Count) { Write-Host "Skipped (not in source): $($skipped -join ', ')" -ForegroundColor DarkGray }
Write-Host ""

# Stage, commit, push
Push-Location $repoDir
try {
    git add -- "$Slug/" | Out-Null
    $cached = git diff --cached --stat -- "$Slug/"
    if (-not $cached) {
        Write-Host "No changes in $Slug/ to commit." -ForegroundColor Yellow
        return
    }

    Write-Host "Staged changes:" -ForegroundColor Cyan
    Write-Host $cached

    if ($WhatIf) {
        Write-Host ""
        Write-Host "[WhatIf] would commit and push." -ForegroundColor Yellow
        git reset HEAD -- "$Slug/" | Out-Null
        return
    }

    if (-not $Message) { $Message = "Update $Slug talk" }
    $commitMsg = "$Message`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
    git commit --only -m $commitMsg -- "$Slug/" | Out-Null
    if ($LASTEXITCODE -ne 0) { Write-Error "git commit failed (exit $LASTEXITCODE)"; return }
    Write-Host ""
    Write-Host "Committed: $Message" -ForegroundColor Green

    if ($NoPush) {
        Write-Host "Push skipped (-NoPush)." -ForegroundColor Yellow
        return
    }

    git push origin main
    if ($LASTEXITCODE -ne 0) { Write-Error "git push failed (exit $LASTEXITCODE)"; return }
    Write-Host ""
    Write-Host "Deployed: https://jw-sthlm.github.io/talks/$Slug/" -ForegroundColor Green
}
finally {
    Pop-Location
}
