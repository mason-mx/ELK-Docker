#!/bin/bash

# Add pipeline and template
curl --silent -XPUT -H 'Content-Type: application/json' 'es6:9200/_ingest/pipeline/ncedc-earthquakes' -d @/earthquakes/ncedc-earthquakes-pipeline.json
curl --silent -XPUT -H 'Content-Type: application/json' 'es6:9200/_template/ncedc-earthquakes' -d @/earthquakes/ncedc-earthquakes-template.json

./filebeat -e -c ncedc-earthquakes-filebeat.yml &

# set n to 0
n=0

echo "##### Begin feeding data #####\r\n"
# {"count":0,"_shards":{"total":0,"successful":0,"skipped":0,"failed":0}}:wq
# continue until $n equals 38315
while [ $n -lt 38315 ]
do
    command_output=$(curl --silent http://es6:9200/ncedc-earthquakes-*/_refresh)
    count_output=$(curl --silent http://es6:9200/ncedc-earthquakes-*/_count)
    #echo $count_output
    n=`echo $count_output | grep -o "\"count\":[0-9]*" | sed 's/\"count\"://'`
    #echo $n
    echo "##### Data is on the way, not finished yet. Current count is $n #####\r\n"
    sleep 5
done

echo "##### Feeding data ends, this container is going to close #####\r\n"
kill $(ps -ef | grep earthquakes-filebeat | awk '{print $2}')
