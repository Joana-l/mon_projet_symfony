#!/bin/bash
set -e

echo "🚀 Entrypoint Symfony : démarrage..."

# ⚙️ Définir l’environnement Symfony
export APP_ENV=prod
export APP_DEBUG=0

# ✅ S'assurer que les dossiers nécessaires existent
mkdir -p var/cache var/log

# 🧱 Lancer les migrations Doctrine (pour PostgreSQL sur Render)
echo "🧱 Exécution des migrations Doctrine..."
php /var/www/html/bin/console doctrine:migrations:migrate --no-interaction --env=prod || true

# 🎯 Nettoyer le cache Symfony
if [ -f /var/www/html/bin/console ]; then
  echo "🧹 Nettoyage du cache Symfony..."
  php /var/www/html/bin/console cache:clear --env=prod --no-warmup || true
fi

# 🔐 Fixer les permissions pour www-data (Apache)
echo "🔧 Fix des droits sur var/ et vendor/"
chown -R www-data:www-data var vendor

# 🌍 Lancement du serveur Apache en mode foreground
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
