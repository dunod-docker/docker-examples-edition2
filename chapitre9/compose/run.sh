#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Copie du fichier d'initialisation de la base de donnée
cp ../../application-exemple/database/schema.sql initdb

#Démarrage
docker-compose up -d --build

#Nettoyage
rm initdb/schema.sql
docker system prune -f