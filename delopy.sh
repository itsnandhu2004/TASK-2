#!/bin/bash

# Stop if any command fails
set -e

echo "🔨 Starting Deployment Script..."

# Ensure .env file exists before sourcing it
if [ -f .env ]; then
    source .env
else
    echo "❌ Error: .env file not found!"
    exit 1
fi

# Log in to Docker Hub securely
echo "$DOCKER_PAT" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Print a simple message for testing
echo "hi123"

# Ensure build script is executable and run it
if [ -f build.sh ]; then
    chmod +x build.sh
    ./build.sh
else
    echo "❌ Error: build.sh not found!"
    exit 1
fi

# Tag Docker image with your repository name
docker tag html-app "$DOCKER_USERNAME/myrepo"

# Push image to Docker Hub
docker push "$DOCKER_USERNAME/myrepo"

# Stop and remove the previous container if it exists
echo "🛑 Stopping and Removing Previous Container..."
docker stop html-container 2>/dev/null || true
docker rm html-container 2>/dev/null || true

# Run a new container with your image
echo "🚀 Running New Container..."
docker run -d -p 8080:80 --name html-container "$DOCKER_USERNAME/myrepo"

# Install Ngrok if not already installed
if ! command -v ngrok &> /dev/null; then
    echo "📥 Installing Ngrok..."
    wget -q -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip
    unzip -q ngrok.zip
    sudo mv ngrok /usr/local/bin/
    rm -f ngrok.zip
fi

# Ensure no existing Ngrok process is running
pkill ngrok || true

# Start Ngrok in the background
echo "🌍 Exposing Port 8080 via Ngrok..."
nohup ngrok http 8080 > /dev/null 2>&1 &

echo "✅ Deployment Complete! Access your HTML at the Ngrok URL."
