ARG IMAGE
ARG LINTER

############################################################################

# Base image
FROM $IMAGE AS base

ENV LINTER="$LINTER"
COPY entrypoint.sh /entrypoint.sh

RUN QODANA=$(which qodana) && mv "$QODANA" "${QODANA}.orig" && mv /entrypoint.sh "$QODANA"

############################################################################

# Apply linter-specific customizations
FROM base as base-jvm
FROM base as base-go
FROM base as base-js
FROM base as base-php
FROM base as base-dotnet
FROM base as base-jvm-community
FROM base as base-python-community
FROM base as base-jvm-android
FROM base as base-cdnet
FROM base as base-clang

FROM base AS base-python
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

############################################################################

# Final image
FROM base-$LINTER

