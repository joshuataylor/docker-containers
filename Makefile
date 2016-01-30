#!/usr/bin/make -f

CD=cd
DOCKER=docker

build:
	@${CD} build && $(DOCKER) build -f Dockerfile -t previousnext/build .

php-5.6:
	@${CD} php_5.6-apache && $(DOCKER) build -f Dockerfile -t previousnext/php:5.6-apache .

php-7.0:
	@${CD} php_7.0-apache && $(DOCKER) build -f Dockerfile -t previousnext/php:7.0-apache .

php-latest:
	@${CD} php_7.0-apache && $(DOCKER) build -f Dockerfile -t previousntxt/php:latest-apache .

all: build php-5.6 php-7.0 php-latest
