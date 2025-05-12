# Image de base avec Apache
FROM php:8.2-apache-bullseye

# Installe les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libzip-dev \
    && docker-php-ext-install intl pdo pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Active mod_rewrite pour Symfony
RUN a2enmod rewrite

# Crée le dossier de travail
WORKDIR /var/www/html

# Copie tout le code Symfony dans le conteneur
COPY . .

# Installe Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Installe les dépendances Symfony (une fois que le code est là)
RUN composer install --no-dev --prefer-dist --no-interaction

# Met les bons droits
RUN chown -R www-data:www-data var vendor

# Expose le port HTTP
EXPOSE 80
