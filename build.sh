#!/bin/bash

echo "🔨 Starting Build Script..."

# Stop if any command fails
set -e

echo "hi123"

# Build the Docker image
docker build -t test .

echo "✅ Build Completed!"
