# Proxy that builds it's configuration based on docker container names.

FROM        previousnext/nginx:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

RUN apt-get update

##
# Apache utils.
##

RUN apt-get -y install apache2-utils

##
# Docker.
##

RUN apt-get install -qqy apt-transport-https
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update -qq
RUN apt-get install -qqy lxc-docker

##
# Supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

##
# Startup scripts.
##

ADD ./scripts/proxy.sh /root/proxy.sh
RUN chmod 777 /root/proxy.sh

EXPOSE 22 80

CMD ["/root/start.sh"]
