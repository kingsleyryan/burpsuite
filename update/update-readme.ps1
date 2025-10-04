# update-readme.ps1
# Auto-update BurpSuite README.md with folder structure

# Get the script’s directory (works when the script is executed)
$basePath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$burpRoot = Split-Path $basePath
$readmePath = Join-Path $burpRoot "README.md"

# Generate folder tree (excluding 'update' folder)
$tree = tree $burpRoot /f | Out-String
$filteredTree = ($tree -split "`n" | Where-Object {$_ -notmatch "\\update"} ) -join "`n"

# Write to README.md
@"
# BurpSuite Labs Repository

This README automatically lists all modules and tasks under BurpSuite.  
_Last updated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')_

---

## Folder Structure
\`\`\`
$filteredTree
\`\`\`

---

To update this README after adding new modules, run:

\`\`\`powershell
cd update
./update-readme.ps1
\`\`\`
"@ | Set-Content -Path $readmePath -Encoding UTF8

Write-Host "✅ README.md updated successfully at $readmePath" -ForegroundColor Green
