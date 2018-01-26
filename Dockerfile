FROM openjdk:8-jre-alpine
MAINTAINER rilut

RUN apk add --no-cache curl

RUN mkdir /opt/
ENV PRESTO_VERSION 0.191

RUN mkdir /opt/presto && \
  curl https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz -o presto-server.tar.gz && \ 
  tar xfz presto-server.tar.gz -C /opt/presto --strip-components=1 && \
  rm presto-server.tar.gz

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar /usr/local/bin/presto

RUN chmod a+x /usr/local/bin/presto

EXPOSE 8080

ENTRYPOINT ["/opt/presto/bin/launcher", "run"]
