# Generate Prerelease Version Action# Generate Prerelease Version Action



[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)

[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)



A GitHub Action that automatically generates semantic prerelease versions by incrementing the patch version from the latest git tags.A GitHub Action that automatically generates semantic prerelease versions by incrementing the patch version from the latest git tags.



## Features## Features



- 🏷️ **Automatic Semantic Versioning**: Generates semantic versions by incrementing patch version from the latest git tags- 🏷️ **Automatic Semantic Versioning**: Generates semantic versions by incrementing patch version from the latest git tags

- 🚀 **Prerelease Support**: Adds customizable prerelease suffixes (rc, alpha, beta, etc.)- � **Prerelease Support**: Adds customizable prerelease suffixes (rc, alpha, beta, etc.)

- 📋 **Git Tag Integration**: Scans existing git tags to determine the next version- � **Git Tag Integration**: Scans existing git tags to determine the next version

- ⚡ **Lightweight**: Fast execution with minimal dependencies- ⚡ **Lightweight**: Fast execution with minimal dependencies

- 🔧 **Configurable**: Customizable prerelease suffix- 🔧 **Configurable**: Customizable prerelease suffix



## Usage## Usage



### Basic Usage### Basic Usage



```yaml```yaml

name: Generate Prerelease Versionname: Generate Prerelease Version

on:on:

  push:  push:

    branches: [main]    branches: [main]



jobs:jobs:

  version:  version:

    runs-on: ubuntu-latest    runs-on: ubuntu-latest

    steps:    steps:

      - name: Checkout      - name: Checkout

        uses: actions/checkout@v4        uses: actions/checkout@v4

        with:        with:

          fetch-depth: 0  # Required for git tag operations          fetch-depth: 0  # Required for git tag operations

                    

      - name: Generate prerelease version      - name: Generate prerelease version

        id: version        id: version

        uses: optivem/generate-prerelease-version-action@v1        uses: optivem/generate-prerelease-version-action@v1

        with:        with:

          suffix: 'rc'  # Optional, defaults to 'rc'          suffix: 'rc'  # Optional, defaults to 'rc'

                    

      - name: Use the version      - name: Use the version

        run: echo "Generated version: ${{ steps.version.outputs.version }}"        run: echo "Generated version: ${{ steps.version.outputs.version }}"

``````



### Different Prerelease Suffixes### Different Prerelease Suffixes



```yaml```yaml

- name: Generate alpha version- name: Generate alpha version

  id: alpha  id: alpha

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

  with:  with:

    suffix: 'alpha'    suffix: 'alpha'



- name: Generate beta version  - name: Generate beta version  

  id: beta  id: beta

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

  with:  with:

    suffix: 'beta'    suffix: 'beta'



- name: Generate release candidate- name: Generate release candidate

  id: rc  id: rc

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

  with:  with:

    suffix: 'rc'    suffix: 'rc'

``````

  uses: optivem/generate-prerelease-version-action@v1

### Using the Generated Version  with:

    image-urls: '["ghcr.io/${{ github.repository }}/frontend:latest", "ghcr.io/${{ github.repository }}/api:latest", "ghcr.io/${{ github.repository }}/worker:latest"]'

```yaml```

- name: Generate prerelease version

  id: version### Single Image Usage

  uses: optivem/generate-prerelease-version-action@v1

```yaml

- name: Create GitHub Release- name: Version and tag Docker image

  uses: actions/create-release@v1  uses: optivem/generate-prerelease-version-action@v1

  with:  with:

    tag_name: ${{ steps.version.outputs.version }}    image-urls: 'ghcr.io/${{ github.repository }}/my-app:latest'

    release_name: ${{ steps.version.outputs.version }}```

    prerelease: true

### Mixed Registries and Formats

- name: Update package.json

  run: |```yaml

    npm version ${{ steps.version.outputs.version }} --no-git-tag-version- name: Version and tag Docker images

  uses: optivem/generate-prerelease-version-action@v1

- name: Docker build and tag  with:

  run: |    image-urls: |

    docker build -t myapp:${{ steps.version.outputs.version }} .      # GHCR images with tags

    docker push myapp:${{ steps.version.outputs.version }}      ghcr.io/org/frontend:latest

```      ghcr.io/org/backend:v2.1.0

      

## Inputs      # Docker Hub with digest

      docker.io/username/service@sha256:abc123def456

| Input | Description | Required | Default |      

|-------|-------------|----------|---------|      # Azure Container Registry

