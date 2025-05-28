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

# 📁 Création du dossier d'uploads utilisé par VichUploaderBundle
echo "📁 Création du dossier var/uploads/realisation..."
mkdir -p /var/www/html/var/uploads/realisation

# 🛡️ Autoriser l'écriture dans ce dossier
echo "🔧 Correction des permissions sur var/uploads..."
chmod -R 775 /var/www/html/var/uploads

# 🔗 Création du lien symbolique
echo "🔗 Création du lien symbolique public/uploads vers var/uploads..."
ln -sf ../../var/uploads /var/www/html/public/uploads

# 🌐 Démarrage du serveur web
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
