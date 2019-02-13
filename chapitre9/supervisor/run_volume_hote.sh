#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

docker stop appex-supervisor

mkdir -p database
mkdir -p chargement

docker run --rm -d -p 8080:8080 -p 9001:9001 -v ${PWD}/chargement:/chargement -v ${PWD}/database:/var/lib/mysql --name=appex-supervisor appex-supervisor
