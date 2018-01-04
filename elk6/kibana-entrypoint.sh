#!/bin/bash

echo "node scripts/makelogs"
node scripts/makelogs --host http://es6:9200

echo "Starting Kibana"
./bin/kibana
