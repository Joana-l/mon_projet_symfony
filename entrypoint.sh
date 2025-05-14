#!/bin/bash
set -e

echo "🚀 Entrypoint Symfony : démarrage..."

# Force les variables d'environnement si besoin
export APP_ENV=prod
export APP_DEBUG=0

# Lancer le cache:clear
if [ -f /var/www/html/bin/console ]; then
  echo "🎯 Symfony détecté, on nettoie le cache..."
  php /var/www/html/bin/console cache:clear --env=prod --no-warmup || true
fi

# Démarrer Apache
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
