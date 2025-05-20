-- Supprimer toutes les tables existantes avant de relancer les migrations
DROP TABLE IF EXISTS realisation CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS messenger_messages CASCADE;
DROP TABLE IF EXISTS doctrine_migration_versions CASCADE;
DROP FUNCTION IF EXISTS notify_messenger_messages() CASCADE;
