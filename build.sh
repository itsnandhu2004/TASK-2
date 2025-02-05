#!/bin/bash

# Stop if any command fails
set -e

# Build Docker image
echo "🔨 Building Docker Image..."
docker build -t html-app .

echo "✅ Build Complete!"
