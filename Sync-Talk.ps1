# Sync-Talk.ps1 — Copy local presentation to GitHub Pages and deploy
param([switch]$WhatIf)

$source = "C:\Users\jwallquist\work\agentic-ai-partner-library\outputs\external\agents-7shades.html"
$dest = "C:\Users\jwallquist\talks\agents-2026\index.html"
$repoDir = "C:\Users\jwallquist\talks"

if (-not (Test-Path $source)) { Write-Error "Source not found: $source"; return }

Copy-Item $source $dest -Force
# Also sync QR image
Copy-Item "C:\Users\jwallquist\work\agentic-ai-partner-library\outputs\external\qr-agentjohan.png" "$repoDir\agents-2026\qr-agentjohan.png" -Force

if ($WhatIf) {
    Write-Host "Would deploy:" -ForegroundColor Yellow
    Push-Location $repoDir; git --no-pager diff --stat; Pop-Location
    return
}

Push-Location $repoDir
git add -A
$changes = git diff --cached --stat
if ($changes) {
    git commit -m "Update: Autonoma Agenter presentation`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
    git push origin main
    Write-Host "✓ Deployed to jw-sthlm.github.io/talks/agents-2026/" -ForegroundColor Green
} else {
    Write-Host "No changes to deploy." -ForegroundColor Yellow
}
Pop-Location
