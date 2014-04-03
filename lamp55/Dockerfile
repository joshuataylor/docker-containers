# This is a docker Drupal environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

##
# Apache.
##

# We add the stable PHP 5.5 repository.
RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 php5 libapache2-mod-php5 php5-curl php5-mysql php5-gd php-apc php-pear php5-dev
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

# vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/drupal.conf
RUN ln -s /etc/apache2/sites-available/drupal.conf /etc/apache2/sites-enabled/drupal.conf

##
# PHP.
##

ADD ./conf/php/php.ini /etc/php5/apache2/php.ini
ADD ./conf/php/php.ini /etc/php5/cli/php.ini

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

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirrors.linsrv.net/mariadb/repo/5.5/ubuntu precise main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf

##
# Cron.
##

ADD ./conf/cron/drupal /etc/cron.d/drupal

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
