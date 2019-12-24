FROM jenkins/jenkins:2.210

#Installation du client Docker sous l'utilisateur root
USER root
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce
# Installation de sudo et allocations des droits correspondants à l'utilisateur jenkins
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Création du répertoire de build qui sera partagé avec le conteneur de build java
RUN mkdir -p /opt/build/jobs
# Installation des scrips utilisés par le job de build
COPY scripts /opt/build/scripts
#On s'assurer que l'utilisateur jenkins puisse accéder au volume
RUN chown -R jenkins:jenkins /opt/build

# Retour à l'utilisateur jenkins pour rendre les scripts exécutables
USER jenkins
RUN chmod u+x /opt/build/scripts/*.sh
