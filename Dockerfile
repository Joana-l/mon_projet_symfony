FROM php:8.2-apache-bullseye

RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libzip-dev libpq-dev \
    && docker-php-ext-install intl pdo pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

WORKDIR /var/www/html

# 👉 Config minimale d’Apache pour Symfony
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

COPY . .

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# ✅ Installation safe (sans scripts auto)
RUN composer install --no-dev --prefer-dist --no-interaction --no-scripts

# Créer le dossier var pour les caches et logs
RUN mkdir -p var
RUN chown -R www-data:www-data var vendor

EXPOSE 80



