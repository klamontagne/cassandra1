FROM openjdk:8

RUN groupadd --gid 999 cassandra
RUN useradd -m --uid 999 --gid 999 cassandra

WORKDIR /srv/

RUN wget -O /srv/cassandra.tar.gz https://archive.apache.org/dist/cassandra/1.2.19/apache-cassandra-1.2.19-bin.tar.gz && \
    tar xvzf cassandra.tar.gz && rm -v cassandra.tar.gz

RUN ln -sv ./apache-cassandra-* /srv/cassandra

RUN rm -rv /srv/cassandra/conf

USER cassandra

VOLUME /srv/cassandra/conf

WORKDIR /srv/cassandra
CMD /srv/cassandra/bin/cassandra -f

EXPOSE 7000
EXPOSE 7001
EXPOSE 7199
EXPOSE 9042
EXPOSE 9160
