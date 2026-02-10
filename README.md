# Generate Prerelease Version

[![test](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/test.yml)
[![release](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/generate-prerelease-version-action/actions/workflows/release.yml)

[![GitHub release](https://img.shields.io/github/release/optivem/generate-prerelease-version-action.svg)](https://github.com/optivem/generate-prerelease-version-action/releases)
[![GitHub](https://img.shields.io/github/license/optivem/generate-prerelease-version-action)](LICENSE)

GitHub Action that creates semantic prerelease versions. Use **v1** (tag-based) or **v2** (base-version + prerelease suffix).

---

## v1

Derives the next prerelease version from your latest git tag.

### Usage (v1)

```yaml
- uses: optivem/generate-prerelease-version-action@v1
  id: version
  with:
    suffix: 'rc'
```

### What it does (v1)

- Finds your latest git tag (e.g. `v1.2.3`)
- Increments the patch number (e.g. `v1.2.4`)
- Appends your suffix (e.g. `v1.2.4-rc`)

### Inputs (v1)

| Input   | Description                    | Default |
|--------|--------------------------------|---------|
| suffix | Prerelease suffix (e.g. rc, beta) | `rc` |

### Outputs (v1)

| Output  | Description           |
|---------|-----------------------|
| version | The prerelease version string |

### Example (v1)

```yaml
- uses: actions/checkout@v4
  with:
    fetch-depth: 0

- uses: optivem/generate-prerelease-version-action@v1
  id: version
  with:
    suffix: 'beta'

- run: echo ${{ steps.version.outputs.version }}
```

### Requirements (v1)

- Use `fetch-depth: 0` in checkout.
- Git tags must be semantic (e.g. `v1.2.3`).

---

## v2

Builds a prerelease version from a base version and an optional prerelease number (e.g. `1.0.0-rc.12`).

### Usage (v2)

```yaml
- uses: optivem/generate-prerelease-version-action@v2
  id: version
  with:
    base-version: '1.0.0'
    prerelease-label: 'rc'
    prerelease-number: '12'
```

### What it does (v2)

- Takes a base semantic version you provide.
- Appends `-<label>.N` (e.g. `1.0.0-rc.12`). If `prerelease-number` is omitted, the suffix is `-<label>` only.

### Inputs (v2)

| Input             | Description                          | Required | Default |
|-------------------|--------------------------------------|----------|---------|
| base-version      | Base semantic version (e.g. 1.0.0)   | Yes      | —       |
| prerelease-label  | Label (e.g. rc, beta, alpha)         | No       | `rc`    |
| prerelease-number | Number for suffix (e.g. 12 → -rc.12) | No       | —       |

### Outputs (v2)

| Output             | Description                    |
|--------------------|--------------------------------|
| prerelease-version | Generated version (e.g. 1.0.0-rc.12) |

### Example (v2)

```yaml
- uses: optivem/generate-prerelease-version-action@v2
  id: version
  with:
    base-version: '1.0.0'
    prerelease-label: 'beta'
    prerelease-number: '3'

- run: echo ${{ steps.version.outputs.prerelease-version }}
```

---

Pin to a major version: `@v1` or `@v2`, or to a specific release: `@v1.0.2`, `@v2.0.0`.
