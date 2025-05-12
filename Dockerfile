FROM php:8.2-apache-bullseye

RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libzip-dev libpq-dev \
    && docker-php-ext-install intl pdo pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . .

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --prefer-dist --no-interaction --no-scripts

# Crée le dossier var manuellement
RUN mkdir -p var

# Applique les bons droits
RUN chown -R www-data:www-data var vendor

EXPOSE 80

