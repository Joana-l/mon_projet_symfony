#!/bin/bash
set -e

echo "🚀 Entrypoint Symfony : démarrage..."

export APP_ENV=prod
export APP_DEBUG=0

# Lancer les migrations pour créer les tables
echo "🧱 Exécution des migrations Doctrine..."
php /var/www/html/bin/console doctrine:migrations:migrate --no-interaction --env=prod || true

# Nettoyer le cache Symfony (optionnel mais propre)
if [ -f /var/www/html/bin/console ]; then
  echo "🎯 Symfony détecté, on nettoie le cache..."
  php /var/www/html/bin/console cache:clear --env=prod --no-warmup || true
fi

# 🔧 Fix des droits après les commandes Symfony
chown -R www-data:www-data var

echo "🌐 Lancement d'Apache..."
exec apache2-foreground
