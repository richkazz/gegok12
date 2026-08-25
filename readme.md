# GegoK12

[![GitHub Forks](https://img.shields.io/github/forks/Gego-K12/gegok12?style=for-the-badge)](https://github.com/Gego-K12/gegok12/network/members)
[![GitHub Issues](https://img.shields.io/github/issues/Gego-K12/gegok12?style=for-the-badge)](https://github.com/Gego-K12/gegok12/issues)

## Version

**v1.1**
j
---

## System Requirements

### Required

1. **PHP 8.4+**
2. **MySQL**
3. **Composer** (must be available in CLI)
4. **PHP CLI** (`php` command available in terminal)

### PHP Extensions Required

- `pdo`
- `pdo_mysql`
- `mbstring`
- `openssl`
- `tokenizer`
- `json`
- `curl`
- `fileinfo`
- `gd`
- `bcmath`
- `xml`
- `zip`

### Optional

- **Node.js 24 + npm** (recommended for asset build during install)
- **Redis**

---

## Install with Visual Installer (Recommended)

The v1.1 installer is available at:

`/public/installer`

### 1) Prepare project

1. Clone/pull the repository.
2. Ensure web server points to `public`.
3. Ensure these folders are writable:
   - `storage/`
   - `bootstrap/cache`

### 2) Open installer

Open in browser:

- Local (example): `http://localhost:9000/installer/`
- Docker/Nginx (example): `http://localhost:8090/installer/`

### 3) Complete wizard steps

1. Welcome
2. Requirements check
3. Database setup
4. App/Admin setup
5. Automated installation (runs all setup steps)
6. Install complete screen

### 4) What step 5 runs automatically

- Composer install
- App key generation
- Storage link
- Database migrate (fresh)
- Database seed
- Optional npm install/build (if Node/npm available)
- Laravel cache optimization
- Finalize installation (`storage/installed` marker)

### 5) After successful install

1. Open login page from the complete screen.
2. Verify you can sign in.
3. **Security:** remove or rename `public/installer` after verification.

---

## Re-testing Installer

If you want to run installer again in local/dev:

1. Remove install marker: `rm -f storage/installed`
2. Clear browser cookies for localhost (or use private window)
3. Clear caches:
   - `php artisan config:clear`
   - `php artisan cache:clear`
   - `php artisan route:clear`
   - `php artisan view:clear`
4. Reopen `http://localhost:9000/installer/`

---

## Manual Install (CLI)

Use this if you are not using the Visual Installer.

1. `composer install`
2. `cp .env.example .env`
3. Configure DB in `.env`
4. `php artisan key:generate`
5. `php artisan migrate`
6. `php artisan db:seed`
7. `php artisan storage:link`
8. `npm install && npm run production` (optional/recommended)

---

## Docker Quick Start

1. `cp .env.example .env`
2. `docker-compose up -d --build`
3. Install PHP dependencies:
   - `docker exec -it school_app bash`
   - `composer install`
4. Run migrations/seed:
   - `php artisan migrate`
   - `php artisan db:seed`
5. Install frontend deps (optional):
   - `docker exec -it node_app npm install`
6. Open app:
   - `http://localhost:8090/`

---

## Installation Video

[![GegoK12 Installation Video](public/images/gegok12_cover.jpg)](https://www.youtube.com/watch?v=dh1DuLLP-Xk)

---

## Troubleshooting & Support

If you face any issue during installation or setup:

1. Please contact the development team via **https://gegok12.com**
2. Or post an issue here: **https://github.com/Gego-K12/gegok12/issues**

---

## Community

If this project helps you, please:

1. ⭐ Star the repository
2. 🍴 Fork the repository
3. Share feedback and improvements via issues/PRs

---

## Professional Support & Module Development

For professional support, implementation help, or additional/custom module development, please contact:

**https://gegok12.com**
