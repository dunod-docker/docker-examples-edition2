#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Nettoyage de tous les volumes 
#ATTENTION: toutes les données seront perdues !
docker system prune -f
docker system prune --volumes -f