# Watch-And-Deploy.ps1 — Auto-deploy presentation to GitHub Pages on save
$source = "C:\Users\jwallquist\work\agentic-ai-partner-library\outputs\external"
$dest = "C:\Users\jwallquist\talks\agents-2026"
$repoDir = "C:\Users\jwallquist\talks"
$files = @("agents-7shades.html", "agents-7shades-presenter.html", "qr-agentjohan.png")

$watcher = New-Object System.IO.FileSystemWatcher $source, "agents-7shades*.html"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

$action = {
    Start-Sleep -Seconds 2  # debounce
    $files = @("agents-7shades.html", "agents-7shades-presenter.html", "qr-agentjohan.png")
    $source = "C:\Users\jwallquist\work\agentic-ai-partner-library\outputs\external"
    $dest = "C:\Users\jwallquist\talks\agents-2026"
    $repoDir = "C:\Users\jwallquist\talks"
    
    foreach ($f in $files) {
        $src = Join-Path $source $f
        if (Test-Path $src) { Copy-Item $src (Join-Path $dest ($f -replace 'agents-7shades\.html','index.html')) -Force }
    }
    # Special case: main deck → index.html
    Copy-Item (Join-Path $source "agents-7shades.html") (Join-Path $dest "index.html") -Force
    Copy-Item (Join-Path $source "agents-7shades-presenter.html") (Join-Path $dest "agents-7shades-presenter.html") -Force -ErrorAction SilentlyContinue
    Copy-Item (Join-Path $source "qr-agentjohan.png") (Join-Path $dest "qr-agentjohan.png") -Force -ErrorAction SilentlyContinue
    
    Push-Location $repoDir
    git add -A 2>$null
    $changes = git diff --cached --stat 2>$null
    if ($changes) {
        git commit -m "Auto-update presentation`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>" 2>$null
        git push origin main 2>$null
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Deployed to jw-sthlm.github.io/talks/agents-2026/" -ForegroundColor Green
    }
    Pop-Location
}

Register-ObjectEvent $watcher Changed -Action $action | Out-Null
Write-Host "Watching for changes... (Ctrl+C to stop)" -ForegroundColor Cyan
Write-Host "Auto-deploys agents-7shades.html + presenter + QR to GitHub Pages" -ForegroundColor DarkGray
while ($true) { Start-Sleep -Seconds 5 }
