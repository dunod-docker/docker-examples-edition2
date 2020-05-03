# Chapitre 10

- [UN ENVIRONNEMENT DE BUILD LUI-MÊME DOCKERISÉ](#un-environnement-de-build-lui-mme-dockeris)
    - [Démarrage](#dmarrage)
    - [Arrêt](#arrt)
    - [Réinitialisation](#rinitialisation)
- [INSTALLATION DES OUTILS ET CHARGEMENT DU CODE SOURCE](#installation-des-outils-et-chargement-du-code-source)
    - [Configuration de Jenkins](#configuration-de-jenkins)
    - [Configuration du job dans Jenkins](#configuration-du-job-dans-jenkins)
        - [Etape du build](#etape-du-build)
        - [Action à la suite du build](#action--la-suite-du-build)
- [LANCEMENT AUTOMATIQUE](#lancement-automatique)
    - [Exemple de modification et déploiement](#exemple-de-modification-et-dploiement)
        - [Déploiement](#dploiement)
- [Liens (dans l'ordre d'apparition dans le chapitre)](#liens-dans-lordre-dapparition-dans-le-chapitre)

## UN ENVIRONNEMENT DE BUILD LUI-MÊME DOCKERISÉ

Les commandes de l'environnement de build:

### Démarrage
```
./run.sh
```

### Arrêt
```
./clean.sh
```

### Réinitialisation

Cette commande efface les volumes et les conteneurs précédemment stoppés.
Attention, elle entraine la perte de l'ensemble des données.
```
./run.sh
```

## INSTALLATION DES OUTILS ET CHARGEMENT DU CODE SOURCE

### Configuration de Jenkins

```
docker exec -ti jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### Configuration du job dans Jenkins

#### Etape du build

```
/opt/build/scripts/start-build.sh ${BUILD_TAG} 
/opt/build/scripts/build-java.sh ${BUILD_TAG} 
/opt/build/scripts/build-configure.sh ${BUILD_TAG} "DEV"
/opt/build/scripts/build-front-end-image.sh ${BUILD_TAG} 
```

#### Action à la suite du build

```
/opt/build/scripts/end-build.sh ${BUILD_TAG}
```

## LANCEMENT AUTOMATIQUE

### Exemple de modification et déploiement

#### Déploiement

```
docker inspect --format '{{ json .ContainerConfig.Labels}}' appex-multi/front-end
```


## Liens (dans l'ordre d'apparition dans le chapitre)

https://jenkins.io/

https://about.gitlab.com/

https://github.com/jpetazzo/dind

https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

https://search.maven.org/

