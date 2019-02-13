#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

docker stop appex-supervisor

docker run --rm -d -p 8080:8080 -p 9001:9001 --name=appex-supervisor appex-supervisor