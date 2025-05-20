#!/bin/bash

set -e

echo "🚀 Entrypoint Symfony : démarrage..."

# Assure que Symfony est bien en prod
export APP_ENV=prod
export APP_DEBUG=0

# 📦 Lancer les migrations Doctrine
echo "🧱 Exécution des migrations Doctrine..."
php /var/www/html/bin/console doctrine:migrations:migrate --no-interaction --env=prod || true

# 👤 Création d’un admin si non présent (email + mot de passe hashé)
echo "👤 Vérification de l'admin..."

psql "$DATABASE_URL" <<EOF
INSERT INTO "user" (email, roles, password)
VALUES (
  'aleaurulleau33@hotmail.com',
  '["ROLE_ADMIN"]',
  '\$2y\$13\$0IWENipVZmnIur.7i75vzen6amLhJi6FI7o1.uFdo3YLRaW4F8rNG'
)
ON CONFLICT (email) DO NOTHING;
EOF

# 🧹 Nettoyage du cache Symfony
if [ -f /var/www/html/bin/console ]; then
  echo "🎯 Symfony détecté, on nettoie le cache..."
  php /var/www/html/bin/console cache:clear --env=prod --no-warmup || true
fi

# 🔧 Permissions
chown -R www-data:www-data var

# 🌐 Démarrage Apache
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
