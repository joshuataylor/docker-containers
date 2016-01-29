FROM       php:7.0-apache
MAINTAINER nick_schuch

WORKDIR /data

ENV PATH "$PATH:/data/bin"

# Apache / PHP
RUN apt-get update && apt-get install -y mysql-client libpng-dev libmcrypt-dev
RUN apt-get clean
RUN docker-php-ext-install pdo pdo_mysql mcrypt gd mbstring opcache
RUN a2enmod rewrite
ADD apache2.conf /etc/apache2/apache2.conf

# Configuration
ADD settings.config.php /etc/drupal/settings.config.php

# Tuner - https://github.com/previousnext/tuner
ADD bin/tuner /usr/local/bin/tuner
RUN chmod a+x /usr/local/bin/tuner

# Script that kicks it all off
ADD start.sh /usr/local/bin/start
RUN chmod a+x /usr/local/bin/start

CMD ["/usr/local/bin/start"]
