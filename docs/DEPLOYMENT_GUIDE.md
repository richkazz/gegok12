# Deployment Guide: GitHub Actions & GHCR Deployment

This guide explains how GegoK12 is configured for automated CI/CD deployment using **GitHub Actions**, **GitHub Container Registry (GHCR)**, and remote deployment over **SSH**.

---

## 🏗️ Architecture Overview

To ensure optimal server performance and security:
1. **GitHub Actions does all heavy lifting**:
   - Runs tests locally in CI.
   - Installs PHP & Node.js dependencies.
   - Compiles production frontend assets (`npm run production`).
   - Builds the Docker image containing pre-compiled code and assets.
   - Pushes the resulting Docker image to **GitHub Container Registry (GHCR)** (`ghcr.io`).
2. **Server only pulls the final image**:
   - The server receives an SSH command from GitHub Actions.
   - It pulls the pre-built Docker image from GHCR.
   - It restarts containers (`docker compose -f docker-compose.prod.yml up -d`) in `apps/gego12`.
   - It runs database migrations and Laravel optimizations.

---

## 🔑 1. GitHub Repository Secrets Setup

In your GitHub repository, navigate to **Settings > Secrets and variables > Actions** and add the following repository secrets:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `SERVER_IP` | Server IP address or domain | `192.0.2.1` or `app.example.com` |
| `SERVER_USER` | Server SSH username | `ubuntu` or `root` or `deploy` |
| `SSH_PRIVATE_KEY` | Private SSH key matching target server's `~/.ssh/authorized_keys` | `-----BEGIN OPENSSH PRIVATE KEY----- ...` |

---

## 🖥️ 2. Server Prerequisites & Directory Setup

On your target server, perform the initial setup:

### A. Install Docker and Docker Compose
Ensure Docker and Docker Compose are installed on the server:
```bash
docker --version
docker compose version
```

### B. Create Application Directory Structure
Create the targeted deployment directory (`apps/gego12`):
```bash
mkdir -p apps/gego12
cd apps/gego12
```

### C. Place Server Configuration Files
Copy the production compose file, `.env`, `nginx.conf`, and `php.ini` into `apps/gego12/`:

- `docker-compose.prod.yml`
- `.env` (configured with production credentials)
- `nginx.conf`
- `php.ini`

Ensure permissions are correctly configured on `.env`:
```bash
chmod 600 .env
```

---

## 🚀 3. CI/CD Pipeline Workflow Summary

The CI/CD pipeline is configured in `.github/workflows/deploy.yml`.

### Triggers:
- **Push to branch**: `host`
- **Manual Trigger**: `workflow_dispatch` (Run workflow manually from GitHub Actions UI)

### Pipeline Steps:
1. **Checkout & Environment Setup**: Set up PHP 8.4 and Node.js 20.
2. **Automated Testing**: Runs key test suites to ensure zero regressions before building.
3. **Asset Compilation**: Runs `npm run production` to compile frontend assets.
4. **Image Build & GHCR Push**: Builds the Docker container and pushes to `ghcr.io/<owner>/<repo>:latest`.
5. **SSH Server Deployment**:
   - SSH into server (`${{ secrets.SERVER_USER }}@${{ secrets.SERVER_IP }}`).
   - Change directory to `apps/gego12`.
   - Log in to GHCR and pull updated image.
   - Restart containers using `docker-compose.prod.yml`.
   - Run `php artisan migrate --force`, `config:cache`, `route:cache`, `view:cache`.

---

## 🧪 4. Local Testing Before Finalizing

Before pushing changes to the `host` branch:

1. Run unit/feature tests:
   ```bash
   php artisan test tests/Feature/AuthenticationTest.php tests/Feature/SchoolStatusLifecycleTest.php tests/Feature/TeacherStatusLifecycleTest.php
   ```
2. Verify production Compose syntax:
   ```bash
   docker compose -f docker-compose.prod.yml config
   ```
3. Commit and push to the `host` branch:
   ```bash
   git push origin host
   ```
