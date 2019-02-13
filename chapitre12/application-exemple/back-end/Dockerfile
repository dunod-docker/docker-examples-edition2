FROM python:3-slim-stretch

# Installation du processus cron
RUN apt-get update && apt-get install -y cron

# Requis en raison des accents dans le code python
ENV PYTHONIOENCODING=utf-8
# Installation du cronjob
RUN echo "* * * * * root /usr/local/bin/python /main.py" > /etc/cron.d/backend

COPY config.json /config.json
COPY main.py /main.py

# Lancement de cron en mode bloquant
ENTRYPOINT /usr/sbin/cron -f