#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Création du pod utilisant les resources précédentes
kubectl replace --force -f quelleheure-persistent-volume.yaml
