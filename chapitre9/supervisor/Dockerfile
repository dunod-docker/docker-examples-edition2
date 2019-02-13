FROM centos:7

#Pour le volume monté depuis l'hôte
#RUN useradd -u 1000 mysql

RUN yum install -y epel-release && \
    yum update -y && \
    yum install -y mariadb-server \
                   java \
                   supervisor \
                   python36 \
                   cronie \
                   && yum clean all

ARG MYSQL_ROOT_PASSWORD

# Execute le script d'installation de MariaDB et donne les droits à l'utilisateur mysql
RUN /usr/bin/mysql_install_db --user=mysql \
    && chown -R mysql:mysql /var/lib/mysql
#Copie du schema.sql et création
COPY schema.sql /schema.sql

# Copie le JAR de l'application front-end
COPY *.jar /app.jar
# Créer le script de démarrage du front-end
RUN echo -e "/usr/bin/mysqladmin --no-defaults --port=3306 --user=root password '${MYSQL_ROOT_PASSWORD}'\n" > /start-front-end.sh
RUN echo -e "/usr/bin/mysql -v -u root -p${MYSQL_ROOT_PASSWORD} < /schema.sql\n" >> /start-front-end.sh
RUN echo -e "/usr/bin/java -jar /app.jar\n" >> /start-front-end.sh
RUN chmod u+x /start-front-end.sh

# Copie de l'application
COPY main.py /main.py
COPY config.json /config.json
# Changement de la version par défaut de python
RUN ln -sf /usr/bin/python3.6 /usr/local/bin/python
# Requis en raison des accents dans le code python
ENV PYTHONIOENCODING=utf-8
# Installation du cronjob
RUN echo -e "* * * * * root /usr/local/bin/python /main.py\n" > /etc/cron.d/backend

EXPOSE 8080
EXPOSE 9001

#Définitions d'un volume pour les fichiers de MariaDB
VOLUME ["/var/lib/mysql/"]
#Définitions d'un volume pour les fichiers partagées entre le front-end et le back-end
VOLUME ["/chargement"]

# Copie de la configuration de supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Démarrage de supervisor en mode bloquant
CMD ["/usr/bin/supervisord", "-n","-e","debug","-c", "/etc/supervisor/conf.d/supervisord.conf"]