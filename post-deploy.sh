#!/bin/sh

echo " Importing assets..."
php bin/console importmap:install || true

echo " Clearing cache..."
php bin/console cache:clear || true

echo " Running database migrations..."
php bin/console doctrine:migrations:migrate --no-interaction || true
