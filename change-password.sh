#!/bin/bash

# Script pour changer le mot de passe MySQL root après déploiement
# Usage: ./change-password.sh <nouveau_mot_de_passe>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <nouveau_mot_de_passe>"
    echo "Exemple: $0 mon_nouveau_mot_de_passe_securise"
    exit 1
fi

NEW_PASSWORD="$1"
CONTAINER_NAME="mysql-coolify"

echo "Changement du mot de passe root MySQL..."

# Changer le mot de passe root
docker exec -it $CONTAINER_NAME mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_PASSWORD';"
docker exec -it $CONTAINER_NAME mysql -u root -p -e "ALTER USER 'root'@'%' IDENTIFIED BY '$NEW_PASSWORD';"
docker exec -it $CONTAINER_NAME mysql -u root -p -e "FLUSH PRIVILEGES;"

echo "Mot de passe changé avec succès !"
echo "Pensez à mettre à jour la variable d'environnement MYSQL_ROOT_PASSWORD dans Coolify"