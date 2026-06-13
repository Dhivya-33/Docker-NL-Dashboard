@echo off
REM Quick deployment script for Windows

echo ========================================
echo Docker NL Dashboard Deployment
echo ========================================
echo.

REM Check if .env exists
if not exist .env (
    echo ❌ .env file not found!
    echo 📝 Creating .env from .env.example...
    copy .env.example .env
    echo ⚠️  Please edit .env and add your GROQ_API_KEY
    pause
    exit /b 1
)

echo ✅ Configuration found
echo.

REM Check Docker
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not running
    pause
    exit /b 1
)
echo ✅ Docker is running
echo.

REM Build and start
echo 🔨 Building and starting services...
docker-compose up -d --build

REM Wait for service
echo.
echo ⏳ Waiting for service to be ready...
timeout /t 5 /nobreak >nul

echo.
echo ✅ Deployment successful!
echo.
echo 📊 Dashboard: http://localhost:8501
echo 📋 Logs: docker-compose logs -f
echo 🛑 Stop: docker-compose down
echo.
pause
