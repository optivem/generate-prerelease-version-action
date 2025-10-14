# Semantic Version Docker Prerelease Action

[![test](https://github.com/optivem/prerelease-docker-images-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/prerelease-docker-images-action/actions/workflows/test.yml)
[![release](https://github.com/optivem/prerelease-docker-images-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/prerelease-docker-images-action/actions/workflows/release.yml)

A GitHub Action that automatically generates semantic versions, retags existing Docker images, and pushes them to container registries with prerelease tags.

## Features

- 🏷️ **Automatic Semantic Versioning**: Generates semantic versions by incrementing patch version from the latest git tags
- 🐳 **Docker Image Retagging**: Retags existing Docker images without rebuilding
- 📦 **Multiple Tag Formats**: Creates prerelease, major, and minor version tags
- 🔒 **Registry Agnostic**: Works with GHCR, Docker Hub, ACR, ECR, and private registries
- 🎯 **Precise Source Targeting**: Use exact image URLs with tags or digests

## Usage

### Basic Usage - GitHub Container Registry (Newline Format)

```yaml
name: Create Prerelease
on:
  push:
    branches: [main]

jobs:
  prerelease:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Required for git tag operations
          
      - name: Version and tag Docker images
        uses: optivem/prerelease-docker-images-action@v1
        with:
          image-urls: |
            # Frontend services
            ghcr.io/${{ github.repository }}/frontend:latest
            ghcr.io/${{ github.repository }}/admin-ui:latest
            
            # Backend services  
            ghcr.io/${{ github.repository }}/api:latest
            ghcr.io/${{ github.repository }}/worker:latest
```

### Basic Usage - GitHub Container Registry (JSON Format)

```yaml
- name: Version and tag Docker images (JSON format)
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: '["ghcr.io/${{ github.repository }}/frontend:latest", "ghcr.io/${{ github.repository }}/api:latest", "ghcr.io/${{ github.repository }}/worker:latest"]'
```

### Single Image Usage

```yaml
- name: Version and tag Docker image
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: 'ghcr.io/${{ github.repository }}/my-app:latest'
```

### Mixed Registries and Formats

```yaml
- name: Version and tag Docker images
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: |
      # GHCR images with tags
      ghcr.io/org/frontend:latest
      ghcr.io/org/backend:v2.1.0
      
      # Docker Hub with digest
      docker.io/username/service@sha256:abc123def456
      
      # Azure Container Registry
      myregistry.azurecr.io/team/api:latest
    registry-token: ${{ secrets.MULTI_REGISTRY_TOKEN }}
    registry-username: ${{ github.actor }}
```

### Docker Hub Usage (Newline Format)

```yaml
- name: Version and tag Docker images
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: |
      docker.io/username/frontend:latest
      docker.io/username/backend:latest
    registry-token: ${{ secrets.DOCKER_TOKEN }}
    registry-username: 'username'  # Your Docker Hub username
```

### Docker Hub Usage (JSON Format)

```yaml
- name: Version and tag Docker images
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: '["docker.io/username/frontend:latest", "docker.io/username/backend:latest"]'
    registry-token: ${{ secrets.DOCKER_TOKEN }}
    registry-username: 'username'  # Your Docker Hub username
```

### Azure Container Registry Usage

```yaml
- name: Version and tag Docker images
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: |
      myregistry.azurecr.io/team/frontend:latest
      myregistry.azurecr.io/team/backend:latest
    registry-token: ${{ secrets.ACR_TOKEN }}
    registry-username: ${{ secrets.ACR_USERNAME }}  # ACR username
```

### AWS ECR Usage

```yaml
- name: Version and tag Docker images
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: |
      123456789.dkr.ecr.us-east-1.amazonaws.com/frontend:latest
      123456789.dkr.ecr.us-east-1.amazonaws.com/backend:latest
    registry-token: ${{ secrets.ECR_TOKEN }}
    registry-username: 'AWS'  # ECR uses 'AWS' as username
```

### Advanced Usage with Digest

```yaml
name: Create Prerelease with Digest
on:
  workflow_run:
    workflows: ["Build and Test"]
    types: [completed]
    branches: [main]

jobs:
  prerelease:
    if: ${{ github.event.workflow_run.conclusion == 'success' }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          
      - name: Get build digest
        # ... steps to get the digest from the build workflow
        
      - name: Version and tag Docker image
        uses: optivem/prerelease-docker-images-action@v1
        with:
          image-url: 'ghcr.io/${{ github.repository }}/my-app@${{ steps.get-digest.outputs.digest }}'
          prerelease-suffix: 'rc'
```

## Input Formats

The `image-urls` input supports two formats for maximum flexibility:

### Format 1: Newline-separated (Recommended)

```yaml
image-urls: |
  # Frontend services
  ghcr.io/org/frontend:latest
  ghcr.io/org/admin:latest
  
  # Backend services
  ghcr.io/org/api:latest
  docker.io/user/worker:v1.0.0
```

**Benefits:**
- ✅ Easy to read and edit
- ✅ Supports comments with `#`
- ✅ Natural YAML formatting
- ✅ Less error-prone

### Format 2: JSON Array

```yaml
image-urls: '["ghcr.io/org/frontend:latest", "ghcr.io/org/api:latest", "docker.io/user/worker:v1.0.0"]'
```

**Benefits:**
- ✅ Programmatic generation friendly
- ✅ Compact for single line
- ✅ Familiar JSON syntax

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `image-urls` | List of Docker image URLs. Supports newline-separated format (with `#` comments) or JSON array format: `["url1", "url2"]` | ✅ | - |
| `registry-token` | Token for registry authentication (GitHub token for GHCR, Docker token for Docker Hub, etc.) | ✅ | `${{ github.token }}` |
| `registry-username` | Username for registry authentication (github.actor for GHCR, Docker Hub username, etc.) | ❌ | `${{ github.actor }}` |
| `prerelease-suffix` | Prerelease suffix (e.g., rc, alpha, beta) | ❌ | `rc` |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `prerelease-version` | The prerelease version | `v1.2.3-rc` |
| `image-prerelease-urls` | JSON array of prerelease image URLs | `["ghcr.io/org/app:v1.2.3-rc", "ghcr.io/org/api:v1.2.3-rc"]` |

### Using Outputs in Workflows

```yaml
- name: Version and tag Docker images
  id: version
  uses: optivem/prerelease-docker-images-action@v1
  with:
    image-urls: |
      ghcr.io/${{ github.repository }}/frontend:latest
      ghcr.io/${{ github.repository }}/api:latest

- name: Deploy to staging
  run: |
    echo "Deploying version: ${{ steps.version.outputs.prerelease-version }}"
    echo "Tagged images:"
    echo '${{ steps.version.outputs.image-prerelease-urls }}' | jq -r '.[]'

- name: Update Helm chart
  run: |
    # Update Helm values with the new prerelease version
    yq eval '.image.tag = "${{ steps.version.outputs.prerelease-version }}"' -i values.yaml
    
- name: Process each image
  run: |
    # Parse JSON array and process each image
    echo '${{ steps.version.outputs.image-prerelease-urls }}' | jq -r '.[]' | while read image; do
      echo "Processing: $image"
      # Deploy or process each image individually
    done

- name: Update deployment manifests
  run: |
    # Use jq to extract specific images
    FRONTEND_IMAGE=$(echo '${{ steps.version.outputs.image-prerelease-urls }}' | jq -r '.[] | select(contains("frontend"))')
    API_IMAGE=$(echo '${{ steps.version.outputs.image-prerelease-urls }}' | jq -r '.[] | select(contains("api"))')
    
    echo "Frontend: $FRONTEND_IMAGE"
    echo "API: $API_IMAGE"
```
| `docker_image` | The full Docker image name with registry and tag | `ghcr.io/owner/repo/image:v1.2.3-rc.1` |

## How It Works

1. **Parses Image URL**: Extracts base URL and source tag/digest from the provided image URL
2. **Fetches Latest Version**: Scans git tags to find the latest semantic version (v*.*.*)
3. **Increments Patch**: Automatically bumps the patch version (e.g., v1.2.3 → v1.2.4)
4. **Creates Prerelease**: Adds prerelease suffix (e.g., v1.2.4-rc)
5. **Tags Docker Image**: Retags existing image with new version
6. **Pushes Multiple Tags**: Pushes semantic version, major, and minor tags

### Input Examples

| Input | Source Image | Generated Tags |
|-------|--------------|----------------|
| `ghcr.io/org/app:latest` | `ghcr.io/org/app:latest` | `v1.2.4-rc`, `v1`, `v1.2` |
| `ghcr.io/org/app@sha256:abc123` | `ghcr.io/org/app@sha256:abc123` | `v1.2.4-rc`, `v1`, `v1.2` |
| `docker.io/user/app:v1.0.0` | `docker.io/user/app:v1.0.0` | `v1.2.4-rc`, `v1`, `v1.2` |

### Tag Examples

For input `ghcr.io/owner/repo/service:latest` and generated version `v1.2.4-rc`, the action creates:
- `ghcr.io/owner/repo/service:v1.2.4-rc` (prerelease)
- `ghcr.io/owner/repo/service:v1` (major)
- `ghcr.io/owner/repo/service:v1.2` (minor)

## Prerequisites

- Docker image must already exist in the specified container registry
- Repository must have semantic version git tags (v1.0.0 format)
- `fetch-depth: 0` required in checkout step for git tag operations
- Appropriate registry authentication token with push permissions

## Common Workflows

### 1. Build → Test → Prerelease

```yaml
name: CI/CD Pipeline
on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      digest: ${{ steps.build.outputs.digest }}
    steps:
      - uses: actions/checkout@v4
      - name: Build and push
        id: build
        # ... build steps that output digest
        
  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Test image
        run: |
          docker run --rm ghcr.io/${{ github.repository }}/app@${{ needs.build.outputs.digest }} test
          
  prerelease:
    needs: [build, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: optivem/prerelease-docker-images-action@v1
        with:
          image-url: 'ghcr.io/${{ github.repository }}/app@${{ needs.build.outputs.digest }}'
```

### 2. Multiple Images

```yaml
jobs:
  prerelease:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        image: [frontend, backend, worker]
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: optivem/prerelease-docker-images-action@v1
        with:
          image-url: 'ghcr.io/${{ github.repository }}/${{ matrix.image }}:latest'
          prerelease-suffix: 'rc'
```

## Troubleshooting

### No semantic version tags found
If you see "No existing semantic version tags found", create an initial tag:
```bash
git tag v0.1.0
git push origin v0.1.0
```

### Docker pull fails
Ensure the source image exists and is accessible:
- Check image URL format and registry
- Verify registry token permissions
- Confirm tag or digest is correct

### Invalid image URL format
The action requires a complete image URL with tag or digest:
- ✅ `ghcr.io/owner/repo/service:latest`
- ✅ `ghcr.io/owner/repo/service@sha256:abc123`
- ❌ `ghcr.io/owner/repo/service` (missing tag/digest)

### Permission denied
Ensure registry token has necessary permissions:
```yaml
permissions:
  contents: read
  packages: write
```

For non-GHCR registries, ensure the token has appropriate push permissions for the target registry.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
