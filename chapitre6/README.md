# Chapitre 6

## Commandes

### LES INSTRUCTIONS D’UN DOCKERFILE

#### FROM

Dockerfile:
```
FROM centos:7 
CMD echo "Hello world" 
FROM centos:7 
CMD echo "Bonjour à tous" 
```

#### CMD
```
FROM centos:7 
ENTRYPOINT ["/bin/ping","-c","5"] 
CMD ["localhost"] 
```

#### EXPOSE 

Dockerfile:
```
FROM centos:7 
RUN yum update -y && yum install -y \ 
openssh-server \ 
passwd 
RUN mkdir /var/run/sshd 
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN useradd user 
RUN echo -e "pass\npass" | (passwd --stdin user) 
EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"] 
```

```
docker run -d -p 22 ssh
docker inspect --format='{{json .ContainerConfig.ExposedPorts}}' ssh
ssh user@localhost -p 35022
```

#### ADD

Dockerfile:
```
FROM centos:7
RUN pwd > /tmp/initialPath
RUN mkdir output
RUN cd output
RUN pwd > /tmp/pathAfterOutput
ADD test1 ./
ADD ["test2" , "/output/"]
CMD ls /output
```

#### COPY

Dockerfile:
```
#Dockerfile multicopy1
FROM centos:7
COPY test1.tar.gz /tmp/
RUN tar xzf /tmp/test1.tar.gz
COPY test2.tar.gz /tmp/
RUN tar xzf /tmp/test2.tar.gz

#Dockerfile multicopy2
FROM centos:7
COPY test1.tar.gz test2.tar.gz /tmp/
RUN tar xzf /tmp/test1.tar.gz
RUN tar xzf /tmp/test2.tar.gz
```

#### VOLUME

Dockerfile:
```
FROM centos:7
VOLUME /tmp/data
CMD ping localhost
```

```
docker build -t volume .

docker run -d --name volume-conteneur volume
docker inspect --format='{{json .Mounts}}' volume-conteneur

docker exec volume-conteneur ls /tmp/data
sudo ls /var/lib/docker/volumes/<<id>>/_data
docker exec volume-conteneur /bin/sh -c 'echo "Hello" > /tmp/data/helloTest'

docker exec volume-conteneur ls /tmp/data
docker stop volume-conteneur
sudo ls /var/lib/docker/volumes/<<id>>/_data
docker rm volume-conteneur

docker run -d -v /var/home/vagrant/data:/tmp/data --name volume-conteneur volume
docker exec volume-conteneur /bin/sh -c 'echo "Hello" > /tmp/data/helloTest'
sudo ls /var/home/vagrant/data
```

Dockerfile:
```
FROM centos:7
# VOLUME /tmp/data
CMD ping localhost
```

```
docker build -t volume .
docker run -d -v /var/home/vagrant/data:/tmp/data --name volume-conteneur volume
docker exec volume-conteneur /bin/sh -c 'echo "Hello" > /tmp/data/helloTest'
docker inspect --format='{{json .Mounts}}' volume-conteneur
ls /var/home/vagrant/data/
```

## Liens (dans l'ordre d'apparition dans le chapitre)
https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers/

https://golang.org/pkg/path/filepath/#Match

https://fr.wordpress.org/wordpress-4.4.1-fr_FR.tar.gz

