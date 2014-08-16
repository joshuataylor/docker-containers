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
RUN git clone https://github.com/travis-ci/travis-build.git /opt/travis-build
RUN mkdir /root/.travis
RUN ln -s /opt/travis-build /root/.travis/travis-build
RUN travis version

##
# Entry points.
##

VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["travis", "run", "--skip-version-check", "--skip-completion-check"]
CMD ["-p"]
