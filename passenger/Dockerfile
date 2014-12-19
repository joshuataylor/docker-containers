# This is a docker mod-passenger environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

RUN apt-get update -y

##
# Apache.
##
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 apache2-mpm-worker nullmailer

ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# This fixes missing file errors.
RUN test -f /etc/apache2/httpd.conf || touch /etc/apache2/httpd.conf
RUN test -d /etc/apache2/conf.d || mkdir /etc/apache2/conf.d
RUN test -d /etc/apache2/conf-enabled || ln -s /etc/apache2/conf.d /etc/apache2/conf-enabled

# Mods.
RUN a2enmod rewrite

# We add the brightbox ruby and passenger repository.
RUN add-apt-repository ppa:brightbox/ruby-ng
RUN apt-get update

# Ruby and bundler.
RUN apt-get install -y ruby1.9.1 ruby1.9.1-dev passenger-common1.9.1 libapache2-mod-passenger

# Enable passenger
RUN a2enmod passenger

# vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/passenger
RUN a2ensite passenger

# Set default ruby
RUN /usr/sbin/update-alternatives --set ruby /usr/bin/ruby1.9.1
RUN /usr/sbin/update-alternatives --set gem /usr/bin/gem1.9.1

# Install bundler with the correct gem.
RUN gem install bundler -v 1.6.3

##
# Mysql.
##

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://ftp.nluug.nl/db/mariadb/repo/5.5/ubuntu precise main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server libmariadbclient-dev 
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf

##
# Tools and libraries for building gems. Same as Virtualbox.
##

RUN apt-get update
RUN apt-get install -y build-essential imagemagick libapr1-dev libaprutil1-dev libcurl4-openssl-dev libsqlite3-dev libssl-dev ruby-json ruby-libxml ruby-mysql ruby-nokogiri ruby-rmagick ruby1.9.1-dev zlib1g-dev libxslt-dev libxml2-dev libmagickcore-dev libmagickwand-dev


##
# PHP for Composer and Phing.
##

RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update
RUN apt-get install -y php5 php5-curl php-pear

# Composer!
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Phing!
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing-2.6.1

##
# PHP for Composer and Phing.
##

RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update
RUN apt-get install -y php5 php5-curl php-pear

# Composer!
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Phing!
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing-2.6.1

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
