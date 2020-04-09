#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Création du volume persistant
kubectl apply -f quelleheure-pv.yaml

#Attention ne lancez pas immédiatement le déploiement du pvc
#Vérifiez avant que le pv a été créé correctement
#$ kubectl get pv