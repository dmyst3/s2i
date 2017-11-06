FROM java:openjdk-8-jdk

MAINTAINER Ahmad Bacchus <ABacchus@healthfirst.org>

ENV MULE_RUNTIME_VERSION 3.9.0
# Define environment variables.
ENV MULE_HOME /opt/mule

LABEL io.k8s.description="Platform for serving Mulesoft apis" \
      io.k8s.display-name="Mulesoft CE 3.9.0" \
      io.openshift.expose-services="8081:http" \
      io.openshift.tags="mulesoft"

RUN apt-get update

COPY mule-runtime/mule-standalone-${MULE_RUNTIME_VERSION}.zip /root

RUN cd ~ && \
   cd /opt && unzip ~/mule-standalone-${MULE_RUNTIME_VERSION}.zip && \
   rm ~/mule-standalone-${MULE_RUNTIME_VERSION}.zip && \
   ln -s mule-standalone-${MULE_RUNTIME_VERSION} /opt/mule


COPY ./.s2i/bin/ /usr/local/s2i


#WORKDIR /opt/mule

#CMD /opt/mule/bin/mule


#COPY api/muleopenshiftmock-1.0.0-SNAPSHOT.zip /opt/mule/apps


# Default http port
EXPOSE 8081