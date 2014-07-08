# This is a docker Drupal environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

RUN apt-get update -y

##
# Apache.
##

# We add the stable PHP 5.4 repository.
RUN add-apt-repository ppa:ondrej/php5-oldstable
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-curl php5-mysql php5-gd php5-mcrypt php-apc php-pear php5-dev php5-pspell nullmailer libssl-dev
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

# vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/drupal
RUN ln -s /etc/apache2/sites-available/drupal /etc/apache2/sites-enabled/drupal

##
# PHP.
##

ADD ./conf/php/php.ini /etc/php5/apache2/php.ini
ADD ./conf/php/php.ini /etc/php5/cli/php.ini

# Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Bundler.
RUN apt-get install -y ruby1.9.1
RUN gem install bundler -v 1.6.3

# Phing.
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing-2.6.1

# Drush.
ADD https://github.com/drush-ops/drush/archive/6.2.0.zip /tmp/drush.zip
RUN cd /tmp && unzip /tmp/drush.zip
RUN mv /tmp/drush-6.2.0 /opt/drush
RUN ln -s /opt/drush/drush /usr/local/bin/drush
RUN chmod -R 777 /opt/drush/lib

# IRC.
RUN pear install Net_SmartIRC

# Xhprof.
RUN apt-get install -y build-essential
RUN pear channel-update pear.php.net
RUN pecl install xhprof-beta

# Xdebug.
RUN apt-get install -y build-essential
RUN pear channel-update pear.php.net
RUN pecl install xdebug

##
# Mysql.
##

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.aarnet.edu.au/pub/MariaDB/repo/5.5/ubuntu precise main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf

##
# Cron.
##

ADD ./conf/cron/drupal /etc/cron.d/drupal

##
# Scripts.
#   This is where we add all our utlitiy scripts.
##

ADD ./scripts/permissions.sh /root/permissions.sh

##
# Supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

EXPOSE 22 80

CMD ["/root/start.sh"]
