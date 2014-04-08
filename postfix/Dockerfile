# Postfix container.

FROM previousnext/base:latest
MAINTAINER Peter Lieverdink <me@cafuego.net>

# Allow postfix to install without interaction.
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
RUN echo "postfix postfix/mailname string HOSTNAME.EXAMPLE.COM" | debconf-set-selections
RUN echo "postfix postfix/root_address ROOTMAIL@EXAMPLE.COM" | debconf-set-selections
RUN echo "postfix postfix/mynetworks 0.0.0.0/0" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postfix

##
# Supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

EXPOSE 25

CMD ["/root/start.sh"]
