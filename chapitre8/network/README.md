# Chapitre 8

## LE RESEAU AVEC DOCKER

### Les réseaux standard de Docker

```
docker network ls
```

### Le réseau « bridge »

```
/bridge_network/run_bridge_network.sh
```

```
docker network inspect bridge
```

```
sudo brctl show docker0
```

```
docker exec -ti centos-test-1 /bin/bash
```

```
      yum install -y nmap
      nc -l 5000
```

```
docker exec -ti centos-test-2 /bin/bash
```

```
      yum install -y telnet
      telnet 172.17.0.2 5000
```

```
/bridge_network/clean_bridge_network.sh
```

### Créer un réseau personnalisé de type bridge

```
/decicated_network/run_dedicated_network.sh
```

```
docker network create test
docker run -itd --name busybox-1 --net test busybox
docker run -itd --name busybox-2 --net test busybox
docker run -itd --name busybox-3 busybox
```

```
docker network ls
```

```
docker network inspect test --format '{{.Containers}}'
```

```
docker network inspect bridge --format '{{.Containers}}'
```

```
docker exec -ti busybox-1 /bin/sh
```

```
      ping 172.22.0.3
      ping busybox-2
      ping busybox-3
```

```
docker network connect bridge busybox-1
docker exec -ti busybox-1 /bin/sh
```

```
      ping 172.22.0.2
      ping busybox-3
```

```
/decicated_network/clean_dedicated_network.sh
```

### Lien entre les conteneurs, l’hôte et les réseaux auxquels il est connecté

#### Transfert des paquets IP

```
sysctl net.ipv4.conf.all.forwarding
```

#### Accès aux réseaux extérieurs

```
sudo iptables -t nat -L -n
```

### Accès à l’hôte depuis un conteneur : l’option « host »

```
/host_network/run_host_network.sh
```

```
docker exec -ti centos-test /bin/bash
```

```
      yum install -y nmap
      nc -l 5000
```

```
netstat -vatn | grep 5000
```

```
/host_network/clean_host_network.sh
```

#### Accès à l’hôte depuis un conteneur : l’option « gateway »

```
/access_host/run_access_host.sh
```

```
docker exec -ti centos-test /bin/bash
```

```
      yum install -y net-tools
      yum install -y nmap
      yum install -y openssh-clients
      echo $(route -n | awk '/UG[ \t]/{print $2}')
      nmap 172.17.0.1
      ssh vagrant@172.17.0.1
```

```
sudo service firewalld start
sudo service docker restart
sudo firewall-cmd --list-all
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd –reload
```

```
docker exec -ti centos-test /bin/bash
```

```
      nmap 172.17.0.1
```

```
/access_host/clean_access_host.sh
```