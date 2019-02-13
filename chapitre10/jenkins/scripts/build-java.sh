#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

set -e

# $1 : le nom du build jenkins (un identifiant unique)
BUILD_ID=$1

cd /opt/build/jobs/${BUILD_ID}

git clone http://gitlab/root/appex-front-end.git

# Compilation java
sudo docker run --rm -i --env BUILD_ID=${BUILD_ID} --env PROJECT_NAME=appex-front-end -v chapitre10_ci-jenkins-build:/opt/build appex-build-java
