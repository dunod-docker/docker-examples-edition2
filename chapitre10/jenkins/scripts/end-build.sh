#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

set -e

# $1 : le nom du build jenkins (un identifiant unique)
BUILD_ID=$1

echo -e "*********** Destruction du répertoire de build ${BUILD_ID} ***********"
rm -rf /opt/build/jobs/${BUILD_ID}