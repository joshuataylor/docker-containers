# This is a docker Drupal environment.

FROM        previousnext/lamp53:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV DRUPAL_VERSION 7.26

##
# Apache.
##



##
# Setup Drupal.
##

# Prepare the files.
RUN rm -fR /var/www
RUN drush dl drupal-${DRUPAL_VERSION}
RUN mv drupal-${DRUPAL_VERSION} /var/www

# Create directory structure.
RUN mkdir -p /var/www/sites/default/files/tmp

# Permissions.
RUN chown -R www-data:www-data /var/www

##
# Build a new start file.
##

ADD ./scripts/start.sh /root/start.sh

EXPOSE 22 80

CMD ["/root/start.sh"]
