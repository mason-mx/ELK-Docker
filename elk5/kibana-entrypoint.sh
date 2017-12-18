#!/bin/bash

#echo "export NODE and NPM..."
#export NODE_HOME=/opt/node
#export PATH=$NODE_HOME/bin:$PATH

echo "node scripts/makelogs"
node scripts/makelogs --host http://es5:9200

set -e

# Add elasticsearch as command if needed
#if [ "${1:0:1}" = '-' ]; then
#        set -- node "$@"
#fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
