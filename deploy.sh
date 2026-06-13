#!/bin/bash
# Quick deployment script

echo "🚀 Docker NL Dashboard Deployment"
echo "=================================="
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "📝 Creating .env from .env.example..."
    cp .env.example .env
    echo "⚠️  Please edit .env and add your GROQ_API_KEY"
    exit 1
fi

# Check if GROQ_API_KEY is set
if ! grep -q "^GROQ_API_KEY=gsk_" .env; then
    echo "❌ GROQ_API_KEY not set in .env"
    echo "⚠️  Please edit .env and add your GROQ_API_KEY"
    exit 1
fi

echo "✅ Configuration found"
echo ""

# Check Docker
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running"
    exit 1
fi
echo "✅ Docker is running"
echo ""

# Build and start
echo "🔨 Building and starting services..."
docker-compose up -d --build

# Wait for service to be ready
echo ""
echo "⏳ Waiting for service to be ready..."
sleep 5

# Check status
if docker-compose ps | grep -q "Up"; then
    echo ""
    echo "✅ Deployment successful!"
    echo ""
    echo "📊 Dashboard: http://localhost:8501"
    echo "📋 Logs: docker-compose logs -f"
    echo "🛑 Stop: docker-compose down"
    echo ""
else
    echo ""
    echo "❌ Deployment failed. Check logs:"
    docker-compose logs
fi
