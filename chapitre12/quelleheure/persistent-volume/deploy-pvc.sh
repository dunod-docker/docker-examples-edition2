#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

#Création du "claim" pour le volume persistant
kubectl apply -f quelleheure-pvc.yaml

#Attention ne lancez pas immédiatement le déploiement du pod
#Vérifiez avant que le pv a été créé correctement
#$ kubectl get pvc