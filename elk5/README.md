# Instructions for Docker

Here are the instructions to build and run images.

## Build

Build ElasticSearch image.
```
docker build -t arm64/elk-es5.6.5 -f /path/to/a/Dockerfile-es .
```
Build Filebeat image.
```
docker build -t arm64/filebeat5.6.5 -f /path/to/a/Dockerfile-filebeat .
```
Build Kibana image.
```
docker build -t arm64/elk-k5.6.5 -f /path/to/a/Dockerfile-k .
```

## Running

Open a new shell window and creat a new sub-net for Docker.
```
docker network create <network-name>
```
Then run ElasticSearch.
```
docker run -ti --rm -p 9200:9200 --net=elk5 --name es5 arm64/elk-es5.6.5
```
Open a new shell window and then run Filebeat and input the host IP address.
```
docker run -ti --rm arm64/filebeat5.6.5
```
Open a new shell window and then run Kibana.
```
docker run -ti --rm -p 5601:5601 --net=elk5 --name k5 arm64/elk-k5.6.5
```

## Test

Please read [README.md](https://github.com/mason-mx/ELK-Docker/blob/master/README.md) for details of testing them.
