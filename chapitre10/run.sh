#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Build de l'image de build java
build-image/build.sh

#Démarrage
docker-compose up -d --build

#Nettoyage
docker system prune -f
