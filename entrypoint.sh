#!/bin/bash

set -e

# Lancer le cache:clear au démarrage si possible
if [ -f /var/www/html/bin/console ]; then
    echo "🎯 Clearing Symfony cache..."
    php /var/www/html/bin/console cache:clear --env=prod --no-warmup || true
fi

# Lancer Apache
apache2-foreground
