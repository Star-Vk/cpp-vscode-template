param(
    [string]$Preset = "debug"
)

if ($args.Count -gt 0 -or ($Preset -ne "debug" -and $Preset -ne "release")) {
    Write-Host "Usage: .\scripts\run.ps1 [debug|release]"
    exit 1
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")

Set-Location $RepoRoot

$ProjectLine = Get-Content "CMakeLists.txt" | Where-Object {
    $_ -match '^\s*project\s*\('
} | Select-Object -First 1

if (-not $ProjectLine -or $ProjectLine -notmatch '^\s*project\s*\(\s*"?([^"\s\)]+)"?') {
    Write-Host "Error: could not read project name from CMakeLists.txt."
    exit 1
}

$ProjectName = $Matches[1]
$Executable = Join-Path $RepoRoot "build\$Preset\bin\$ProjectName.exe"

Write-Host "Configuring preset: $Preset"
cmake --preset $Preset
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host "Building preset: $Preset"
cmake --build --preset $Preset
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

if (-not (Test-Path $Executable)) {
    Write-Host "Error: executable not found: $Executable"
    exit 1
}

Clear-Host

Write-Host "========== Build Finished. Running $ProjectName ==========" -ForegroundColor Green
Write-Host ""
Write-Host ""
& $Executable
$RunExitCode = $LASTEXITCODE

Write-Host ""
Write-Host ""
Write-Host "========== Run Finished. Exiting. ==========" -ForegroundColor Green

exit $RunExitCode
