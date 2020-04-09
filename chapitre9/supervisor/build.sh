#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

# Compilation de l'application front-end
 ../../application-exemple/build/basique/build.sh
sudo chown $(whoami):$(whoami) *.jar

# Copie du schema SQL
cp ../../application-exemple/database/schema.sql .

# Copie de l'application back-end python
cp ../../application-exemple/back-end/main.py .
cp ../../application-exemple/back-end/config.json .

# Création de l'image supervisor
docker build --build-arg MYSQL_ROOT_PASSWORD=root -t appex-supervisor .

# Nettoyage
rm schema.sql
rm main.py
rm config.json
rm *.jar
docker system prune -f

