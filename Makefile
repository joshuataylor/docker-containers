#!/usr/bin/make -f

CD=cd
DOCKER=docker

5.6:
	@${CD} php_5.6-apache && $(DOCKER) build -f Dockerfile -t pnx/php:5.6-apache .

7.0:
	@${CD} php_7.0-apache && $(DOCKER) build -f Dockerfile -t pnx/php:7.0-apache .

latest:
	@${CD} php_7.0-apache && $(DOCKER) build -f Dockerfile -t pnx/php:latest-apache .

all: 5.6 7.0 latest
