# Instructions for Docker

Here are the instructions to build and run images, which requires much different scripts and commands from x86.

## Build

Build ElasticSearch image.
```
docker build -t arm64/es5 -f /path/to/a/Dockerfile-es .
```
Build Kibana image.
```
docker build -t arm64/k5 -f /path/to/a/Dockerfile-k .
```

## Running

Open a new shell window and creat a new sub-net for Docker.
```
docker network create <network-name>
```
Then run Elasticsearch.
```
docker run -ti --rm -p 9200:9200 --net=elk --name es5 arm64/es5
```
Open a new shell window and then run Kibana.
```
docker run -ti --rm -p 5601:5601 --net=elk --name k5 arm64/k5
```

## Test

Please read [README.md](https://github.com/mason-mx/ELK-Docker/blob/master/README.md) for details of testing them.
