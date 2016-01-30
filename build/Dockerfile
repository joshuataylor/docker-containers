FROM       php:5-cli
MAINTAINER nick_schuch

WORKDIR /data

RUN apt-get update
RUN apt-get install -y git

# Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN composer global require hirak/prestissimo

# NPM
RUN curl -sL https://raw.githubusercontent.com/nodesource/distributions/master/deb/setup_0.12 | bash -
RUN apt-get update
RUN apt-get install -y nodejs

# Bundler.
RUN apt-get install -y ruby2.1 ruby2.1-dev
RUN gem2.1 install bundler

# Cleanup.
RUN apt-get clean

CMD ["/bin/bash", "-c"]
