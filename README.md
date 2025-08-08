# MySQL pour Coolify

Ce projet configure une base de données MySQL optimisée pour le déploiement sur Coolify.

## Structure du projet

- `Dockerfile` : Image Docker personnalisée basée sur MySQL 8.0
- `docker-compose.yml` : Configuration pour le développement local
- `.env.example` : Variables d'environnement d'exemple
- `coolify.yml` : Configuration spécifique pour Coolify

## Développement local

1. Copiez le fichier d'environnement :
   ```bash
   cp .env.example .env
   ```

2. Modifiez les variables dans `.env` selon vos besoins

3. Lancez le service :
   ```bash
   docker-compose up -d
   ```

4. Accédez à phpMyAdmin sur http://localhost

## Déploiement sur Coolify

### Option 1: Déploiement avec deux services séparés (Recommandé)

#### Service MySQL
1. Créez un nouveau service "Database" dans Coolify
2. Utilisez l'image `mysql:8.0`
3. Configurez les variables d'environnement :
   - `MYSQL_ROOT_PASSWORD`
   - `MYSQL_DATABASE`
   - `MYSQL_USER` 
   - `MYSQL_PASSWORD`
4. Ajoutez un volume persistant pour `/var/lib/mysql`
5. Exposez le port 3306 en interne uniquement

#### Service phpMyAdmin
1. Créez un nouveau service "Web" dans Coolify
2. Utilisez l'image `phpmyadmin/phpmyadmin:latest`
3. Configurez le domaine : `phpmyadmin.devci.net`
4. Configurez les variables d'environnement :
   - `PMA_HOST` : nom du service MySQL
   - `PMA_PORT` : `3306`
   - `MYSQL_ROOT_PASSWORD` : même valeur que MySQL
   - `PMA_ABSOLUTE_URI` : `https://phpmyadmin.devci.net/`
5. Définissez une dépendance vers le service MySQL

### Option 2: Déploiement direct depuis un dépôt Git

1. Dans Coolify, créez une nouvelle application
2. Connectez votre dépôt Git
3. Utilisez le fichier `docker-compose.yml` fourni
4. Définissez les variables d'environnement
5. Configurez le domaine `phpmyadmin.devci.net` pour le service phpMyAdmin
6. Déployez l'application

## Variables d'environnement

| Variable | Description | Valeur par défaut |
|----------|-------------|-------------------|
| `MYSQL_ROOT_PASSWORD` | Mot de passe root MySQL | `rootpassword` |
| `MYSQL_DATABASE` | Nom de la base de données | `mydatabase` |
| `MYSQL_USER` | Nom d'utilisateur MySQL | `myuser` |
| `MYSQL_PASSWORD` | Mot de passe utilisateur | `mypassword` |

## Volumes

- `/var/lib/mysql` : Données MySQL (persistantes)
- `/docker-entrypoint-initdb.d` : Scripts d'initialisation (optionnel)

## Ports

- `3306` : Port MySQL standard

## Sécurité

⚠️ **Important** : Changez toujours les mots de passe par défaut en production !

## Sauvegarde

Pour sauvegarder votre base de données :

```bash
docker exec mysql-coolify mysqldump -u root -p[password] [database] > backup.sql
```

## Restauration

Pour restaurer une sauvegarde :

```bash
docker exec -i mysql-coolify mysql -u root -p[password] [database] < backup.sql
```