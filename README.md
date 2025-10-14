# Generate Prerelease Version# Generate Prerelease Version Action# Generate Prerelease Version Action# Generate Prerelease Version Action# Generate Prerelease Version Action



GitHub Action that creates semantic prerelease versions.



## UsageA simple GitHub Action that generates semantic prerelease versions by incrementing the patch version from your latest git tags.



```yaml

- uses: optivem/generate-prerelease-version-action@v1

  id: version## Usage[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)

  with:

    suffix: 'rc'

```

```yaml[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)

## What it does

- name: Generate prerelease version

- Finds your latest git tag (like `v1.2.3`)

- Adds 1 to the patch number (`v1.2.4`)  id: version[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)

- Adds your suffix (`v1.2.4-rc`)

  uses: optivem/generate-prerelease-version-action@v1

## Inputs

  with:A simple GitHub Action that generates semantic prerelease versions by incrementing the patch version from your latest git tags.

- `suffix` - What to add at the end (default: `rc`)

    suffix: 'rc'  # Optional, defaults to 'rc'

## Outputs

[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)

- `version` - The new version string

- name: Use the version

## Example

  run: echo "Version: ${{ steps.version.outputs.version }}"## What it does

```yaml

name: Make Version```

on: push



jobs:

  version:## What it does

    runs-on: ubuntu-latest

    steps:1. **Finds your latest semantic version tag** (e.g., `v1.2.3`)

      - uses: actions/checkout@v4

        with:1. Scans your repository for the latest semantic version tag (e.g., `v1.2.3`)

          fetch-depth: 0

      2. Increments the patch version (e.g., `v1.2.3` → `v1.2.4`)  2. **Increments the patch version** (e.g., `v1.2.3` → `v1.2.4`)A GitHub Action that automatically generates semantic prerelease versions by incrementing the patch version from the latest git tags.A GitHub Action that automatically generates semantic prerelease versions by incrementing the patch version from the latest git tags.

      - uses: optivem/generate-prerelease-version-action@v1

        id: version3. Adds your specified prerelease suffix (e.g., `v1.2.4-rc`)

        with:

          suffix: 'beta'4. Outputs the new version for use in your workflow3. **Adds a prerelease suffix** (e.g., `v1.2.4-rc`)

      

      - run: echo ${{ steps.version.outputs.version }}

```

## Inputs4. **Outputs the version** for use in your workflow

## Requirements



- Use `fetch-depth: 0` in checkout

- Git tags should be like `v1.2.3`| Input | Description | Required | Default |

|-------|-------------|----------|---------|

| `suffix` | Prerelease suffix to append (e.g., `rc`, `alpha`, `beta`) | No | `rc` |## Quick Start## Features## Features



## Outputs



| Output | Description | Example |```yaml

|--------|-------------|---------|

| `version` | The generated prerelease version | `v1.2.4-rc` |- name: Generate prerelease version



## Example Workflows  id: version- 🏷️ **Automatic Semantic Versioning**: Generates semantic versions by incrementing patch version from the latest git tags- 🏷️ **Automatic Semantic Versioning**: Generates semantic versions by incrementing patch version from the latest git tags



### Basic Usage  uses: optivem/generate-prerelease-version-action@v1



```yaml  - 🚀 **Prerelease Support**: Adds customizable prerelease suffixes (rc, alpha, beta, etc.)- � **Prerelease Support**: Adds customizable prerelease suffixes (rc, alpha, beta, etc.)

name: Generate Prerelease

on:- name: Use the version

  push:

    branches: [main]  run: echo "Version: ${{ steps.version.outputs.version }}"- 📋 **Git Tag Integration**: Scans existing git tags to determine the next version- � **Git Tag Integration**: Scans existing git tags to determine the next version



