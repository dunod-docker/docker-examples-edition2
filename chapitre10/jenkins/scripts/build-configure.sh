#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

set -e

# $1 : le nom du build jenkins (un identifiant unique)
BUILD_ID=$1
# $2 : l'environnement cible (DEV, QA, PROD)
TARGET_ENV=$2

cd /opt/build/jobs/${BUILD_ID}

git clone http://gitlab/root/appex-front-end-configuration.git

cp appex-front-end-configuration/${TARGET_ENV}_application.properties /opt/build/jobs/${BUILD_ID}/output/application.properties
