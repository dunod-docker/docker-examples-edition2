#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

# Mot de passe de la base de donnée
MYSQL_ROOT_PASSWORD=root

# Création du réseau
docker network create appex-network

# Création des volumes
docker volume create --name=appex-db-volume
docker volume create --name=appex-upload-files

# Destruction de conteneur préxistant
docker stop appex-db
docker stop appex-front-end
docker stop appex-back-end

# Démarrage de la base de données
docker run --rm -d --name appex-db -p 3306:3306 --net=appex-network -v appex-db-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} appex-multi/database
sleep 20

# Initialisation de la base de données
docker exec appex-db /bin/bash -c "/usr/bin/mysql -v -u root -p${MYSQL_ROOT_PASSWORD} < /schema.sql"

# Démarrage du front-end
docker run --rm -d --name appex-front-end -p 8080:8080 --net=appex-network -v appex-upload-files:/chargement appex-multi/front-end

# Démarrage du back-end
docker run --rm -d --name appex-back-end --net=appex-network -v appex-upload-files:/chargement appex-multi/back-end

#Nettoyage
docker system prune -f