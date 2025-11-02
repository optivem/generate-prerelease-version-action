# Generate Prerelease Version

[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)
[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)

GitHub Action that creates semantic prerelease versions.

## Usage

```yaml
- uses: optivem/generate-prerelease-version-action@v1
  id: version
  with:
    suffix: 'rc'
```

## What it does

- Finds your latest git tag (like v1.2.3)
- Adds 1 to the patch number (v1.2.4)  
- Adds your suffix (v1.2.4-rc)

## Inputs

- suffix - What to add at the end (default: rc)

## Outputs

- version - The new version string

## Example

```yaml
name: Make Version
on: push

jobs:
  version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: optivem/generate-prerelease-version-action@v1
        id: version
        with:
          suffix: 'beta'
      
      - run: echo ${{ steps.version.outputs.version }}
```

## Requirements

- Use fetch-depth: 0 in checkout
- Git tags should be like v1.2.3
