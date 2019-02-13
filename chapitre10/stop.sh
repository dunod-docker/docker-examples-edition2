#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Stop les conteneurs mais conserve les volumes
docker-compose down
