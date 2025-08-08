-- Script d'initialisation MySQL
-- Ce fichier sera exécuté automatiquement lors du premier démarrage

-- Créer une table d'exemple
USE mydatabase;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insérer des données d'exemple
INSERT INTO users (username, email) VALUES
('admin', 'admin@example.com'),
('user1', 'user1@example.com')
ON DUPLICATE KEY UPDATE username=username;