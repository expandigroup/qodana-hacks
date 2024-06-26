# Qodana linters (with hacks)

Qodana linters, with a few hacks to make them work with monorepos containing multiple projects.

## Usage

`qodana.yml`:

```yaml
version: 1
linter: ghcr.io/expandigroup/qodana-$LANGUAGE:$VERSION
```

Available patched images:

- [`qodana-jvm`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-jvm)
- [`qodana-python`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-python)
- [`qodana-go`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-go)
- [`qodana-js`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-js)
- [`qodana-php`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-php)
- [`qodana-dotnet`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-dotnet)
- [`qodana-jvm-community`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-jvm-community)
- [`qodana-python-community`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-python-community)
- [`qodana-jvm-android`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-jvm-android)
- [`qodana-cdnet`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-cdnet)
- [`qodana-clang`](https://github.com/expandigroup/qodana-hacks/pkgs/container/qodana-clang)


For instance, to use the latest JVM linter on a Java project:

```yaml
version: 1
linter: ghcr.io/expandigroup/qodana-jvm:latest
```

# Usage in monorepos

In a monorepo, place the `qodana.yml` file in the project directory, and specify the hacked linter in the GitHub Actions
workflow.
