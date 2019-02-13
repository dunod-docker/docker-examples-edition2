# Chapitre 8

## PERSISTANCE : BIND MOUNTS ET VOLUMES

### Les deux types de système de fichier persistant

#### Bind mount : rappel

```
docker system prune -f
docker run --rm -ti --name=centos-test -v ${PWD}:/opt/test centos:7
```

```
            touch /opt/test/mylocalfile
            exit
```

```
ls -la
docker volume ls
```

#### Volume

```
docker create volume volume-test
docker volume ls
docker run --rm -ti --name=centos-test -v volume-test:/opt/test centos:7
```

```
            ls -la /opt/test/
            exit
```

```
docker run --rm -ti --name=centos-test -v volume-test:/var centos:7
```

```
            ls /var/
            exit
```

```
docker run --rm -ti --name=centos-test -v volume-test:/opt/test centos:7
```

```
            ls /opt/test/
            exit
```

Deux fois dans deux terminaux différents:
```
docker run --rm -ti -v volume-test:/opt/test centos:7
```

Premier conteneur:
```
watch -n 1 cat /opt/test/fichier.txt
```

Second conteneur:
```
echo -e "Heure du moment $(date)" >> /opt/test/fichier.txt
```