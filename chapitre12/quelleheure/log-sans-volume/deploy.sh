#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

kubectl replace --force -f quelleheure-log-sans-volume.yaml