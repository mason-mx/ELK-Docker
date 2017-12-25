#!/bin/bash

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip()
{
    local  ip=$1
    local  stat=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

echo "Please enter the IP address of the ElasticSearch:"
read hostip
tryagain () {
    echo "Incorrect IP format detected, please input once again:"
    read hostip
    checkip
}

checkip () {
    if valid_ip $hostip;
    then
        echo "Going to feed $hostip"
    else
        tryagain
    fi
}

checkip

sed -i "s/localhost/$hostip/" ./ncedc-earthquakes-filebeat.yml

# Add pipeline and template
curl -XPUT -H 'Content-Type: application/json' "$hostip:9200/_ingest/pipeline/ncedc-earthquakes" -d @/earthquakes/ncedc-earthquakes-pipeline.json
curl -XPUT -H 'Content-Type: application/json' "$hostip:9200/_template/ncedc-earthquakes" -d @/earthquakes/ncedc-earthquakes-template.json

set -e

# Add elasticsearch as command if needed
#if [ "${1:0:1}" = '-' ]; then
#        set -- node "$@"
#fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
