# Qodana linters (with hacks)

Qodana linters, with a few hacks to make them work with monorepos containing multiple projects.

## Usage

`qodana.yml`:

```yaml
version: 1
linter: ghcr.io/expandigroup/qodana-hacks:LANGUAGE-VERSION
```

Replace `jvm-latest` with the desired version.

Languages:

- `jvm`
- `js`
- `python`
- `go`

Versions:

- `latest`
- `2024.1`

For instance, to use the latest JVM linter on a Java project:

```yaml
version: 1
linter: ghcr.io/expandigroup/qodana-hacks:jvm-latest
```

# Usage in monorepos

In a monorepo, place the `qodana.yml` file in the project directory, and specify the hacked linter in the GitHub Actions
workflow.
