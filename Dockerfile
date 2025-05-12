# Étape 1 : Composer + Build
FROM composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction

# Étape 2 : PHP + Apache sécurisé
FROM php:8.2-apache-bullseye

# Installe les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install intl pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Active mod_rewrite pour Symfony
RUN a2enmod rewrite

# Crée un dossier propre
WORKDIR /var/www/html

# Copie les sources de l'application
COPY . .

# Copie les vendors depuis l'étape précédente
COPY --from=vendor /app/vendor /var/www/html/vendor

# Met les bons droits
RUN chown -R www-data:www-data var vendor

# Expose le port 80
EXPOSE 80