| `suffix` | Prerelease suffix (e.g., rc, alpha, beta) | ❌ | `rc` |      myregistry.azurecr.io/team/api:latest

    registry-token: ${{ secrets.MULTI_REGISTRY_TOKEN }}

## Outputs    registry-username: ${{ github.actor }}

```

| Output | Description | Example |

|--------|-------------|---------|### Docker Hub Usage (Newline Format)

| `version` | The generated prerelease version | `v1.2.4-rc` |

```yaml

## How It Works- name: Version and tag Docker images

  uses: optivem/generate-prerelease-version-action@v1

1. **Scans Git Tags**: Finds the latest semantic version tag (v*.*.*)  with:

2. **Increments Patch**: Automatically bumps the patch version (e.g., v1.2.3 → v1.2.4)    image-urls: |

3. **Adds Suffix**: Appends the prerelease suffix (e.g., v1.2.4-rc)      docker.io/username/frontend:latest

4. **Sets Output**: Makes the version available as a GitHub Actions output      docker.io/username/backend:latest

    registry-token: ${{ secrets.DOCKER_TOKEN }}

### Version Examples    registry-username: 'username'  # Your Docker Hub username

```

| Latest Git Tag | Generated Version | Description |

|---------------|-------------------|-------------|### Docker Hub Usage (JSON Format)

| (no tags) | `v0.0.1-rc` | Starts from v0.0.0 |

| `v1.0.0` | `v1.0.1-rc` | Increments patch |```yaml

| `v2.5.10` | `v2.5.11-rc` | Increments patch |- name: Version and tag Docker images

| `v1.0.0-beta` | `v1.0.1-rc` | Increments from prerelease |  uses: optivem/generate-prerelease-version-action@v1

  with:

## Prerequisites    image-urls: '["docker.io/username/frontend:latest", "docker.io/username/backend:latest"]'

    registry-token: ${{ secrets.DOCKER_TOKEN }}

- Repository must be checked out with `fetch-depth: 0` to access git tags    registry-username: 'username'  # Your Docker Hub username

- Repository may optionally have semantic version git tags (v1.0.0 format)```



## Common Workflows### Azure Container Registry Usage



### 1. Continuous Prerelease```yaml

- name: Version and tag Docker images

```yaml  uses: optivem/generate-prerelease-version-action@v1

name: Continuous Prerelease  with:

on:    image-urls: |

  push:      myregistry.azurecr.io/team/frontend:latest

    branches: [main]      myregistry.azurecr.io/team/backend:latest

    registry-token: ${{ secrets.ACR_TOKEN }}

jobs:    registry-username: ${{ secrets.ACR_USERNAME }}  # ACR username

  prerelease:```

    runs-on: ubuntu-latest

    steps:### AWS ECR Usage

      - uses: actions/checkout@v4

        with:```yaml

          fetch-depth: 0- name: Version and tag Docker images

            uses: optivem/generate-prerelease-version-action@v1

      - name: Generate version  with:

        id: version    image-urls: |

        uses: optivem/generate-prerelease-version-action@v1      123456789.dkr.ecr.us-east-1.amazonaws.com/frontend:latest

              123456789.dkr.ecr.us-east-1.amazonaws.com/backend:latest

      - name: Create prerelease    registry-token: ${{ secrets.ECR_TOKEN }}

        uses: actions/create-release@v1    registry-username: 'AWS'  # ECR uses 'AWS' as username

        with:```

          tag_name: ${{ steps.version.outputs.version }}

          release_name: ${{ steps.version.outputs.version }}### Advanced Usage with Digest

          prerelease: true

        env:```yaml

          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}name: Create Prerelease with Digest

```on:

  workflow_run:

### 2. Multi-Stage Releases    workflows: ["Build and Test"]

    types: [completed]

