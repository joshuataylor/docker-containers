# This is a base container for PNX docker containers.

FROM        ubuntu:12.04
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

##
# APT.
##

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -fs /bin/true /sbin/initctl

##
# Base.
##

# APT.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install fail2ban vim git curl wget pwgen python-setuptools vim-tiny sudo python-software-properties drush cron unzip

# Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Phing.
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing

##
# Users.
##

RUN useradd --create-home --shell /bin/bash --user-group deployer

##
# SSHD.
##

RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

##
# Fail2ban.
##

RUN mkdir /var/run/fail2ban

##
# Rsyslog.
##

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install rsyslog rsyslog-doc
RUN sed -i 's/xconsole/console/g' /etc/rsyslog.d/*

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

##
# Supervisord.
##

RUN easy_install supervisor
ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir /var/log/supervisor/
