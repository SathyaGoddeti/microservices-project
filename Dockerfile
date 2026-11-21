
# Copyright 2020 Google LLC
# Licensed under the Apache License, Version 2.0

# Updated Python base image
FROM python:3.10-slim-bookworm AS base

FROM base AS builder

# Install required build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        g++ \
    && rm -rf /var/lib/apt/lists/*

# Download gRPC health probe
ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18

RUN wget -qO /bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 \
    && chmod +x /bin/grpc_health_probe

# Install Python dependencies
WORKDIR /build

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM base AS without-grpc-health-probe-bin

# Enable unbuffered logging
ENV PYTHONUNBUFFERED=1

# Application working directory
WORKDIR /recommendationservice

# Copy installed Python packages
COPY --from=builder /usr/local/lib/python3.10/ /usr/local/lib/python3.10/

# Copy application files
COPY . .

# Application port
ENV PORT=8080

EXPOSE 8080

ENTRYPOINT ["python", "recommendation_server.py"]

# Final stage
FROM without-grpc-health-probe-bin

COPY --from=builder /bin/grpc_health_probe /bin/grpc_health_probe
