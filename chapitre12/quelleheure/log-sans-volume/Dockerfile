FROM php:apache-stretch

COPY index.php /var/www/html/
RUN mkdir /data
RUN chown -R 'www-data':'www-data' /data/ /var/www/html/
