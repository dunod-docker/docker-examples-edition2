#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

# Mot de passe de la base de donnée
MYSQL_ROOT_PASSWORD=root

# Compilation de l'application front-end
../../application-exemple/build/basique/build.sh
sudo chown $(whoami):$(whoami) *.jar
mv *.jar front-end
cp ../../application-exemple/front-end/config-a-remplacer/application.properties front-end
python ../../application-exemple/build/replacer/replacer.py global.properties front-end/application.properties

# Copie du schema SQL
cp ../../application-exemple/database/schema.sql database

# Copie de l'application back-end python
cp ../../application-exemple/back-end/main.py back-end
cp ../../application-exemple/back-end/config-a-remplacer/config.json back-end
python ../../application-exemple/build/replacer/replacer.py global.properties back-end/config.json

# Build de l'image "base de données"
docker build -t appex-multi/database database

# Build du front-end
docker build -t appex-multi/front-end front-end

# Build du back-end
docker build -t appex-multi/back-end back-end

# Nettoyage
rm database/schema.sql
rm back-end/main.py
rm back-end/config.json
rm front-end/application.properties
rm front-end/*.jar
docker system prune -f

