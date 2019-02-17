# Chapitre 12

- [PRISE EN MAIN](#prise-en-main)
    - [IMPORTANT : Installation des exemples](#important--installation-des-exemples)
    - [Kubectl :  la CLI de Kubernetes](#kubectl---la-cli-de-kubernetes)
    - [Un exemple simple](#un-exemple-simple)
    - [Un descripteur Kubernetes](#un-descripteur-kubernetes)
- [DECOUVERTE DES FONCTIONNALITES](#decouverte-des-fonctionnalites)
    - [Ajout d’un état : écriture sur un volume host](#ajout-dun-tat--criture-sur-un-volume-host)
        - [Lancement du pod et description](#lancement-du-pod-et-description)
        - [Ajoutons un volume](#ajoutons-un-volume)
    - [Influencer le scheduler Kubernetes : les labels](#influencer-le-scheduler-kubernetes--les-labels)
        - [Définition d’un label](#dfinition-dun-label)
        - [Définition des exigences pour un pod](#dfinition-des-exigences-pour-un-pod)
    - [Persistent volumes : la persistance gérée par Kubernetes](#persistent-volumes--la-persistance-gre-par-kubernetes)
        - [Création du secret Kubernetes pour l’authentification](#cration-du-secret-kubernetes-pour-lauthentification)
        - [Création des objets Kubernetes et du Pod](#cration-des-objets-kubernetes-et-du-pod)
    - [Haute disponibilité basique et avancée](#haute-disponibilit-basique-et-avance)
        - [Résilience automatique](#rsilience-automatique)
        - [Réplicas : gestion de plusieurs pods au sein d’un même déploiement](#rplicas--gestion-de-plusieurs-pods-au-sein-dun-mme-dploiement)
        - [Services : répartition de charge](#services--rpartition-de-charge)
        - [Auto-scaling : montée et répartition de charge automatique](#auto-scaling--monte-et-rpartition-de-charge-automatique)
- [DÉPLOIEMENT DE L’APPLICATION EXEMPLE](#dploiement-de-lapplication-exemple)
    - [Nettoyage](#nettoyage)
    - [Build et publication des images](#build-et-publication-des-images)
    - [Création des volumes](#cration-des-volumes)
    - [Configuration et déploiement des composants](#configuration-et-dploiement-des-composants)
        - [Pre-initialisation de la base de données](#pre-initialisation-de-la-base-de-donnes)
        - [Lancement des autres composants et test](#lancement-des-autres-composants-et-test)
- [Liens (dans l'ordre d'apparition dans le chapitre)](#liens-dans-lordre-dapparition-dans-le-chapitre)

## PRISE EN MAIN

### IMPORTANT : Installation des exemples

Attention : il est important de bien remplir le fichier ```configuration.env``` puis de rendre exécutable le fichier ```setup.sh``` à l'aide de la commande suivante:
```
chmod u+x setup.sh
``` 

Pour les paramètres STORAGE_ACCOUNT_NAME et STORAGE_ACCOUNT_KEY, veuillez-vous reporter aux pages 274-275 qui expliquent la création d'un Azure Storage Account.
Celle-ci nécessite comme l'usage d'Azure Kubernetes Service un accès à un compte Azure et au portail https://portal.azure.com.

Pour le paramètre DOCKER_HUB_ACCOUNT, entrez le "login" de votre compte DockerHub (https://hub.docker.com/).
Le mot de passe vous sera demandez au lancement des scripts qui effectuent des "push" vers votre registry.
Attention, toutes ces images sont publiques par défaut, ne publiez rien qui soit secret.

Pour installer ```kubectl``` pour Azure, veuillez vous reporter aux liens suivants:
* https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest : décrit l'installation de la ligne de commande az
* https://docs.microsoft.com/en-us/cli/azure/ext/aks-preview/aks?view=azure-cli-latest :
  * explique comment installer ```kubectl``` à l'aide de la commande:
  ```
  az aks install-cli
  ```
  * explique les instructions pour obtenir les "credentials" (paramètres d'authentification pour AKS) à l'aide de la commande:
  ```
  az aks get-credentials
  ```

### Kubectl :  la CLI de Kubernetes

```
kubectl version
```

```
kubectl get componentstatuses
```

```
kubectl get nodes
```

### Un exemple simple

Dans ```chapitre12/quelleheure/prise-en-main```:
```
./build.sh
./deploy.sh
```

```
kubectl get pods
```

Connection au pod:
```
kubectl port-forward quelleheure 8090:80
```

visualiser les logs:
```
kubectl logs -f  quelleheure
```

### Un descripteur Kubernetes

Effacement du pod:
```
kubectl delete pod quelleheure
```

## DECOUVERTE DES FONCTIONNALITES

### Ajout d’un état : écriture sur un volume host

#### Lancement du pod et description

Dans ```chapitre12/quelleheure/log-sans-volume```:
```
./build.sh
./deploy.sh
```

```
kubectl describe pods quelleheure
```

```
kubectl port-forward quelleheure 8090:80
```

Redémarrage:
```
kubectl delete pods quelleheure
kubectl apply -f quelleheure-log-sans-volume.yaml
```

#### Ajoutons un volume

Dans ```chapitre12/quelleheure/log-volume-host```:
```
./build.sh
./deploy.sh
```
Attention, le fichier ```deploy.sh``` contient l'instruction utilisant le modificateur ```--force```.

```
kubectl port-forward quelleheure 8090:80
```

### Influencer le scheduler Kubernetes : les labels

#### Définition d’un label

Affichage de la liste des nodes:
```
kubectl get nodes
```

Marquage de l'un de nodes:
```
kubectl label nodes <<nom de l'un de vos nodes>> log=ok
```

```
kubectl get nodes --show-labels
```

#### Définition des exigences pour un pod

Dans ```chapitre12/quelleheure/labels```:
```
./deploy.sh
```

```
kubectl get pods -o wide
```

Se connecter pour effacer le fichier de log:
```
kubectl exec -ti quelleheure /bin/bash
```

### Persistent volumes : la persistance gérée par Kubernetes

#### Création du secret Kubernetes pour l’authentification

Création du volume persistant.
Dans ```chapitre12/quelleheure/persistent-volume```:
```
./create-azure-secret.sh
```

#### Création des objets Kubernetes et du Pod

Dans ```chapitre12/quelleheure/persistent-volume```:
```
./deploy-pv.sh
./deploy-pvc.sh
./deploy-pod.sh
```

```
kubectl describe  pods quelleheure
```

### Haute disponibilité basique et avancée

#### Résilience automatique

Connection au pod pour "détruire" un processus apache:
```
kubectl exec -ti quelleheure /bin/bash
```

```
kubectl get pods -o wide
```

IMPORTANT :
```
kubectl delete pod quelleheure
```

#### Réplicas : gestion de plusieurs pods au sein d’un même déploiement

IMPORTANT :
```
kubectl delete pod quelleheure
```

Dans ```chapitre12/quelleheure/deployment```:
```
./deploy-deployment.sh
```

#### Services : répartition de charge

Dans ```chapitre12/quelleheure/deployment```:
```
./deploy-service.sh
```

```
kubectl get pods -o wide
```

```
kubectl get services quelleheure-service --watch
```

#### Auto-scaling : montée et répartition de charge automatique

```
kubectl autoscale deployment quelleheure-deployment --cpu-percent=50 --min=1 --max=5
```

## DÉPLOIEMENT DE L’APPLICATION EXEMPLE

### Nettoyage

Dans ```chapitre12/application-exemple```:
```
kubectl delete service quelleheure-service
kubectl delete deployments --all
kubectl delete pvc shared-volume-claim
kubectl delete pyv shared-volume
```

### Build et publication des images

Dans ```chapitre12/application-exemple```:
```
./build.sh
./push-imnages.sh
```

### Création des volumes

Dans ```chapitre12/application-exemple\deploy```:
```
kubectl apply -f creation-volume.yaml
```

```
kubectl get pv
kubectl get pvc
```

### Configuration et déploiement des composants

#### Pre-initialisation de la base de données

Dans ```chapitre12/application-exemple\deploy```:
```
./init-db.sh
```

Après l'exécution de l'initialisation de la base de donnée, nous n'avons plus besoin du pod:
```
kubectl delete pod init-db
```

#### Lancement des autres composants et test

Dans ```chapitre12/application-exemple\deploy```:
```
kubectl apply -f creation-database-service.yaml
kubectl apply -f creation-front-end.yaml
kubectl apply -f creation-back-end.yaml
```

```
kubectl get service
```

## Liens (dans l'ordre d'apparition dans le chapitre)

https://kubernetes.io/docs/setup/minikube/

https://kubernetes.io/docs/setup/independent/install-kubeadm/

https://azure.microsoft.com/en-us/services/kubernetes-service/ 

https://kubernetes.io/docs/reference/kubectl/

https://kubernetes.io/docs/concepts/configuration/overview/

https://code.visualstudio.com/

https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes

https://docs.microsoft.com/en-us/azure/aks/azure-disks-dynamic-pv 

https://severalnines.com/blog/mysql-docker-running-galera-cluster-kubernetes 

