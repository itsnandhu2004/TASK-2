#!/bin/bash

# Stop if any command fails
set -e

echo "🔨 Starting Deployment Script..."

# Log in to Docker Hub securely
echo "$DOCKER_PAT" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Grant execution permissions to build script
chmod +x build.sh

# Run build script
./build.sh

# Tag and push Docker image
docker tag test "$DOCKER_USERNAME/$DOCKER_IMAGE"
docker push "$DOCKER_USERNAME/$DOCKER_IMAGE"

echo "✅ Deployment Completed Successfully!"