jobs:```

  version:

    runs-on: ubuntu-latest- ⚡ **Lightweight**: Fast execution with minimal dependencies- ⚡ **Lightweight**: Fast execution with minimal dependencies

    steps:

      - name: Checkout## Usage

        uses: actions/checkout@v4

        with:- 🔧 **Configurable**: Customizable prerelease suffix- 🔧 **Configurable**: Customizable prerelease suffix

          fetch-depth: 0  # Required for git tag access

          ### Basic Example

      - name: Generate prerelease version

        id: version

        uses: optivem/generate-prerelease-version-action@v1

        ```yaml

      - name: Display version

        run: echo "Generated: ${{ steps.version.outputs.version }}"name: Generate Version## Usage## Usage

```

on:

### Create GitHub Release

  push:

```yaml

name: Create Prerelease    branches: [main]

on:

  push:### Basic Usage### Basic Usage

    branches: [main]

jobs:

jobs:

  release:  version:

    runs-on: ubuntu-latest

    steps:    runs-on: ubuntu-latest

      - name: Checkout

        uses: actions/checkout@v4    steps:```yaml```yaml

        with:

          fetch-depth: 0      - uses: actions/checkout@v4

          

      - name: Generate version        with:name: Generate Prerelease Versionname: Generate Prerelease Version

        id: version

        uses: optivem/generate-prerelease-version-action@v1          fetch-depth: 0  # Required for git tag access

        with:

          suffix: 'rc'          on:on:

          

      - name: Create GitHub Release      - name: Generate prerelease version

        uses: actions/create-release@v1

        with:        id: version  push:  push:

          tag_name: ${{ steps.version.outputs.version }}

          release_name: Release ${{ steps.version.outputs.version }}        uses: optivem/generate-prerelease-version-action@v1

          prerelease: true

        env:            branches: [main]    branches: [main]

          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```      - name: Show version



### Multiple Prerelease Types        run: echo "Generated: ${{ steps.version.outputs.version }}"



```yaml```

- name: Generate alpha version

  id: alphajobs:jobs:

  uses: optivem/generate-prerelease-version-action@v1

  with:### Custom Suffix

    suffix: 'alpha'

  version:  version:

- name: Generate beta version

  id: beta  ```yaml

  uses: optivem/generate-prerelease-version-action@v1

  with:- name: Generate alpha version    runs-on: ubuntu-latest    runs-on: ubuntu-latest

    suffix: 'beta'

  uses: optivem/generate-prerelease-version-action@v1

- name: Generate release candidate

  id: rc  with:    steps:    steps:

  uses: optivem/generate-prerelease-version-action@v1

  with:    suffix: 'alpha'  # Outputs: v1.2.4-alpha

    suffix: 'rc'

```      - name: Checkout      - name: Checkout



## Version Examples- name: Generate beta version



| Latest Git Tag | Generated Version | Notes |  uses: optivem/generate-prerelease-version-action@v1        uses: actions/checkout@v4        uses: actions/checkout@v4

|---------------|------------------|-------|

| *(no tags)* | `v0.0.1-rc` | Starts from v0.0.0 |  with:

| `v1.0.0` | `v1.0.1-rc` | Increments patch |

| `v2.5.10` | `v2.5.11-rc` | Increments patch |    suffix: 'beta'   # Outputs: v1.2.4-beta        with:        with:

| `v1.0.0-beta` | `v1.0.1-rc` | Ignores existing prerelease suffix |

```

## Requirements

          fetch-depth: 0  # Required for git tag operations          fetch-depth: 0  # Required for git tag operations

- Repository must be checked out with `fetch-depth: 0` to access git tag history

- Git tags should follow semantic versioning: `v1.2.3` (with `v` prefix)### Real-world Example: Create GitHub Release



## Common Use Cases                    



