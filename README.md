# ELK (ElasticSearch, LogStash, Kibana) Development and Deployment for Docker

Here are the projects of ELK running on ARM64, which requires much different scripts and commands from x86.

## ELK5.6.x

Before 6.x, 5.6.x is the latest version for ELK, which are able to be obtained from the internet.

### ElasticSearch 5.6.5

#### Prerequisites

Since it is JAVA-based code, JDK is the most essential component to run it. To check your Java version, run the following command: 'java -version'.

#### Installing

* Download the [past releases](https://www.elastic.co/downloads/past-releases)
* Extract the '.zip' or 'tar.gz' archive file
* Change the ownership of the folder

#### Running and test

Open a new shell window and run Elasticsearch.
```
<path_to_elasticsearch_root_dir>/bin/elasticsearch 
```

Elasticsearch should now be running on port 9200. 

To test, point your browser at port 9200 (http://localhost:9200). You should see output similar to the following with status code of 200.
```
{
  "status" : 200,
  "name" : "James Howlett",
  "cluster_name" : "elasticsearch",
     ... truncated output 
}
```

Or run 'curl -X GET 'http://localhost:9200''. You should see the following response:
```
{
  "status" : 200,
  "name" : "Harry Leland",
  "cluster_name" : "elasticsearch",
  "version" : {
    "number" : "1.7.2",
    "build_hash" : "e43676b1385b8125d647f593f7202acbd816e8ec",
    "build_timestamp" : "2015-09-14T09:49:53Z",
    "build_snapshot" : false,
    "lucene_version" : "4.10.4"
  },
  "tagline" : "You Know, for Search"
}
```

### Kibana 5.6

#### Prerequisites

As there is no existing binary package for ARM64 platform, node tool and the further steps using node/npm are required.

#### Installing

* Download node for [ARM64 binary package](https://nodejs.org/download/release/v8.9.0/node-v8.9.0-linux-arm64.tar.gz)
* Extract the '.zip' or 'tar.gz' archive file
* Add node/npm to be envirement variables by export <path_to_node_root_dir>/bin to 'PATH'
* Fork, then clone the [kibana repo](https://github.com/elastic/kibana.git) and change directory into it
* Switch to branch 5.6
* Install 'npm' dependencies

#### Running and test

If you're just getting started with 'elasticsearch', you could use the following command to populate your instance with a few fake logs to hit the ground running.
```
node scripts/makelogs
```
>Make sure to execute node scripts/makelogs after elasticsearch is up and running!

Start the development server.
```
npm start
```
>On Windows, you'll need you use Git Bash, Cygwin, or a similar shell that exposes the sh command. And to successfully build you'll need Cygwin optional packages zip, tar, and shasum.

Kibana should now be running on port 5601. To test, point your web browser at port 5601 ('https://IPAddress/localhost:5601'). You should see the Kibana UI.
