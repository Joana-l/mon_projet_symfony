# Étape 1 : Builder avec composer uniquement les vendors
FROM composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction

# Étape 2 : PHP + Apache
FROM php:8.2-apache-bullseye

# Installe les dépendances système + extensions PHP
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libzip-dev \
    && docker-php-ext-install intl pdo pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Active mod_rewrite pour Apache (obligatoire avec Symfony)
RUN a2enmod rewrite

# Copie le projet dans le container
WORKDIR /var/www/html
COPY . .

# Copie les vendors depuis l’étape précédente
COPY --from=vendor /app/vendor /var/www/html/vendor

# Met les bons droits
RUN chown -R www-data:www-data var vendor

# Pas de cache:clear ici ! Symfony le fera automatiquement au premier accès.

# Port exposé
EXPOSE 80


