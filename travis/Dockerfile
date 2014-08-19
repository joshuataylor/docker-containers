FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

##
# Ruby.
##

RUN apt-get install -y ruby1.9.1-dev build-essential

##
# Travis.
##

RUN gem install travis --no-rdoc --no-ri
RUN mkdir /root/.travis
RUN git clone --branch deploy.2014-07-01.03-01 https://github.com/travis-ci/travis-build.git /root/.travis/travis-build
RUN travis version

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

VOLUME ["/data"]
WORKDIR /data
CMD ["/root/start.sh"]
