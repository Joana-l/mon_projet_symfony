FROM php:8.2-apache-bullseye

RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libzip-dev libpq-dev \
    && docker-php-ext-install intl pdo pdo_pgsql zip session opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers

WORKDIR /var/www/html

# ✅ Configuration Apache (plus propre avec EOF)
RUN cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

   <IfModule mod_headers.c>
        Header always edit Set-Cookie ^(.*)$ "$1; HttpOnly; SameSite=Lax"
   </IfModule>

</VirtualHost>
EOF

COPY . .

COPY .env.local.php .env.local.php

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --prefer-dist --no-interaction --no-scripts

RUN mkdir -p var/cache var/log
RUN chown -R www-data:www-data var vendor

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
