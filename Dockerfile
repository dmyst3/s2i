FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

MAINTAINER Ahmad Bacchus <ABacchus@healthfirst.org>

ENV MULE_RUNTIME_VERSION 3.9.0
ENV MULE_HOME /opt/mule
ENV JAVA_APP_DIR=/deployments

LABEL io.k8s.description="Platform for serving Mulesoft apis" \
      io.k8s.display-name="Mulesoft CE 3.9.0" \
      io.openshift.expose-services="8081:http" \
      io.openshift.tags="mulesoft" \
      io.openshift.s2i.scripts-url=image:///usr/local/s2i

#RUN chown -R 1001:0 /root
USER root

ADD https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_RUNTIME_VERSION}/mule-standalone-${MULE_RUNTIME_VERSION}.zip /home/jboss
RUN cd ~ && \
   cd /opt && unzip ~/mule-standalone-${MULE_RUNTIME_VERSION}.zip && \
   rm ~/mule-standalone-${MULE_RUNTIME_VERSION}.zip && \
   ln -s mule-standalone-${MULE_RUNTIME_VERSION} /opt/mule
WORKDIR /opt/mule
COPY s2i/bin/ /usr/local/s2i
#CMD /opt/mule/bin/mule

#COPY api/muleopenshiftmock-1.0.0-SNAPSHOT.zip /opt/mule/apps
USER 1001

# Default http port
EXPOSE 8081
