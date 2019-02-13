# Chapitre 8

## LE RESEAU AVEC DOCKER

> Reportez-vous au sous-répertoire "network"

## PERSISTANCE : BIND MOUNTS ET VOLUMES

> Reportez-vous au sous-répertoire "persitance"

## MONITORING

```
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  --privileged=true \
  google/cadvisor:latest
```

## Liens (dans l'ordre d'apparition dans le chapitre)

http://spring.io/projects/spring-boot 

https://github.com/docker/libnetwork

http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge

https://store.docker.com/search?category=network&q=&type=plugin 

https://github.com/jpetazzo/pipework

http://www.netfilter.org/

https://www.projectatomic.io/blog/2016/03/dwalsh_selinux_containers/ 

https://www.elastic.co/products/logstash

https://cloud.spring.io/spring-cloud-config/ 

https://www.nagios.org/ 

https://prometheus.io/ 

https://newrelic.com/

