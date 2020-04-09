# Chapitre 3

- [Commandes](#commandes)
  - [Linux sous VirtualBox](#linux-sous-virtualbox)
    - [Vagrant](#vagrant)
    - [Docker sous Linux](#docker-sous-linux)
  - [Premier conteneur](#premier-conteneur)
    - [Le client docker (socat)](#le-client-docker-socat)
    - [API remote](#api-remote)
- [Liens (dans l'ordre d'apparition dans le chapitre)](#liens-dans-lordre-dapparition-dans-le-chapitre)


## Commandes

### Linux sous VirtualBox

#### Vagrant
```
vagrant init dunod-docker/centos7
vagrant up --provider virtualbox
```

#### Docker sous Linux
```
sudo su
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo 
yum install -y docker-ce-18.06.0.ce-3.el7
systemctl start docker
systemctl enable docker
docker run hello-world
usermod -aG docker vagrant
```

### Premier conteneur

#### Le client docker (socat)
```
sudo yum install -y socat
socat -v UNIX-LISTEN:/tmp/socatproxy.sock UNIX-CONNECT:/var/run/docker.sock &
docker -H unix:///tmp/socatproxy.sock ps -a
```

#### API remote
```
sudo systemctl stop docker
sudo dockerd -H tcp://0.0.0.0:2375 &
grep -f /var/run/docker.sock 
docker ps 
docker -H 0.0.0.0:2375 info
export DOCKER_HOST="tcp://0.0.0.0:2375"
sudo yum install -y jq
curl http://localhost:2375/info |jq
```

```
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo netstat -lntp | grep dockerd
```


## Liens (dans l'ordre d'apparition dans le chapitre)
https://app.vagrantup.com/dunod-docker/boxes/centos7

http://virtualbox.org

https://docs.vagrantup.com/v2/installation/index.html

https://fr.wikipedia.org/wiki/Representational_State_Transfer

https://docs.docker.com/docker-for-mac/install/

https://docs.docker.com/docker-for-windows/install/

https://docs.docker.com/kitematic/userguide/
  
https://fr.wikipedia.org/wiki/Berkeley_sockets#Socket_unix

http://www.dest-unreach.org/socat/

https://docs.docker.com/engine/api/version-history/

https://stedolan.github.io/jq/

https://docs.docker.com/engine/admin/systemd
