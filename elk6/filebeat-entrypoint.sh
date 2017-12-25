#!/bin/bash

# Add pipeline and template
curl -XPUT -H 'Content-Type: application/json' 'localhost:9200/_ingest/pipeline/ncedc-earthquakes' -d @/earthquakes/ncedc-earthquakes-pipeline.json
curl -XPUT -H 'Content-Type: application/json' 'localhost:9200/_template/ncedc-earthquakes' -d @/earthquakes/ncedc-earthquakes-template.json

set -e

# Add elasticsearch as command if needed
#if [ "${1:0:1}" = '-' ]; then
#        set -- node "$@"
#fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
