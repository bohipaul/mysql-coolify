FROM mysql:8.0

# Définir les variables d'environnement par défaut
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

# Copier les scripts d'initialisation personnalisés (optionnel)
# COPY ./init/ /docker-entrypoint-initdb.d/

# Copier la configuration MySQL personnalisée (optionnel)
# COPY ./config/my.cnf /etc/mysql/conf.d/

# Exposer le port MySQL
EXPOSE 3306

# Le point d'entrée et la commande sont hérités de l'image mysql de base