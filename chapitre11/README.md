# Chapitre 11

## DOCKER SWARM

### Mise en œuvre d’un cluster Swarm

#### Lancement de vagrant (création des VMs)

```
vagrant up
vagrant global-status
```

#### Création du cluster

Connection au master:
```
vagrant ssh swarm-master
```

Création du cluster:
```
docker swarm init --advertise-addr=10.100.192.200
```

#### Connection aux différents "slave" (01 et 02)

Connection au slave 01 (précéder en changeant le numéro pour le 02):
```
vagrant ssh swarm-slave-01
```

Connection au cluster:
```
Utilisez la commande qui a été affichée lors de la création du cluster
```

## PREMIER SERVICE ET STACK

### Service et montée en charge

Création de 3 conteneurs nginx:
```
docker run -d -p 80 --name=nginx-1 nginx
docker run -d -p 80 --name=nginx-2 nginx
docker run -d -p 80 --name=nginx-3 nginx
```

Affichage du résultat:
```
docker ps --format "table {{.ID}} {{.Status}} {{.Ports}} {{.Names}}"
```

Suppression d'un conteneur:
```
docker rm -f nginx-1
docker ps --format "table {{.ID}} {{.Status}} {{.Ports}} {{.Names}}"
```

Suppression des conteneurs et installation d'un service:
```
docker rm -f $(docker ps -a | grep nginx | awk '{print $1}')
docker service create --replicas=3 --name nginx-service nginx
```

Affichage du résultat:
```
docker service ps nginx-service --format "table {{.ID}} {{.Name}} {{.Node}} {{.CurrentState}}"
```

Identification d'un conteneur à effacer
```
docker ps --filter "ancestor=nginx" --format "table {{.ID}} {{.Names}}"
docker rm <<identifiant d'un conteneur trouvé avec l'instruction ci-dessus>>
```

Augmentation à 4 conteneurs:
```
docker service scale nginx-service=4
```

Affichage du résultat:
```
docker service ps nginx-service --format "table {{.ID}} {{.Name}} {{.Node}} {{.DesiredState}} "
```

### Le réseau overlay

```
docker network ls
```

Création d'un nouveau réseau overlay:
```
docker network create -d overlay nginx-overlay
docker service create --name nginx-overlay --replicas=2 --network=nginx-overlay --publish published=8080,target=80 nginx
```

Affichage du résultat:
```
docker service ps nginx-overlay --format "table {{.ID}} {{.Name}} {{.Node}} {{.DesiredState}}"
```

Requête sur le slave 2:
```
curl http://$(docker node inspect swarm-slave-02 --format "{{.Status.Addr}}"):8080
```

### La stack Docker

Démarrage:
```
docker stack deploy -c docker-compose.yml stack-dunod
```

Affichage du résultat:
```
docker stack ps stack-dunod --format "table {{.ID}} {{.Name}} {{.Node}} {{.DesiredState}}"
```

## GESTION DE CONFIGURATION

### Gestion de configuration

Création:
```
docker config create nginx-config http.conf
```

Mise à jour du service:
```
docker stack deploy -c docker-compose-config.yml stack-dunod
```

Inspection à l'intérieur du conteneur:
```
docker ps
docker exec -it <<nom du conteneur fourni par l'instruction ci-desssus>> /bin/bash
```

### Gestion de secrets

Création:
```
docker secret create site.key nginx/site.key 
docker secret create site.crt nginx/site.crt
docker config create nginx-config-ssl nginx/ssl.conf
```

Déploiement:
```
docker stack deploy -c docker-compose-config-secret.yml stack-dunod
```

## Liens (dans l'ordre d'apparition dans le chapitre)

https://github.com/docker/swarm/blob/master/scheduler/strategy/weighted_node.go

https://docs.docker.com/engine/swarm/ingress/

http://www.haproxy.org/

https://docs.docker.com/compose/compose-file

