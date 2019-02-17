# Chapitre 7

- [VARIABLES D’ENVIRONNEMENT ET CONTENEURS : ENV](#variables-denvironnement-et-conteneurs--env)
- [META-INFORMATION ET IMAGES : LABEL](#meta-information-et-images--label)
- [PARAMETRER LE « BUILD » D’UNE IMAGE](#parametrer-le--build--dune-image)
    - [ARG](#arg)
    - [ONBUILD](#onbuild)
- [MODIFIER LE CONTEXTE SYSTEME AU COURS DU BUILD](#modifier-le-contexte-systeme-au-cours-du-build)
    - [SHELL](#shell)
    - [USER](#user)
- [AUTO-GUERISON (SELF HEALING)](#auto-guerison-self-healing)
    - [--restart](#--restart)
    - [HEALTHCHECK](#healthcheck)

## VARIABLES D’ENVIRONNEMENT ET CONTENEURS : ENV

Dockerfile :
```
FROM centos:7
ENV myName="James Bond" myJob=Agent\ secret
CMD echo $myName
```

```
docker run --rm --env myName="Jason Bourne" env
docker run --rm --env myName="Jason Bourne" --env myJob="CIA" env
docker run --rm  env /bin/sh -c 'echo "$myJob"'

docker run -rm -name test env ping localhost
docker inspect --format='{{json .Config.Env}}' test
```

## META-INFORMATION ET IMAGES : LABEL

Dockerfile:
```
FROM centos:7
LABEL app.name="Mon application" \
"app.version"="1.0" \
app.description="Voici la description de \"Mon application\" \
sur plusieurs lignes."
CMD echo "fin"
```

```
docker build -t label .
docker run -rm -name test label
docker inspect --format='{{json .Config.Labels}}' test
```

## PARAMETRER LE « BUILD » D’UNE IMAGE

### ARG

Dockerfile:
```
FROM centos:7
ARG var1
ARG var2="ma valeur"
RUN echo $var1 > /tmp/var
RUN echo $var2 >> /tmp/var
CMD echo $var1
```

```
docker build --build-arg var1=valeur1 -t arg .
docker run --rm arg
```

Dockerfile:
```
FROM centos:7
ARG var1
ARG var2="ma valeur"
RUN echo $var1 > /tmp/var
RUN echo $var2 >> /tmp/var
CMD cat /tmp/var
```

```
docker build --build-arg var1=valeur1 -t arg .
docker run --rm arg
```

```
docker build --build-arg var1=valeur1 --build-arg var2="une autre valeur" -t arg .
docker run --rm arg
```

Dockerfile:
```
FROM centos:7
ARG var=argument
ENV var variable
RUN echo $var > /tmp/var
CMD cat /tmp/var
```

```
docker build -t arg .
docker run --rm arg
```

Dockerfile:
```
FROM centos:7
ENV var variable
ARG var=argument
RUN echo $var > /tmp/var
CMD cat /tmp/var
```

```
docker build -t arg .
docker run --rm arg
```

Dockerfile:
```
FROM centos:7
ARG version
ENV version ${version:-1.0}
RUN echo $version > /tmp/version
CMD cat /tmp/version
```

```
docker build -t arg .
run --rm arg
```

```
docker build --build-arg version=1.2 -t arg .
docker run --rm arg
```

### ONBUILD

Dockerfile:
```
FROM centos:7
ONBUILD ARG fichier="app.py"
ONBUILD COPY $fichier /app/app.py
ONBUILD RUN python -m py_compile /app/app.py
ENTRYPOINT ["python", "/app/app.pyc"]
```

```
docker build -t python-app:1.0-onbuild .
```

Dockerfile:
```
FROM python-app:1.0-onbuild
CMD ["0"]
```

```
docker build --build-arg fichier=x2.py -t python-x2 .
docker run --rm python-x2
docker run --rm python-x2 17
```

```
docker inspect --format='{{json .ContainerConfig.OnBuild}}' python-app
```

## MODIFIER LE CONTEXTE SYSTEME AU COURS DU BUILD

### SHELL

Attention, l'exemple nécessite d'installer Docker pour windows.

Dockerfile:
```
FROM microsoft/windowsservercore

# Exécuté comme cmd /S /C echo default
RUN echo default

# Exécuté comme cmd /S /C powershell -command Write-Host default
RUN powershell -command Write-Host default

# Exécuté comme powershell -command Write-Host hello
SHELL ["powershell", "-command"]
RUN Write-Host hello

# Exécuté comme cmd /S /C echo hello
SHELL ["cmd", "/S", "/C"]
RUN echo hello
```

```
docker build -t shellwin .
docker run -ti shellwin
```

### USER

Dockerfile:
```
FROM centos:7
RUN chown root:root /bin/top && \
    chmod 774 /bin/top
RUN groupadd -r mygroup && \
    useradd -r -g mygroup myuser
USER myuser
CMD /bin/top -b
```

```
docker build -t user .
docker run --rm --name user-conteneur user
```

Dockerfile:
```
FROM centos:7
RUN chown root:root /bin/top && \
 chmod 774 /bin/top
RUN groupadd -r mygroup && \
 useradd -r -g mygroup myuser
RUN chown myuser:mygroup /bin/top
USER myuser
CMD /bin/top -b
```

```
docker build -t user .
docker run --rm --name user-conteneur user
docker inspect --format='{{json .Config.User}}' user-conteneur
```

Dockerfile:
```
FROM centos:7
RUN yum update -y && yum install -y \
 sudo
RUN sed -i -e 's/requiretty/!requiretty/g' /etc/sudoers
RUN chown root:root /bin/top && \
 chmod 774 /bin/top
RUN groupadd -r mygroup && \
 useradd -r -g mygroup myuser
RUN echo '%mygroup ALL=NOPASSWD: /bin/top' >> /etc/sudoers
USER myuser
CMD sudo /bin/top -b
```

```
docker build -t user .
docker run --rm --name user-conteneur user
```

Dockerfile:
```
FROM centos:7
RUN yum update -y && yum install -y \
 sudo
RUN sed -i -e 's/requiretty/!requiretty/g' /etc/sudoers
RUN chown root:root /bin/top && \
 chmod 774 /bin/top
RUN groupadd -r mygroup && \
 useradd -r -g mygroup myuser
RUN echo '%mygroup ALL=NOPASSWD: /bin/top' >> /etc/sudoers
USER myuser
CMD sudo /bin/top -b
```

```
docker build -t user .
docker run --rm --name user-conteneur user
```

## AUTO-GUERISON (SELF HEALING)

### --restart

```
docker run -d --restart=always --name=sepuku centos:7 /bin/sh -c "sleep 5"
```

### HEALTHCHECK

Python:
```
from flask import Flask
from flask import request
from datetime import datetime

app = Flask(__name__)

calls=[]

@app.route('/')
def index():
    return 'Call count : <ul><li>{}</li></ul>'.format('</li><li>'.join(calls))

@app.route('/health')
def health():
    global calls
    dt = datetime.now()
    calls.append("from {} at {}".format(request.remote_addr, dt.strftime("%H:%M:%S")))
    return 'OK'

if __name__ == '__main__':
    app.run(host="0.0.0.0")
```

Dockerfile:
```
FROM python:3.7.0

RUN pip install flask==1.0.2

COPY app.py app.py
HEALTHCHECK --interval=10s \
    CMD curl -f http://localhost:5000/health || exit 1

ENTRYPOINT python app.py
```

```
docker build -t health-flask .
docker run -d --rm -p 5000:5000 --name=health-flask health-flask
docker ps
```

```
docker stop health-flask
docker build -t health-flask .
docker run -d --rm -p 5000:5000 --name=health-flask health-flask
docker ps
```

```
docker events --since 10m --until 10s --filter "event=health_status: unhealthy"  --format '{{.ID}}'
```

Cron shell script:
```
#!/bin/bash
set -e
CONTAINERS_TO_RESTART=$(docker events --since 10m --until 10s --filter "event=health_status: unhealthy"  --format '{{.ID}}')
docker restart $CONTAINERS_TO_RESTART
```
