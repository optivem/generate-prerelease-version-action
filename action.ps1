param(param(

    [string]$PrereleaseSuffix = "rc",    [string]$ImageUrls,

    [string]$GitHubOutput = $env:GITHUB_OUTPUT    [string]$RegistryToken,

)    [string]$RegistryUsername,

    [string]$PrereleaseSuffix = "rc",

Write-Host "🏷️ Generating semantic prerelease version..."    [string]$GitHubOutput = $env:GITHUB_OUTPUT

Write-Host "")

Write-Host "📋 Input Parameters:"

Write-Host "   Prerelease Suffix: $PrereleaseSuffix"Write-Host "🏷️ Generating semantic version for Docker images..."

Write-Host "   GitHub Output File: $GitHubOutput"Write-Host ""

Write-Host ""Write-Host "📋 Input Parameters:"

Write-Host "   Image URLs: $ImageUrls"

# Get the latest semantic version tag (including prerelease tags)Write-Host "   Prerelease Suffix: $PrereleaseSuffix"

Write-Host "📋 Finding latest semantic version tag..."Write-Host "   GitHub Output File: $GitHubOutput"

$latestTag = & git tag -l "v*.*.*" --sort=-version:refname | Select-Object -First 1Write-Host ""

Write-Host "🔍 Debug - Image URLs Analysis:"

if ([string]::IsNullOrEmpty($latestTag)) {Write-Host "   Type: $($ImageUrls.GetType().Name)"

    Write-Host "🆕 No existing semantic version tags found, starting with v0.0.0"Write-Host "   Length: $($ImageUrls.Length)"

    $latestTag = "v0.0.0"Write-Host "   Raw Value: '$ImageUrls'"

}Write-Host "   Contains newlines: $(if ($ImageUrls.Contains("`n")) { 'Yes' } else { 'No' })"

Write-Host "   Contains carriage returns: $(if ($ImageUrls.Contains("`r")) { 'Yes' } else { 'No' })"

Write-Host "📌 Latest tag: $latestTag"Write-Host ""

Write-Host "Image URLs:"

# Parse current version - handle both stable and prerelease tags

$versionPart = $latestTag -replace "v", ""# Parse image URLs - support both newline-separated and JSON array formats

$imageUrlList = @()

# Check if it's a prerelease tag (contains hyphen)

if ($versionPart -match "^(\d+)\.(\d+)\.(\d+)(-.*)?$") {# Try to parse as JSON first

    $currentMajor = [int]$matches[1]$trimmedInput = $ImageUrls.Trim()

    $currentMinor = [int]$matches[2]if ($trimmedInput.StartsWith('[') -and $trimmedInput.EndsWith(']')) {

    $currentPatch = [int]$matches[3]    try {

    $prereleaseInfo = $matches[4]        Write-Host "📋 Detected JSON array format"

            $jsonArray = $ImageUrls | ConvertFrom-Json

    if ($prereleaseInfo) {        # Always treat as array (PowerShell returns single string for 1-item JSON arrays)

        Write-Host "📊 Current version: $currentMajor.$currentMinor.$currentPatch (prerelease: $prereleaseInfo)"        $imageUrlList = @($jsonArray) | Where-Object { $_.Trim() -ne "" } | ForEach-Object { $_.Trim() }

    } else {    } catch {

        Write-Host "📊 Current version: $currentMajor.$currentMinor.$currentPatch (stable)"        Write-Error "❌ Invalid JSON format in image-urls input: $($_.Exception.Message)"

    }        exit 1

} else {    }

    Write-Error "❌ Invalid semantic version format: $latestTag. Expected format: v1.2.3 or v1.2.3-suffix"} else {

    exit 1    # Parse as newline-separated format

}    Write-Host "📋 Detected newline-separated format"

    $imageUrlList = $ImageUrls -split "`r?`n" | Where-Object { 

# Always increment patch version        $_.Trim() -ne "" -and $_.Trim() -notmatch "^#" 

$newMajor = $currentMajor    } | ForEach-Object { $_.Trim() }

$newMinor = $currentMinor}

$newPatch = $currentPatch + 1

