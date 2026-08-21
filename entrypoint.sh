#!/bin/sh
set -e

# Copy template .env if not exists
if [ ! -f /var/www/.env ]; then
    if [ -f /var/www/.env.example ]; then
        cp /var/www/.env.example /var/www/.env

        if [ -n "${DB_CONNECTION}" ]; then
            sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=${DB_CONNECTION}/" /var/www/.env
        fi
        if [ -n "${DB_HOST}" ]; then
            sed -i "s/DB_HOST=.*/DB_HOST=${DB_HOST}/" /var/www/.env
        fi
        if [ -n "${DB_PORT}" ]; then
            sed -i "s/DB_PORT=.*/DB_PORT=${DB_PORT}/" /var/www/.env
        fi
        if [ -n "${DB_DATABASE}" ]; then
            sed -i "s#DB_DATABASE=.*#DB_DATABASE=${DB_DATABASE}#" /var/www/.env
        fi
        if [ -n "${DB_USERNAME}" ]; then
            sed -i "s/DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/" /var/www/.env
        fi
        if [ -n "${DB_PASSWORD}" ]; then
            sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" /var/www/.env
        fi
    fi
fi

# Ensure storage directory structure and installation marker exist
mkdir -p /var/www/storage/framework/cache/data \
         /var/www/storage/framework/sessions \
         /var/www/storage/framework/views \
         /var/www/storage/logs \
         /var/www/storage/app/public \
         /var/www/bootstrap/cache

if [ ! -f /var/www/storage/installed ]; then
    touch /var/www/storage/installed
fi

chmod -R 777 /var/www/storage /var/www/bootstrap/cache 2>/dev/null || true

# Ensure public/storage symlink points correctly inside container
rm -f /var/www/public/storage
ln -sf /var/www/storage/app/public /var/www/public/storage 2>/dev/null || true

# Sync updated public assets if public_shared volume is mounted
if [ -d "/var/www/public_shared" ]; then
    cp -a /var/www/public/. /var/www/public_shared/ 2>/dev/null || true
fi

exec "$@"
