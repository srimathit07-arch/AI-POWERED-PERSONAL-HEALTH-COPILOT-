#!/bin/bash
set -e

echo "=========================================="
echo "  Deploying MediMitra via Docker on VPS   "
echo "=========================================="

# 1. Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable docker
    systemctl start docker
fi

# 2. Check if Docker Compose plugin is installed
if ! docker compose version &> /dev/null; then
    echo "Installing Docker Compose..."
    apt-get update && apt-get install -y docker-compose-plugin
fi

# 3. Create .env if not exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat <<EOT >> .env
GEMINI_API_KEY=
GEMINI_MODEL=gemini-2.5-flash
EOT
fi

# 4. Build and start containers
echo "Building and launching containers..."
docker compose down || true
docker compose up --build -d

echo ""
echo "=========================================="
echo "  MediMitra is LIVE!                     "
echo "=========================================="
echo "Access the app: http://$(curl -s ifconfig.me || echo 'YOUR_SERVER_IP')"
echo "API Docs:       http://$(curl -s ifconfig.me || echo 'YOUR_SERVER_IP')/docs"
echo "=========================================="