- **Continuous Integration**: Generate unique versions for every build```yaml

- **Docker Tagging**: Tag container images with prerelease versions  

- **Package Publishing**: Publish prerelease packages to registriesname: Create Prerelease      - name: Generate prerelease version      - name: Generate prerelease version

- **Release Automation**: Automate prerelease creation in CI/CD pipelines

on:

## License

  push:        id: version        id: version

[MIT](LICENSE)

    branches: [main]

## Contributing

        uses: optivem/generate-prerelease-version-action@v1        uses: optivem/generate-prerelease-version-action@v1

Issues and pull requests are welcome!
jobs:

  release:        with:        with:

    runs-on: ubuntu-latest

    steps:          suffix: 'rc'  # Optional, defaults to 'rc'          suffix: 'rc'  # Optional, defaults to 'rc'

      - uses: actions/checkout@v4

        with:                    

          fetch-depth: 0

                - name: Use the version      - name: Use the version

      - name: Generate version

        id: version        run: echo "Generated version: ${{ steps.version.outputs.version }}"        run: echo "Generated version: ${{ steps.version.outputs.version }}"

        uses: optivem/generate-prerelease-version-action@v1

        with:``````

          suffix: 'rc'

          

      - name: Create GitHub Release

        uses: actions/create-release@v1### Different Prerelease Suffixes### Different Prerelease Suffixes

        with:

          tag_name: ${{ steps.version.outputs.version }}

          release_name: Release ${{ steps.version.outputs.version }}

          prerelease: true```yaml```yaml

        env:

          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}- name: Generate alpha version- name: Generate alpha version

```

  id: alpha  id: alpha

## Inputs

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

| Input | Description | Required | Default |

|-------|-------------|----------|---------|  with:  with:

| `suffix` | Prerelease suffix (e.g., `rc`, `alpha`, `beta`) | No | `rc` |

    suffix: 'alpha'    suffix: 'alpha'

## Outputs



| Output | Description | Example |

|--------|-------------|---------|- name: Generate beta version  - name: Generate beta version  

| `version` | The generated prerelease version | `v1.2.4-rc` |

  id: beta  id: beta

## How Version Generation Works

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

| Your Latest Git Tag | Generated Version | Explanation |

|-------------------|------------------|-------------|  with:  with:

| *(no tags)* | `v0.0.1-rc` | Starts from v0.0.0, increments to v0.0.1 |

| `v1.0.0` | `v1.0.1-rc` | Increments patch: 1.0.0 → 1.0.1 |    suffix: 'beta'    suffix: 'beta'

| `v2.5.10` | `v2.5.11-rc` | Increments patch: 2.5.10 → 2.5.11 |

| `v1.0.0-beta` | `v1.0.1-rc` | Ignores prerelease, increments patch |



## Prerequisites- name: Generate release candidate- name: Generate release candidate



- Your repository must be checked out with `fetch-depth: 0` to access git tags  id: rc  id: rc

- Semantic version tags should follow the format `v1.2.3` (the `v` prefix is required)

  uses: optivem/generate-prerelease-version-action@v1  uses: optivem/generate-prerelease-version-action@v1

## Common Use Cases

  with:  with:

### 1. Continuous Integration Prereleases

    suffix: 'rc'    suffix: 'rc'

```yaml

# Automatically create prereleases on every main branch push``````

- name: Generate CI version

  id: version  uses: optivem/generate-prerelease-version-action@v1

  uses: optivem/generate-prerelease-version-action@v1

  with:### Using the Generated Version  with:

    suffix: 'ci'

```    image-urls: '["ghcr.io/${{ github.repository }}/frontend:latest", "ghcr.io/${{ github.repository }}/api:latest", "ghcr.io/${{ github.repository }}/worker:latest"]'



### 2. Docker Image Tagging```yaml```



```yaml- name: Generate prerelease version

- name: Generate version

  id: version  id: version### Single Image Usage

  uses: optivem/generate-prerelease-version-action@v1

  uses: optivem/generate-prerelease-version-action@v1

- name: Build and push Docker image

  run: |```yaml

    docker build -t myapp:${{ steps.version.outputs.version }} .

    docker push myapp:${{ steps.version.outputs.version }}- name: Create GitHub Release- name: Version and tag Docker image

```

  uses: actions/create-release@v1  uses: optivem/generate-prerelease-version-action@v1

### 3. Package Version Updates

  with:  with:

```yaml

- name: Generate version    tag_name: ${{ steps.version.outputs.version }}    image-urls: 'ghcr.io/${{ github.repository }}/my-app:latest'

  id: version

  uses: optivem/generate-prerelease-version-action@v1    release_name: ${{ steps.version.outputs.version }}```



- name: Update package.json version    prerelease: true

  run: |

    npm version ${{ steps.version.outputs.version }} --no-git-tag-version### Mixed Registries and Formats

```

