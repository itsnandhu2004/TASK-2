#!/bin/bash
source .env



# Stop if any command fails
set -e

echo "🔨 Starting Deployment Script..."

# Print a simple message for testing
echo "hi123"

# Make build script executable and run it
chmod +x build.sh
./build.sh

# Log in to Docker Hub securely
echo "$DOCKER_PAT" | docker login -u nandhini1694 --password-stdin

# Tag Docker image with your repository name
docker tag html-app nandhini1694/myrepo

# Push image to Docker Hub
docker push nandhini1694/myrepo

# Stop and remove the previous container if it exists
echo "🛑 Stopping and Removing Previous Container..."
docker stop html-container || true
docker rm html-container || true

# Run a new container with your image
echo "🚀 Running New Container..."
docker run -d -p 8080:80 --name html-container nandhini1694/myrepo

# Install and Start Ngrok if not already installed
if ! command -v ngrok &> /dev/null; then
    echo "📥 Installing Ngrok..."
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok-stable-linux-amd64.zip
    sudo mv ngrok /usr/local/bin/
fi

# Start Ngrok
echo "🌍 Exposing Port 8080 via Ngrok..."
ngrok http 8080 > /dev/null &

echo "✅ Deployment Complete! Access your HTML at the Ngrok URL."
