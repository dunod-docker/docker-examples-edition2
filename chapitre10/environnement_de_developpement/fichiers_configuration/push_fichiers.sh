#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

# Clone le repository (qui doit avoir été créé précédemment dans GitLab) et pousse les fichiers de configuration du front-end
# Celui-ci pourra ensuite être modifié ici même

git clone http://localhost/root/appex-front-end-configuration.git

# Nous fabriquons plusieurs environnement à partir du même fichier initial à titre d'exemple
# Dans la réalité ces fichiers seraient différents
cp application.properties appex-front-end-configuration/DEV_application.properties
cp application.properties appex-front-end-configuration/QA_application.properties
cp application.properties appex-front-end-configuration/PROD_application.properties

cd appex-front-end-configuration

git config --global push.default matching

git add --all
git commit -m "Initial commit"
git push origin master
