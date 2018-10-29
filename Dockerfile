FROM openjdk:8

RUN groupadd --gid 999 cassandra
RUN useradd -m --uid 999 --gid 999 cassandra

WORKDIR /srv/

RUN wget -O /srv/cassandra.tar.gz https://archive.apache.org/dist/cassandra/1.2.19/apache-cassandra-1.2.19-bin.tar.gz && \
    tar xvzf cassandra.tar.gz && rm -v cassandra.tar.gz

RUN ln -sv ./apache-cassandra-* /srv/cassandra

RUN rm /srv/cassandra/conf/cassandra.yaml
RUN chown cassandra /srv/cassandra/conf

USER cassandra

WORKDIR /srv/cassandra

COPY --chown=cassandra:cassandra cassandra.yaml.template /srv/cassandra/conf/
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

RUN sed -i 's/INFO,stdout,R/INFO,stdout/' /srv/cassandra/conf/log4j-server.properties

EXPOSE 7000
EXPOSE 7001
EXPOSE 7199
EXPOSE 9042
EXPOSE 9160

VOLUME /data