```yaml    branches: [main]

name: Multi-Stage Release

on:jobs:

  workflow_dispatch:  prerelease:

    inputs:    if: ${{ github.event.workflow_run.conclusion == 'success' }}

      stage:    runs-on: ubuntu-latest

        description: 'Release stage'    steps:

        required: true      - name: Checkout

        default: 'rc'        uses: actions/checkout@v4

        type: choice        with:

        options:          fetch-depth: 0

        - alpha          

        - beta      - name: Get build digest

        - rc        # ... steps to get the digest from the build workflow

        

jobs:      - name: Version and tag Docker image

  release:        uses: optivem/generate-prerelease-version-action@v1

    runs-on: ubuntu-latest        with:

    steps:          image-url: 'ghcr.io/${{ github.repository }}/my-app@${{ steps.get-digest.outputs.digest }}'

      - uses: actions/checkout@v4          prerelease-suffix: 'rc'

        with:```

          fetch-depth: 0

          ## Input Formats

      - name: Generate ${{ github.event.inputs.stage }} version

        id: versionThe `image-urls` input supports two formats for maximum flexibility:

        uses: optivem/generate-prerelease-version-action@v1

        with:### Format 1: Newline-separated (Recommended)

          suffix: ${{ github.event.inputs.stage }}

          ```yaml

      - name: Build and releaseimage-urls: |

        run: |  # Frontend services

          echo "Building version: ${{ steps.version.outputs.version }}"  ghcr.io/org/frontend:latest

          # Your build steps here  ghcr.io/org/admin:latest

```  

  # Backend services

### 3. Version-based Docker Tagging  ghcr.io/org/api:latest

  docker.io/user/worker:v1.0.0

```yaml```

name: Docker Build and Push

on:**Benefits:**

  push:- ✅ Easy to read and edit

    branches: [main]- ✅ Supports comments with `#`

- ✅ Natural YAML formatting

jobs:- ✅ Less error-prone

  docker:

    runs-on: ubuntu-latest### Format 2: JSON Array

    steps:

      - uses: actions/checkout@v4```yaml

        with:image-urls: '["ghcr.io/org/frontend:latest", "ghcr.io/org/api:latest", "docker.io/user/worker:v1.0.0"]'

          fetch-depth: 0```

          

      - name: Generate version**Benefits:**

        id: version- ✅ Programmatic generation friendly

        uses: optivem/generate-prerelease-version-action@v1- ✅ Compact for single line

        - ✅ Familiar JSON syntax

      - name: Build and push Docker image

        run: |## Inputs

          VERSION=${{ steps.version.outputs.version }}

          docker build -t ghcr.io/${{ github.repository }}:$VERSION .| Input | Description | Required | Default |

          docker push ghcr.io/${{ github.repository }}:$VERSION|-------|-------------|----------|---------|

```| `image-urls` | List of Docker image URLs. Supports newline-separated format (with `#` comments) or JSON array format: `["url1", "url2"]` | ✅ | - |

| `registry-token` | Token for registry authentication (GitHub token for GHCR, Docker token for Docker Hub, etc.) | ✅ | `${{ github.token }}` |

## Troubleshooting| `registry-username` | Username for registry authentication (github.actor for GHCR, Docker Hub username, etc.) | ❌ | `${{ github.actor }}` |

| `prerelease-suffix` | Prerelease suffix (e.g., rc, alpha, beta) | ❌ | `rc` |

### No semantic version tags found

If you see "No existing semantic version tags found", the action will start with v0.0.0. To set a specific starting point:## Outputs



```bash| Output | Description | Example |

git tag v1.0.0|--------|-------------|---------|

git push origin v1.0.0| `prerelease-version` | The prerelease version | `v1.2.3-rc` |

```| `image-prerelease-urls` | JSON array of prerelease image URLs | `["ghcr.io/org/app:v1.2.3-rc", "ghcr.io/org/api:v1.2.3-rc"]` |



### Git fetch depth### Using Outputs in Workflows

Ensure your checkout step includes `fetch-depth: 0`:

```yaml

```yaml- name: Version and tag Docker images

- uses: actions/checkout@v4  id: version

  with:  uses: optivem/generate-prerelease-version-action@v1

    fetch-depth: 0  # Required to access git tags  with:

```    image-urls: |

      ghcr.io/${{ github.repository }}/frontend:latest

### Invalid tag format      ghcr.io/${{ github.repository }}/api:latest

The action expects semantic version tags in the format `v1.2.3`. Tags like `1.2.3` (without 'v') or `release-1.2.3` are not supported.

- name: Deploy to staging

## License  run: |

    echo "Deploying version: ${{ steps.version.outputs.prerelease-version }}"

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.    echo "Tagged images:"

    echo '${{ steps.version.outputs.image-prerelease-urls }}' | jq -r '.[]'

## Contributing

- name: Update Helm chart

Contributions are welcome! Please feel free to submit a Pull Request.  run: |
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
      - uses: optivem/generate-prerelease-version-action@v1
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
      - uses: optivem/generate-prerelease-version-action@v1
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
