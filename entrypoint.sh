#!/bin/bash

set -e  # Stoppe le script si une commande échoue

echo "🚀 Entrypoint Symfony : démarrage..."

# Force le mode prod
export APP_ENV=prod
export APP_DEBUG=0

# 🧱 Exécution des migrations (sécurisée)
echo "🧱 Lancement des migrations Doctrine..."

if php /var/www/html/bin/console doctrine:migrations:migrate --no-interaction --env=prod; then
  echo "✅ Migrations effectuées avec succès."
else
  echo "❌ Erreur lors des migrations. Arrêt du déploiement."
  exit 1
fi


# 🧹 Nettoyage du cache Symfony
if [ -f /var/www/html/bin/console ]; then
  echo "🎯 Symfony détecté, on nettoie le cache..."
  php /var/www/html/bin/console cache:clear --env=prod --no-warmup
fi

# 🔧 Permissions
chown -R www-data:www-data var

# 📁 Création du dossier upload directement dans public
echo "📁 Création du dossier public/uploads/realisation..."
mkdir -p /var/www/html/public/uploads/realisation

# 🛡️ Permissions max (temporaire mais efficace)
chmod -R 777 /var/www/html/public/uploads


# 🌐 Démarrage du serveur web
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
