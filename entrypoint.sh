#!/bin/bash
set -e

echo "🚀 Entrypoint Symfony : démarrage..."

# ⚙️ Définir l’environnement Symfony
export APP_ENV=prod
export APP_DEBUG=0

# ✅ S'assurer que les dossiers nécessaires existent
mkdir -p var/cache var/log

echo "🧹 Suppression de l'historique des migrations..."
psql "$DATABASE_URL" -f /var/www/html/sql/reset_sql.sql || true


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

echo "👤 Insertion de l'admin en base si inexistant..."

php /var/www/html/bin/console doctrine:query:sql "
INSERT INTO \"user\" (email, roles, password)
SELECT 'aleaurulleau33@hotmail.com', '[\"ROLE_ADMIN\"]', '\$2y\$13\$0IWENipVZmnIur.7i75vzen6amLhJi6FI7o1.uFdo3YLRaW4F8rNG'
WHERE NOT EXISTS (
  SELECT 1 FROM \"user\" WHERE email = 'aleaurulleau33@hotmail.com'
);
" || true


# 🌍 Lancement du serveur Apache en mode foreground
echo "🌐 Lancement d'Apache..."
exec apache2-foreground
