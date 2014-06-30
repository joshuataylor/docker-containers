FROM previousnext/base
MAINTAINER Nick Schuch "nick@previousnext.com.au"

##
# Jenkins.
##

# Java.
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y wget openjdk-6-jre-headless git-core

# Repository.
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update

# Install.
RUN RUNLEVEL=1 DEBIAN_FRONTEND=1 apt-get install -y jenkins

# Plugins.
RUN mkdir -p /var/lib/jenkins/plugins
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/greenballs.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/instant-messaging.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ircbot.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/credentials.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-credentials.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-agent.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/git-client.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/git.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/scm-api.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/simple-theme-plugin.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/swarm.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/checkstyle.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ansicolor.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/postbuildscript.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/token-macro.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/analysis-core.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/dashboard-view.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/maven-plugin.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/jquery.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ghprb.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github-api.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github-oauth.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/mailer.hpi)
RUN echo "java -jar /usr/share/jenkins/jenkins.war" > /usr/local/bin/run && chmod +x /usr/local/bin/run

ENV JENKINS_HOME /var/lib/jenkins

##
# Supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

EXPOSE 8080 22

VOLUME /var/lib/jenkins

CMD ["/root/start.sh"]
