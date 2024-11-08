# Qodana linters (with hacks)

Qodana linters, with a few hacks to make them work with monorepos containing multiple projects.

The Python linter additionally installs [`uv` and `uvx`](https://docs.astral.sh/uv/) and adds `.venv/bin` in the project directory to `$PATH`, so the virtualenv interpreter is used first.

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

In a monorepo, place the `qodana.yml` file in the project directory, and specify the hacked linter in the GitHub Actions
workflow.

You can specify `-e SUBPROJECT_DIR=path/to/project` to specify a project to be scanned. It will be scanned while keeping
still mounting the entire repository.

For instance:

```bash
qodana scan \
    -l ghcr.io/expandigroup/qodana-jvm:2024.1 \
    -i . \
    -e SUBPROJECT_DIR=backend \
    -e QODANA_TOKEN="$QODANA_TOKEN"
```

Sample GitHub Actions workflow:

```yml
name: Qodana
on:
  workflow_dispatch:
  pull_request:
  push:
    branches:
      - main
      - 'releases/*'

jobs:
  qodana:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
      checks: write
    steps:
      - uses: actions/checkout@v3
        with:
          ref: ${{ github.event.pull_request.head.sha }}  # to check out the actual pull request commit, not the merge commit
          fetch-depth: 0  # a full history is required for pull request analysis
      - name: 'Qodana Scan'
        uses: JetBrains/qodana-action@v2024.1
        env:
          QODANA_TOKEN: ${{ secrets.QODANA_TOKEN }}
        with:
            args: -l,ghcr.io/expandigroup/qodana-jvm:2024.1,-e,SUBPROJECT_DIR=backend
```

