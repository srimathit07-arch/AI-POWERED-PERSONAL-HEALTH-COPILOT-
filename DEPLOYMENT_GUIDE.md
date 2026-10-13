# MediMitra: VPS & Docker Production Deployment Guide 🚀

This guide covers deploying **MediMitra** to any Virtual Private Server (VPS) such as **DigitalOcean, AWS EC2, Linode/Akamai, Hetzner, or a personal Linux server** using **Docker & Nginx**.

---

## Architecture Overview

```
Client Browser (Desktop/Mobile)
          │
          ▼ Port 80 (HTTP)
   ┌──────────────┐
   │ Nginx Proxy  │
   └──────┬───────┘
          │
   ┌──────┴──────────────┐
   ▼ (routes /)          ▼ (routes /api/)
┌──────────────┐   ┌──────────────┐
│   Next.js    │   │   FastAPI    │
│   Frontend   │   │   Backend    │
└──────────────┘   └──────┬───────┘
                          ▼
                   ┌──────────────┐
                   │ SQLite & PDF │
                   │ File Storage │
                   └──────────────┘
```

- **Frontend**: Next.js (App Router, Tailwind CSS)
- **Backend**: FastAPI with Multimodal OCR & Gemini integration
- **Reverse Proxy**: Nginx (serves both web and API through port 80 with zero CORS hassle)

---

## Option 1: Quick 1-Click Deployment on VPS (Ubuntu/Debian)

### Step 1: Create a VPS Droplet / EC2 Instance
- **Recommended specs**: 1-2 vCPUs, 2 GB RAM (e.g. DigitalOcean Basic Droplet @ $6/month or AWS EC2 `t3.small` / `t4g.small`).
- **OS**: Ubuntu 22.04 LTS or 24.04 LTS.

### Step 2: Connect to your VPS via SSH
```bash
ssh root@YOUR_SERVER_IP
```

### Step 3: Copy your project code to the VPS
You can clone from GitHub or copy via `scp`:
```bash
# Example if using Git:
git clone https://github.com/<your-username>/medimitra.git
cd medimitra
```
*Or upload the folder via SCP/FileZilla to `/root/medimitra`.*

### Step 4: Run the deployment script
```bash
chmod +x deploy.sh
./deploy.sh
```

The script will automatically:
1. Install Docker & Docker Compose if not already installed.
2. Build the optimized production containers for Frontend and Backend.
3. Start Nginx reverse proxy on port 80.
4. Output your live public URL!

---

## Option 2: Manual Docker Commands

If you prefer running commands step-by-step:

```bash
# 1. Navigate to the project directory
cd "ai-powered personal health copilot"

# 2. (Optional) Set your Gemini API key in a .env file
echo "GEMINI_API_KEY=your_key_here" > .env

# 3. Build and launch all services in detached mode
docker compose up --build -d

# 4. View real-time logs
docker compose logs -f
```

---

## Useful Docker Management Commands

- **Check running status**:
  ```bash
  docker compose ps
  ```
- **View live backend logs**:
  ```bash
  docker compose logs -f backend
  ```
- **Stop services**:
  ```bash
  docker compose down
  ```
- **Restart after code changes**:
  ```bash
  docker compose up --build -d
  ```

---

## Securing with HTTPS / SSL (Free via Certbot)

Once your VPS has a custom domain name (e.g. `medimitra.yourdomain.com` pointing to your VPS IP):

```bash
# Install Certbot
apt-get update && apt-get install -y certbot python3-certbot-nginx

# Obtain free SSL certificate
certbot --nginx -d medimitra.yourdomain.com
```
Certbot will automatically configure HTTPS on port 443 and auto-renew certificates.
