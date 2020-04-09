#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

set -e

# $1 : le nom du build jenkins (un identifiant unique)
BUILD_ID=$1

cp Dockerfile /opt/build/jobs/${BUILD_ID}/output
sudo docker build -t appex-multi/front-end --label build=${BUILD_ID} /opt/build/jobs/${BUILD_ID}/output