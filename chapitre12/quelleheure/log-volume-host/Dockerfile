FROM php:apache-stretch

COPY index.php /var/www/html/

RUN mkdir /data
RUN echo "chown -R 'www-data':'www-data' /data/ /var/www/html/ && apache2-foreground" >> /usr/local/bin/start_server.sh
RUN chmod u+x /usr/local/bin/start_server.sh

ENTRYPOINT start_server.sh