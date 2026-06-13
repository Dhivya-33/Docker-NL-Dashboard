# 🚀 Deployment Guide

## Option 1: Streamlit Community Cloud (Free, Easiest)

⚠️ **Note**: Streamlit Cloud won't have access to your local Docker daemon. This works best for demo purposes with mock data.

### Steps:

1. **Push to GitHub**
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/docker-nl-dashboard.git
git push -u origin main
```

2. **Deploy on Streamlit Cloud**
   - Go to: https://share.streamlit.io
   - Click "New app"
   - Select your GitHub repo
   - Main file: `app.py`
   - Click "Deploy"

3. **Add Secrets**
   - In Streamlit Cloud dashboard → Settings → Secrets
   - Add your Groq API key:
   ```toml
   GROQ_API_KEY = "your_groq_api_key_here"
   ```

---

## Option 2: Docker Container (VPS/Cloud Server)

Best for actual Docker management since it has access to Docker socket.

### Steps:

1. **Build and run with Docker Compose**
```bash
# Add your API key to .env file first
docker-compose up -d
```

2. **Access the dashboard**
```
http://your-server-ip:8501
```

### Deploy on Cloud Providers:

#### AWS EC2 / DigitalOcean / Linode

```bash
# 1. SSH into your server
ssh user@your-server-ip

# 2. Install Docker & Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# 3. Clone your repo
git clone https://github.com/yourusername/docker-nl-dashboard.git
cd docker-nl-dashboard

# 4. Create .env file
nano .env
# Add: GROQ_API_KEY=your_key_here

# 5. Run
docker-compose up -d

# 6. Access: http://your-server-ip:8501
```

---

## Option 3: Heroku

```bash
# 1. Install Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli

# 2. Login
heroku login

# 3. Create app
heroku create your-app-name

# 4. Add buildpack
heroku buildpacks:set heroku/python

# 5. Set environment variable
heroku config:set GROQ_API_KEY=your_groq_api_key_here

# 6. Create Procfile (already exists)
# 7. Deploy
git push heroku main

# 8. Open
heroku open
```

---

## Option 4: Railway.app (Easy Docker Deployment)

1. Go to: https://railway.app
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repo
4. Add environment variable: `GROQ_API_KEY`
5. Railway auto-detects docker-compose.yml
6. Click "Deploy"

---

## Option 5: Render.com (Free Tier Available)

1. Go to: https://render.com
2. Click "New" → "Web Service"
3. Connect your GitHub repo
4. Settings:
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `streamlit run app.py --server.port=$PORT`
   - **Environment**: Add `GROQ_API_KEY`
5. Click "Create Web Service"

---

## Option 6: Docker Hub + Any VPS

```bash
# 1. Build and push to Docker Hub
docker build -t yourusername/docker-nl-dashboard .
docker push yourusername/docker-nl-dashboard

# 2. On any server, pull and run
docker pull yourusername/docker-nl-dashboard
docker run -d \
  -p 8501:8501 \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -e GROQ_API_KEY=your_key \
  yourusername/docker-nl-dashboard
```

---

## 🔒 Security Considerations

### For Production:

1. **Add Authentication**
   - Use Streamlit's built-in auth (coming soon)
   - Or add reverse proxy with Nginx + Basic Auth

2. **Docker Socket Access**
   - Consider using read-only mount: `:ro`
   - Or use Docker API over TCP with TLS

3. **Environment Variables**
   - Never commit `.env` or secrets
   - Use cloud provider's secret management

4. **HTTPS**
   - Use Nginx reverse proxy with Let's Encrypt
   - Or use cloud provider's SSL/TLS

---

## 📊 Recommended Setup for Real Usage

**For managing actual Docker containers:**
- Deploy on VPS (DigitalOcean, AWS EC2, Linode)
- Use Docker Compose deployment (Option 2)
- Add Nginx reverse proxy with SSL
- Restrict access via firewall/security groups

**For demo/portfolio:**
- Use Streamlit Cloud (Option 1)
- Note: Won't connect to real Docker (runs in sandbox)

---

## 🧪 Test After Deployment

1. Open the URL
2. Go to "Settings" page
3. Click "Test Groq Connection"
4. Should see: ✅ Success message

---

## 🆘 Troubleshooting

### Docker socket access denied
```bash
# On Linux VPS
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
```

### Port conflicts
```bash
# Change port in docker-compose.yml or use:
docker-compose run -p 8502:8501
```

### Groq API errors
- Verify API key is correct
- Check rate limits at: https://console.groq.com

---

## 💡 Next Steps

After deployment:
1. Test all 7 pages work
2. Try AI Agent with natural language
3. Create test containers
4. Monitor logs in Logs page
5. Check Analytics page for visualizations

---

Choose the option that best fits your needs! 🚀
