#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)
CURRENT_USER=$(id -u)

cd $BASEDIR

echo "********************************"
echo " Copie du code source du projet "
echo "********************************"
cp -R ../../front-end .

echo "***********************************"
echo " Build de l'image de build basique "
echo "***********************************"
docker build -t build-basique .

echo "********************************"
echo " Lancement du build "
echo "********************************"
docker run --rm -ti -v $ORIGINDIR:/opt/output build-basique

echo "********************************"
echo " Nettoyage "
echo "********************************"
rm -rf front-end
docker system prune -f

