# This is a docker mod-passenger environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

RUN apt-get update -y

##
# Apache.
##

# We add the brightbox passenger repository.
RUN add-apt-repository ppa:brightbox/passenger
RUN apt-get update
RUN apt-get -y dist-upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-passenger apache2-mpm-worker nullmailer

ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# This fixes missing file errors.
RUN test -f /etc/apache2/httpd.conf || touch /etc/apache2/httpd.conf
RUN test -d /etc/apache2/conf.d || mkdir /etc/apache2/conf.d

# Mods.
RUN a2enmod passenger
RUN a2enmod rewrite

# Bundler.
RUN apt-get install -y ruby1.9.1 ruby1.9.1-dev
RUN gem install bundler -v 1.6.3

# Tools for building gems.
RUN apt-get install -y build-essential

# Libraries and utils for gems that redmine needs.
RUN apt-get install -y libxml2-dev libxslt1-dev libmariadbclient-dev imagemagick libmagick++-dev

##
# Mysql.
##

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://ftp.nluug.nl/db/mariadb/repo/5.5/ubuntu precise main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf

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