- name: Update package.json

### 4. Multi-stage Release Pipeline

  run: |```yaml

```yaml

name: Release Pipeline    npm version ${{ steps.version.outputs.version }} --no-git-tag-version- name: Version and tag Docker images

on:

  workflow_dispatch:  uses: optivem/generate-prerelease-version-action@v1

    inputs:

      stage:- name: Docker build and tag  with:

        description: 'Release stage'

        required: true  run: |    image-urls: |

        default: 'rc'

        type: choice    docker build -t myapp:${{ steps.version.outputs.version }} .      # GHCR images with tags

        options:

          - alpha    docker push myapp:${{ steps.version.outputs.version }}      ghcr.io/org/frontend:latest

          - beta

          - rc```      ghcr.io/org/backend:v2.1.0



jobs:      

  release:

    runs-on: ubuntu-latest## Inputs      # Docker Hub with digest

    steps:

      - uses: actions/checkout@v4      docker.io/username/service@sha256:abc123def456

        with:

          fetch-depth: 0| Input | Description | Required | Default |      

          

      - name: Generate ${{ github.event.inputs.stage }} version|-------|-------------|----------|---------|      # Azure Container Registry

        id: version

        uses: optivem/generate-prerelease-version-action@v1| `suffix` | Prerelease suffix (e.g., rc, alpha, beta) | ❌ | `rc` |      myregistry.azurecr.io/team/api:latest

        with:

          suffix: ${{ github.event.inputs.stage }}    registry-token: ${{ secrets.MULTI_REGISTRY_TOKEN }}

          

      - name: Build and deploy## Outputs    registry-username: ${{ github.actor }}

        run: |

          echo "Deploying version: ${{ steps.version.outputs.version }}"```

          # Your deployment steps here

```| Output | Description | Example |



## Troubleshooting|--------|-------------|---------|### Docker Hub Usage (Newline Format)



### "No existing semantic version tags found"| `version` | The generated prerelease version | `v1.2.4-rc` |



If you see this message, the action will start from `v0.0.0`. To set a specific starting point:```yaml



```bash## How It Works- name: Version and tag Docker images

git tag v1.0.0

git push origin v1.0.0  uses: optivem/generate-prerelease-version-action@v1

```

1. **Scans Git Tags**: Finds the latest semantic version tag (v*.*.*)  with:

### Missing git tags in workflow

2. **Increments Patch**: Automatically bumps the patch version (e.g., v1.2.3 → v1.2.4)    image-urls: |

Make sure you checkout with full history:

3. **Adds Suffix**: Appends the prerelease suffix (e.g., v1.2.4-rc)      docker.io/username/frontend:latest

```yaml

- uses: actions/checkout@v44. **Sets Output**: Makes the version available as a GitHub Actions output      docker.io/username/backend:latest

  with:

    fetch-depth: 0  # This is required!    registry-token: ${{ secrets.DOCKER_TOKEN }}

```

### Version Examples    registry-username: 'username'  # Your Docker Hub username

### Invalid tag format

```

The action expects tags in the format `v1.2.3`. These won't work:

- `1.2.3` (missing 'v' prefix)| Latest Git Tag | Generated Version | Description |

- `release-1.2.3` (wrong format)

- `v1.2` (incomplete semantic version)|---------------|-------------------|-------------|### Docker Hub Usage (JSON Format)



## License| (no tags) | `v0.0.1-rc` | Starts from v0.0.0 |



MIT License - see [LICENSE](LICENSE) file for details.| `v1.0.0` | `v1.0.1-rc` | Increments patch |```yaml



## Contributing| `v2.5.10` | `v2.5.11-rc` | Increments patch |- name: Version and tag Docker images



Contributions welcome! Please submit issues and pull requests.| `v1.0.0-beta` | `v1.0.1-rc` | Increments from prerelease |  uses: optivem/generate-prerelease-version-action@v1

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
