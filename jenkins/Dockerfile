FROM previousnext/base
MAINTAINER Nick Schuch "nick@previousnext.com.au"

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
RUN echo "java -jar /usr/share/jenkins/jenkins.war" > /usr/local/bin/run && chmod +x /usr/local/bin/run

ENV JENKINS_HOME /var/lib/jenkins

EXPOSE 8080

VOLUME /var/lib/jenkins

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
