# Instructions for Docker

Here are the instructions to build and run images.

## Build

Build ElasticSearch image.
```
docker build -t arm64/elk-es6.0.1 -f /path/to/a/Dockerfile-es .
```
Build Filebeat image.
```
docker build -t arm64/filebeat6.0.1 -f /path/to/a/Dockerfile-filebeat .
```
Build Kibana image.
```
docker build -t arm64/elk-k6.0.1 -f /path/to/a/Dockerfile-k .
```

## Running

Open a new shell window and creat a new sub-net for Docker.
```
docker network create <network-name> in this case named `elk6`
```
Then run ElasticSearch.
```
docker run -ti --rm -p 9200:9200 --net=`elk6` --name es6 arm64/elk-es6.0.1
```
Open a new shell window and then run Filebeat and input the host IP address.
```
docker run -ti --rm arm64/filebeat6.0.1
```
Open a new shell window and then run Kibana.
```
docker run -ti --rm -p 5601:5601 --net=`elk6` --name k6 arm64/elk-k6.0.1
```

## Test

Please read [README.md](https://github.com/mason-mx/ELK-Docker/blob/master/README.md) for details of testing them.

## Known Issues

There is no map showing on the page of any case in dashboard. The warning message displayed on the top of the page is:
> Coordinate Map: Could not retrieve manifest from the tile service: status -1

## Things to try

* to start a Filebeat container in the same subnet and feed data to `es6`
* to run elk6 on x86 machine to check the above issue of showing map

