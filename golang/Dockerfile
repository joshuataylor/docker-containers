FROM        ubuntu:14.04
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV GOBALL go1.4.1.linux-amd64.tar.gz

# APT.
RUN apt-get update
RUN apt-get -y upgrade
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -fs /bin/true /sbin/initctl

# Tools.
RUN apt-get install -y make rsync

# SSHD.
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys
RUN chown root:root -R /root/.ssh

# Golang.
RUN cd /tmp && wget -q https://storage.googleapis.com/golang/$GOBALL
RUN cd /tmp && tar -C /usr/local -xzf $GOBALL
RUN mkdir -p /opt/golang
RUN rm /tmp/$GOBALL
ADD profile /etc/profile.d/go.sh

CMD /usr/sbin/sshd -D
