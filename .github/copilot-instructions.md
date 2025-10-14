# GitHub Action: Semantic Version Docker Prerelease

## Architecture Overview

This is a GitHub Action that automatically generates semantic versions and retags existing Docker images with prerelease tags. The core workflow is:

1. **Parse image URLs** (supports both newline-separated and JSON array formats)
2. **Generate semantic version** by incrementing patch from latest git tag (v*.*.*)
3. **Retag existing Docker images** without rebuilding
4. **Push multiple tag variants** (prerelease, major, minor)
5. **Create GitHub prerelease** with tagged images

## Key Components

- `action.yml`: Composite action definition with PowerShell execution
- `action.ps1`: Core logic for version generation, Docker operations, and multi-registry support
- `test.ps1`: Comprehensive testing script with multiple modes (parse-only, validate, full)

## Critical Patterns

### Input Format Flexibility
The action supports two distinct input formats for `image-urls`:

```yaml
# Newline-separated (with comments)
image-urls: |
  # Frontend services
  ghcr.io/org/frontend:latest
  ghcr.io/org/api:latest
  
# JSON array
image-urls: '["ghcr.io/org/frontend:latest", "ghcr.io/org/api:latest"]'
```

**Implementation**: action.ps1 tries JSON parsing first, falls back to newline splitting with comment filtering.

### URL Parsing Logic
Images must include tag OR digest - no fallback to `:latest`:

```powershell
# Matches: ghcr.io/repo/image@sha256:abc123
if ($ImageUrl -match "^(.+)@(sha256:[a-f0-9]{64})$") {
    $baseImageUrl = $matches[1]
    $sourceImage = $ImageUrl
}
# Matches: ghcr.io/repo/image:latest
elseif ($ImageUrl -match "^(.+):([^@]+)$") {
    $baseImageUrl = $matches[1]
    $sourceImage = $ImageUrl
}
```

### Version Generation Strategy
- Always increments patch version from latest semantic tag
- No support for major/minor bumps (design decision)
- Handles both stable and prerelease source tags
- Pattern: `v1.2.3` → `v1.2.4-rc`

### Multi-Registry Authentication
Registry detection from URL first segment:
- `docker.io` or no-dot domains → Docker Hub (omit registry in login)
- Others (GHCR, ACR, ECR) → Include registry host in login

## Development Workflows

### Testing Strategy
Use `test.ps1` with different modes:
```powershell
# Quick validation (no Docker operations)
.\test.ps1 -TestMode quick

# Structure validation only
.\test.ps1 -TestMode validate

# Full test with mocked Docker
.\test.ps1 -TestMode full -MockDocker $true

# Test JSON format instead of newline
.\test.ps1 -TestJsonFormat
```

### Debugging Docker Issues
Set `$env:MOCK_DOCKER = "true"` to bypass actual Docker operations and test parsing/versioning logic.

### Version Tag Prerequisites
Requires semantic version git tags (v*.*.* format). Create initial tag if none exist:
```bash
git tag v0.1.0 && git push origin v0.1.0
```

## Breaking Changes Pattern

Recent v1.1.0 introduced breaking changes by consolidating parameters:
- `image-name` + `source-digest` → single `image-url` 
- `github-token` → `registry-token` (generic registry support)
- Removed automatic `:latest` fallback

## Error Handling

- **Invalid URL format**: Must include tag/digest, clear error messages
- **Docker failures**: Exit with specific error codes and debug context
- **Registry authentication**: Per-registry error handling with troubleshooting hints
- **Missing git tags**: Graceful fallback to v0.0.0

## Output Format

Always returns JSON array for `image-prerelease-urls` (even single image):
```powershell
if ($targetImagesList.Count -eq 1) {
    $prereleaseImageUrlsJson = "[$($targetImagesList[0] | ConvertTo-Json)]"
} else {
    $prereleaseImageUrlsJson = $targetImagesList | ConvertTo-Json -Compress
}
```

## Testing Integration

The `.github/workflows/test.yml` validates:
- Action YAML structure and required inputs
- PowerShell script syntax and parameter existence
- URL parsing regex patterns
- Documentation consistency (no old parameter references)

When modifying core logic, ensure `test.ps1` covers the change with appropriate test modes.