if ($imageUrlList.Count -eq 0) {

Write-Host "🐛 Patch version bump: $currentMajor.$currentMinor.$currentPatch -> $newMajor.$newMinor.$newPatch"    Write-Error "❌ No valid image URLs provided. Please provide at least one image URL."

    exit 1

# Generate version strings}

$nextVersion = "v$newMajor.$newMinor.$newPatch"

$prereleaseVersion = "$nextVersion-$PrereleaseSuffix"foreach ($url in $imageUrlList) {

    Write-Host "  - $url"

Write-Host "📦 Generated versions:"}

Write-Host "   Next release: $nextVersion"Write-Host "Prerelease suffix: $PrereleaseSuffix"

Write-Host "   Prerelease: $prereleaseVersion" 

# Get the latest semantic version tag (including prerelease tags)

# Output the prerelease versionWrite-Host "📋 Finding latest semantic version tag..."

if ($GitHubOutput) {$latestTag = & git tag -l "v*.*.*" --sort=-version:refname | Select-Object -First 1

    Add-Content -Path $GitHubOutput -Value "prerelease-version=$prereleaseVersion"

    Write-Host "✅ Set output 'prerelease-version' to: $prereleaseVersion"if ([string]::IsNullOrEmpty($latestTag)) {

} else {    Write-Host "🆕 No existing semantic version tags found, starting with v0.0.0"

    Write-Host "⚠️ GITHUB_OUTPUT not set, output not written to file"    $latestTag = "v0.0.0"

}}



Write-Host ""Write-Host "📌 Latest tag: $latestTag"

Write-Host "🎉 Version generation completed successfully!"

Write-Host "Generated prerelease version: $prereleaseVersion"# Parse current version - handle both stable and prerelease tags
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
$dockerTag = $prereleaseVersion

Write-Host "📦 Generated versions:"
Write-Host "   Next release: $nextVersion"
Write-Host "   Prerelease: $prereleaseVersion" 
Write-Host "   Docker tag: $dockerTag"

# Parse image URL to extract base URL and source reference
Write-Host "🔍 Parsing image URLs..."

$processedImages = @()
$targetImagesList = @()
$allRegistryHosts = @()

foreach ($ImageUrl in $imageUrlList) {
    Write-Host "`n📋 Processing: $ImageUrl"
    
    if ($ImageUrl -match "^(.+)@(sha256:[a-f0-9]{64})$") {
        # URL contains digest: ghcr.io/repo/image@sha256:abc123
        $baseImageUrl = $matches[1]
        $sourceImage = $ImageUrl  # Use the full URL as provided
        Write-Host "   � Detected digest in URL: $($matches[2])"
    } elseif ($ImageUrl -match "^(.+):([^@]+)$") {
        # URL contains tag: ghcr.io/repo/image:latest
        $baseImageUrl = $matches[1]
        $sourceImage = $ImageUrl  # Use the full URL as provided
        Write-Host "   � Detected tag in URL: $($matches[2])"
    } else {
        Write-Error "❌ Invalid image URL format: $ImageUrl. Must include tag or digest (e.g., image:tag or image@digest)"
        exit 1
    }

    # Generate target image URL
    $targetImage = "$baseImageUrl`:$dockerTag"
    
    # Also tag with additional semantic version tags
    $majorTag = "$baseImageUrl`:v$newMajor"
    $minorTag = "$baseImageUrl`:v$newMajor.$newMinor"

    Write-Host "   🎯 Target: $targetImage"
    Write-Host "   🏷️ Major: $majorTag"
    Write-Host "   🏷️ Minor: $minorTag"

    # Store processed image info
    $imageInfo = @{
        source = $sourceImage
        target = $targetImage
        base = $baseImageUrl
        majorTag = $majorTag
        minorTag = $minorTag
        registry = ($baseImageUrl -split '/' | Select-Object -First 1)
    }
    $processedImages += $imageInfo
    $targetImagesList += $targetImage
    
    # Track registry hosts for login
    $registryHost = $baseImageUrl -split '/' | Select-Object -First 1
    if ($allRegistryHosts -notcontains $registryHost) {
        $allRegistryHosts += $registryHost
    }
}

# Set outputs
Write-Host ""
Write-Host "📤 Setting GitHub Action Outputs:"
Write-Host "   prerelease-version: $prereleaseVersion"
"prerelease-version=$prereleaseVersion" | Out-File -FilePath $GitHubOutput -Append -Encoding utf8

# Create JSON array of prerelease image URLs (ensure it's always an array)
if ($targetImagesList.Count -eq 1) {
    $prereleaseImageUrlsJson = "[$($targetImagesList[0] | ConvertTo-Json)]"
} else {
    $prereleaseImageUrlsJson = $targetImagesList | ConvertTo-Json -Compress
}
Write-Host "   image-prerelease-urls: $prereleaseImageUrlsJson"
"image-prerelease-urls=$prereleaseImageUrlsJson" | Out-File -FilePath $GitHubOutput -Append -Encoding utf8

# Docker operations
if ($env:MOCK_DOCKER -eq "true") {
    Write-Host "`n🔑 [MOCK] Logging in to container registries..." -ForegroundColor Magenta
    foreach ($registryHost in $allRegistryHosts) {
        Write-Host "📋 [MOCK] Detected registry: $registryHost" -ForegroundColor Magenta
    }
    
    foreach ($imageInfo in $processedImages) {
        Write-Host "📥 [MOCK] Docker pull successful: $($imageInfo.source)" -ForegroundColor Magenta
        Write-Host "🏷️ [MOCK] Docker tag successful: $($imageInfo.target)" -ForegroundColor Magenta
        Write-Host "📤 [MOCK] Docker push successful: $($imageInfo.target)" -ForegroundColor Magenta
    }
} else {
    Write-Host "`n🔑 Logging in to container registries..."

    # Login to all unique registries
    foreach ($registryHost in $allRegistryHosts) {
        if ($registryHost -eq "docker.io" -or $registryHost -notmatch "\.") {
            # Docker Hub (special case - can omit registry host)
            Write-Host "📋 Detected Docker Hub registry"
            $RegistryToken | docker login -u $RegistryUsername --password-stdin
        } else {
            # Other registries (GHCR, ACR, ECR, etc.)
            Write-Host "📋 Detected registry: $registryHost"
            $RegistryToken | docker login $registryHost -u $RegistryUsername --password-stdin
        }

        if ($LASTEXITCODE -ne 0) {
            Write-Error "❌ Docker login failed for registry: $registryHost"
            Write-Host "🔍 Debug info:" -ForegroundColor Yellow
            Write-Host "   Registry Host: $registryHost" -ForegroundColor Gray
            Write-Host ""
            Write-Host "💡 Possible causes:" -ForegroundColor Yellow
            Write-Host "   - Invalid registry token for $registryHost" -ForegroundColor Gray
            Write-Host "   - Token doesn't have push permissions" -ForegroundColor Gray
            Write-Host "   - Registry hostname is incorrect" -ForegroundColor Gray
            exit 1
        }
    }

    # Process each image
    Write-Host "`n� Processing Docker images..."
    foreach ($imageInfo in $processedImages) {
        Write-Host "`n📦 Processing: $($imageInfo.source)"
        
        Write-Host "�📥 Pulling existing image: $($imageInfo.source)"
        docker pull $imageInfo.source
        if ($LASTEXITCODE -ne 0) {
            Write-Error "❌ Docker pull failed for $($imageInfo.source)."
            exit 1
        }

        Write-Host "🏷️ Tagging image with semantic version: $dockerTag"
        docker tag $imageInfo.source $imageInfo.target
        if ($LASTEXITCODE -ne 0) {
            Write-Error "❌ Docker tag failed for $($imageInfo.target)."
            exit 1
        }

        Write-Host "🏷️ Tagging image with major version: v$newMajor"
        docker tag $imageInfo.source $imageInfo.majorTag
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "⚠️ Docker tag failed for major version $($imageInfo.majorTag)"
        }

        Write-Host "🏷️ Tagging image with minor version: v$newMajor.$newMinor"
        docker tag $imageInfo.source $imageInfo.minorTag
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "⚠️ Docker tag failed for minor version $($imageInfo.minorTag)"
        }

        Write-Host "📤 Pushing semantic versioned image: $($imageInfo.target)"
        docker push $imageInfo.target
        if ($LASTEXITCODE -ne 0) {
            Write-Error "❌ Docker push failed for $($imageInfo.target)."
            exit 1
        }

        Write-Host "📤 Pushing major version tag: $($imageInfo.majorTag)"
        docker push $imageInfo.majorTag
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "⚠️ Docker push failed for major version $($imageInfo.majorTag)"
        }

        Write-Host "📤 Pushing minor version tag: $($imageInfo.minorTag)"
        docker push $imageInfo.minorTag
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "⚠️ Docker push failed for minor version $($imageInfo.minorTag)"
        }
    }
}

Write-Host "`n✅ Successfully tagged and pushed semantic versioned Docker images!"
Write-Host ""
Write-Host "� Final Summary:"
Write-Host "   Semantic version: $nextVersion"
Write-Host "   Prerelease: $prereleaseVersion"
Write-Host "   Docker tags: $dockerTag, v$newMajor, v$newMajor.$newMinor"
Write-Host "   Processed $($processedImages.Count) images:"
foreach ($imageInfo in $processedImages) {
    Write-Host "     - $($imageInfo.target)"
}
Write-Host ""
Write-Host "📤 GitHub Action Outputs:"
Write-Host "   prerelease-version = $prereleaseVersion"
Write-Host "   image-prerelease-urls = $prereleaseImageUrlsJson"