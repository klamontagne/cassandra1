#! /bin/bash

set -u
set -e
set -x

cd /srv/cassandra
cp -v conf/cassandra.yaml.template conf/cassandra.yaml

cat >>conf/cassandra.yaml <<CASS

seed_provider:
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
          - seeds: "$SEEDS"

CASS

# If there is an alternate Docker command, run it
if [ "$#" -ne '0' ]
then
  exec $@
else
  exec /srv/cassandra/bin/cassandra -f
fi
