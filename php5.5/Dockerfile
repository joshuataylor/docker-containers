FROM        ubuntu:14.04
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

# APT.
RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update
RUN apt-get -y upgrade
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -fs /bin/true /sbin/initctl

# Tools.
RUN apt-get install -y make rsync git

# SSHD.
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys
RUN chown root:root -R /root/.ssh

# PHP.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5 php5-curl php5-mcrypt php-apc php-pear php5-dev
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

CMD /usr/sbin/sshd -D
