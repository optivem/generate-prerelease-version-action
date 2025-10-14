param(
    [string]$PrereleaseSuffix = "rc",
    [string]$GitHubOutput = $env:GITHUB_OUTPUT
)

Write-Host "🏷️ Generating semantic prerelease version..."
Write-Host ""
Write-Host "📋 Input Parameters:"
Write-Host "   Prerelease Suffix: $PrereleaseSuffix"
Write-Host "   GitHub Output File: $GitHubOutput"
Write-Host ""

# Get the latest semantic version tag (including prerelease tags)
Write-Host "📋 Finding latest semantic version tag..."
$latestTag = & git tag -l "v*.*.*" --sort=-version:refname | Select-Object -First 1

if ([string]::IsNullOrEmpty($latestTag)) {
    Write-Host "🆕 No existing semantic version tags found, starting with v0.0.0"
    $latestTag = "v0.0.0"
}

Write-Host "📌 Latest tag: $latestTag"

# Parse current version - handle both stable and prerelease tags
$versionPart = $latestTag -replace "v", ""

# Check if it's a prerelease tag (contains hyphen)
if ($versionPart -match "^(\d+)\.(\d+)\.(\d+)(-.*)?$") {
    $currentMajor = [int]$matches[1]
    $currentMinor = [int]$matches[2]
    $currentPatch = [int]$matches[3]
    $prereleaseInfo = $matches[4]
    
    if ($prereleaseInfo) {
        Write-Host "📊 Current version: $currentMajor.$currentMinor.$currentPatch (prerelease: $prereleaseInfo)"
    } else {
        Write-Host "📊 Current version: $currentMajor.$currentMinor.$currentPatch (stable)"
    }
} else {
    Write-Error "❌ Invalid semantic version format: $latestTag. Expected format: v1.2.3 or v1.2.3-suffix"
    exit 1
}

# Always increment patch version
$newMajor = $currentMajor
$newMinor = $currentMinor
$newPatch = $currentPatch + 1

Write-Host "🐛 Patch version bump: $currentMajor.$currentMinor.$currentPatch -> $newMajor.$newMinor.$newPatch"

# Generate version strings
$nextVersion = "v$newMajor.$newMinor.$newPatch"
$prereleaseVersion = "$nextVersion-$PrereleaseSuffix"

Write-Host "📦 Generated versions:"
Write-Host "   Next release: $nextVersion"
Write-Host "   Prerelease: $prereleaseVersion" 

# Output the version
if ($GitHubOutput) {
    Add-Content -Path $GitHubOutput -Value "version=$prereleaseVersion"
    Write-Host "✅ Set output 'version' to: $prereleaseVersion"
} else {
    Write-Host "⚠️ GITHUB_OUTPUT not set, output not written to file"
}

Write-Host ""
Write-Host "🎉 Version generation completed successfully!"
Write-Host "Generated prerelease version: $prereleaseVersion"
