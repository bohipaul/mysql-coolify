-- Script pour permettre le changement de mot de passe MySQL
-- Ce script s'exécute avant les autres scripts d'initialisation

-- Permettre les connexions avec mot de passe vide temporairement si nécessaire
-- et préparer pour les changements de mot de passe

-- Créer un utilisateur admin avec tous les privilèges si pas déjà existant
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD:-adminpassword}';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;

-- S'assurer que l'utilisateur root peut se connecter depuis n'importe où
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Recharger les privilèges
FLUSH PRIVILEGES;