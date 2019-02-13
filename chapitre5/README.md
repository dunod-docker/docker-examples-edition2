# Chapitre 5

## Commandes

### INTRODUCTION À LA CLI  DOCKER

#### Les variables d’environnement Docker
```
mkdir -p /home/vagrant/alt_docker_config/ 
tee /home/vagrant/alt_docker_config/config.json <<-'EOF'
{
  "psFormat":"table {{.ID}}\\t{{.Image}}\\t{{.Command}}\\t{{.Ports}}\\t{{.Status}}"
}
EOF
export DOCKER_CONFIG=/home/vagrant/alt_docker_config/
docker ps
```

### LES COMMANDES SYSTÈME

#### docker ps / docker container ls
```
docker rm $(docker ps -a -q)
```

#### docker create et docker run 
```
docker create -name=webserver nginx
docker start webserver
docker run -t -i centos:7 /bin/bash
```

### INTERACTIONS AVEC UN CONTENEUR DÉMARRÉ

#### docker logs / docker container logs
```
docker run -d --name loop php php -r "while(true){echo \"Log something every 2 sec\n\";sleep(2);}"
docker ps
docker run -d --log-driver syslog --name loop php php -r "while(true){echo \"Log something every 2 sec\n\";sleep(2);}"
sudo tail -f /var/log/messages
```

#### docker exec / docker container exec
```
docker run -d --name webserver nginx
docker exec -t -i webserver /bin/bash
```

#### docker attach / docker container attach
```
docker run -d -p 8000:80 --name webserver nginx
docker attach --sig-proxy=false  webserver
```

#### docker cp / docker container cp
```
docker run -d -p 8000:80 --name webserver nginx
docker cp webserver:/usr/share/nginx/html/index.html .
echo "Hello World" > index.html
docker cp index.html webserver:/usr/share/nginx/html/index.html
```

#### docker diff / docker container diff
```
docker run -t -i --name exemple centos:7 /bin/bash
docker diff exemple
echo "Hello" > test.txt
docker diff exemple
```

#### docker export / docker container export
```
docker run -d --name webserver nginx
docker export webserver > test.tar
```

#### docker save et docker load / docker image save et docker image load
```
docker save centos:7 > centos.tar
docker load -i=centos.tar
```


## Liens (dans l'ordre d'apparition dans le chapitre)
https://docs.docker.com/engine/reference/commandline/dockerd/

http://www.fluentd.org/

https://runc.io/

https://hub.docker.com/r/ingensi/play-framework/ 

https://cloud.google.com/container-registry/

https://aws.amazon.com/ecr/

https://azure.microsoft.com/en-us/services/container-registry/

