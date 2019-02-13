# Chapitre 4

## Commandes

### Créer et démarrer un conteneur (commande run)
```
docker run -p 8000:80 -d nginx
```

### Stopper un conteneur (commande stop ou kill)
```
docker ps
docker stop <<id du conteneur>>
ls /var/lib/docker/containers/
docker ps -a
docker start <<id ou nom du conteneur>>
```

### Détruire un conteneur (commande rm)
```
docker rm <<id ou nom du conteneur>>
docker stop <<id ou nom du conteneur>>
docker rm <<id ou nom du conteneur>>
```

### La commande create
```
docker create -p 8000:80 nginx
docker ps -a
docker start <<id ou nom du conteneur>>
```

### Connexion en mode terminal
```
docker run -d -p 8000:80 --name webserver nginx
docker exec -t -i webserver /bin/bash
hostname
ls
echo "Je suis dedans" > /usr/share/nginx/html/index.html
exit
```

### Créer un volume
```
docker run -p 8000:80 --name webserver -d -v /usr/share/nginx/html  nginx
docker inspect webserver
sudo ls /var/lib/docker/volumes
sudo su 
$ echo "Je modifie un volume" > /var/lib/docker/volumes
/<<id du conteneur>>/_data/index.html
exit
```

### Monter un répertoire de notre hôte dans un conteneur
```
mkdir -p /home/vagrant/workdir/chapitre4
docker run -p 8000:80 --name webserver -d -v /home/vagrant/workdir/chapitre4:/usr/share/nginx/html nginx
cd /home/vagrant/workdir/chapitre4
echo "Un fichier sur le host" > index.html
```

### La configuration des ports IP
```
docker run -d -p 8000:80 --name webserver nginx
docker inspect webserver
docker rm -f webserver
docker run -P --name webserver -d nginx
docker ps
```

### Lister les images
```
docker images
docker images -a
```

### Charger et effacer des images
```
docker rmi nginx
docker pull nginx:1.7
docker run -p 8000:80 --name webserver17 -d nginx:1.7
docker run -p 8001:80 --name webserver19 -d nginx
```

### Créer une image à partir d’un conteneur
```
docker run -p 8000:80 --name webserver -d nginx
docker exec -i -t  webserver /bin/bash
docker commit webserver nginxhello
docker run -p 8001:80 --name webserverhello -d nginxhello
```

### LE DOCKERFILE
```
FROM nginx:1.7
COPY index.html /usr/share/nginx/html/index.html
```

```
docker build -t nginxhello .
docker run -p 8000:80 --name webserver -d nginxhello
docker history nginxhello
```

## Liens (dans l'ordre d'apparition dans le chapitre)
http://nginx.org/

https://www.ietf.org/rfc/rfc4122.txt

https://github.com/docker/docker/blob/master/pkg/namesgenerator/names-generator.go

http://www.json.org/
