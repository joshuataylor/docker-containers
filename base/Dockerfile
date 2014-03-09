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

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install fail2ban vim git curl wget pwgen python-setuptools vim-tiny sudo python-software-properties drush cron unzip

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
# Rsyslog.
##

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install rsyslog rsyslog-doc

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
