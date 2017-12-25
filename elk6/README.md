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
docker network create <network-name> in this case named **elk6**
```
Then run ElasticSearch.
```
docker run -ti --rm -p 9200:9200 --net=**elk6** --name es6 arm64/elk-es6.0.1
```
Open a new shell window and then run Filebeat and input the host IP address.
```
docker run -ti --rm arm64/filebeat6.0.1
```
Open a new shell window and then run Kibana.
```
docker run -ti --rm -p 5601:5601 --net=**elk6** --name k6 arm64/elk-k6.0.1
```

## Test

Please read [README.md](https://github.com/mason-mx/ELK-Docker/blob/master/README.md) for details of testing them.

## Known Issues

* There is no map showing on the page of any case in dashboard.

The warning message displayed on the top of the page is:
> Coordinate Map: Could not retrieve manifest from the tile service: status -1

* There is a warning when clicking any case in dashboard
```
Deprecation warning: moment construction falls back to js Date. This is discouraged and will be removed in upcoming major release. Please refer to https://github.com/moment/moment/issues/1407 for more info.
Arguments: [object Object]
Error
    at Function.createFromInputFallback (/opt/kibana/node_modules/moment/moment.js:271:105)
    at configFromString (/opt/kibana/node_modules/moment/moment.js:1169:32)
    at configFromInput (/opt/kibana/node_modules/moment/moment.js:1675:13)
    at prepareConfig (/opt/kibana/node_modules/moment/moment.js:1658:13)
    at createFromConfig (/opt/kibana/node_modules/moment/moment.js:1625:44)
    at createLocalOrUTC (/opt/kibana/node_modules/moment/moment.js:1707:16)
    at local__createLocal (/opt/kibana/node_modules/moment/moment.js:1711:16)
    at utils_hooks__hooks (/opt/kibana/node_modules/moment/moment.js:16:29)
    at parse (/opt/kibana/src/core_plugins/timelion/server/lib/date_math.js:36:12)
    at validateTime (/opt/kibana/src/core_plugins/timelion/server/handlers/lib/validate_time.js:5:16)
    at Object.processRequest (/opt/kibana/src/core_plugins/timelion/server/handlers/chain_runner.js:163:5)
    at handler (/opt/kibana/src/core_plugins/timelion/server/routes/run.js:29:53)
    at <anonymous>
```
* There are many JAVA exceptions when feeding data to es6.0.1
```
org.elasticsearch.index.mapper.MapperParsingException: failed to parse
        at org.elasticsearch.index.mapper.DocumentParser.wrapInMapperParsingException(DocumentParser.java:175) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseDocument(DocumentParser.java:70) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentMapper.parse(DocumentMapper.java:261) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.prepareIndex(IndexShard.java:721) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.applyIndexOperation(IndexShard.java:699) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.applyIndexOperationOnPrimary(IndexShard.java:680) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeIndexRequestOnPrimary(TransportShardBulkAction.java:548) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeIndexRequest(TransportShardBulkAction.java:140) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeBulkItemRequest(TransportShardBulkAction.java:236) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.performOnPrimary(TransportShardBulkAction.java:123) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.shardOperationOnPrimary(TransportShardBulkAction.java:110) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.shardOperationOnPrimary(TransportShardBulkAction.java:72) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryShardReference.perform(TransportReplicationAction.java:1033) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryShardReference.perform(TransportReplicationAction.java:1011) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.ReplicationOperation.execute(ReplicationOperation.java:104) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.onResponse(TransportReplicationAction.java:358) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.onResponse(TransportReplicationAction.java:298) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$1.onResponse(TransportReplicationAction.java:974) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$1.onResponse(TransportReplicationAction.java:971) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShardOperationPermits.acquire(IndexShardOperationPermits.java:238) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.acquirePrimaryOperationPermit(IndexShard.java:2217) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction.acquirePrimaryShardReference(TransportReplicationAction.java:983) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction.access$500(TransportReplicationAction.java:97) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.doRun(TransportReplicationAction.java:319) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:37) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryOperationTransportHandler.messageReceived(TransportReplicationAction.java:294) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryOperationTransportHandler.messageReceived(TransportReplicationAction.java:281) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.transport.RequestHandlerRegistry.processMessageReceived(RequestHandlerRegistry.java:66) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.transport.TransportService$7.doRun(TransportService.java:659) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.ThreadContext$ContextPreservingAbstractRunnable.doRun(ThreadContext.java:638) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:37) [elasticsearch-6.0.1.jar:6.0.1]
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [?:1.8.0_151]
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [?:1.8.0_151]
        at java.lang.Thread.run(Thread.java:748) [?:1.8.0_151]
Caused by: java.lang.NumberFormatException: empty String
        at sun.misc.FloatingDecimal.readJavaFormatString(FloatingDecimal.java:1842) ~[?:?]
        at sun.misc.FloatingDecimal.parseDouble(FloatingDecimal.java:110) ~[?:?]
        at java.lang.Double.parseDouble(Double.java:538) ~[?:1.8.0_151]
        at org.elasticsearch.common.geo.GeoPoint.resetFromString(GeoPoint.java:80) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.GeoPointFieldMapper.parsePointFromString(GeoPointFieldMapper.java:290) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.GeoPointFieldMapper.parse(GeoPointFieldMapper.java:270) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseObjectOrField(DocumentParser.java:473) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseValue(DocumentParser.java:597) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.innerParseObject(DocumentParser.java:395) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseObjectOrNested(DocumentParser.java:372) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.internalParseDocument(DocumentParser.java:93) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseDocument(DocumentParser.java:67) ~[elasticsearch-6.0.1.jar:6.0.1]
        ... 32 more
[2017-12-25T07:53:24,354][DEBUG][o.e.a.b.TransportShardBulkAction] [ncedc-earthquakes-blast][0] failed to execute bulk item (index) BulkShardRequest [[ncedc-earthquakes-blast][0]] containing [25] requests
org.elasticsearch.index.mapper.MapperParsingException: failed to parse
        at org.elasticsearch.index.mapper.DocumentParser.wrapInMapperParsingException(DocumentParser.java:175) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseDocument(DocumentParser.java:70) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentMapper.parse(DocumentMapper.java:261) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.prepareIndex(IndexShard.java:721) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.applyIndexOperation(IndexShard.java:699) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.applyIndexOperationOnPrimary(IndexShard.java:680) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeIndexRequestOnPrimary(TransportShardBulkAction.java:548) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeIndexRequest(TransportShardBulkAction.java:140) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.executeBulkItemRequest(TransportShardBulkAction.java:236) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.performOnPrimary(TransportShardBulkAction.java:123) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.shardOperationOnPrimary(TransportShardBulkAction.java:110) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.bulk.TransportShardBulkAction.shardOperationOnPrimary(TransportShardBulkAction.java:72) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryShardReference.perform(TransportReplicationAction.java:1033) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryShardReference.perform(TransportReplicationAction.java:1011) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.ReplicationOperation.execute(ReplicationOperation.java:104) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.onResponse(TransportReplicationAction.java:358) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.onResponse(TransportReplicationAction.java:298) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$1.onResponse(TransportReplicationAction.java:974) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$1.onResponse(TransportReplicationAction.java:971) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShardOperationPermits.acquire(IndexShardOperationPermits.java:238) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.shard.IndexShard.acquirePrimaryOperationPermit(IndexShard.java:2217) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction.acquirePrimaryShardReference(TransportReplicationAction.java:983) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction.access$500(TransportReplicationAction.java:97) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$AsyncPrimaryAction.doRun(TransportReplicationAction.java:319) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:37) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryOperationTransportHandler.messageReceived(TransportReplicationAction.java:294) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.action.support.replication.TransportReplicationAction$PrimaryOperationTransportHandler.messageReceived(TransportReplicationAction.java:281) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.transport.RequestHandlerRegistry.processMessageReceived(RequestHandlerRegistry.java:66) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.transport.TransportService$7.doRun(TransportService.java:659) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.ThreadContext$ContextPreservingAbstractRunnable.doRun(ThreadContext.java:638) [elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:37) [elasticsearch-6.0.1.jar:6.0.1]
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [?:1.8.0_151]
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [?:1.8.0_151]
        at java.lang.Thread.run(Thread.java:748) [?:1.8.0_151]
Caused by: java.lang.NumberFormatException: empty String
        at sun.misc.FloatingDecimal.readJavaFormatString(FloatingDecimal.java:1842) ~[?:?]
        at sun.misc.FloatingDecimal.parseDouble(FloatingDecimal.java:110) ~[?:?]
        at java.lang.Double.parseDouble(Double.java:538) ~[?:1.8.0_151]
        at org.elasticsearch.common.geo.GeoPoint.resetFromString(GeoPoint.java:80) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.GeoPointFieldMapper.parsePointFromString(GeoPointFieldMapper.java:290) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.GeoPointFieldMapper.parse(GeoPointFieldMapper.java:270) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseObjectOrField(DocumentParser.java:473) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseValue(DocumentParser.java:597) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.innerParseObject(DocumentParser.java:395) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseObjectOrNested(DocumentParser.java:372) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.internalParseDocument(DocumentParser.java:93) ~[elasticsearch-6.0.1.jar:6.0.1]
        at org.elasticsearch.index.mapper.DocumentParser.parseDocument(DocumentParser.java:67) ~[elasticsearch-6.0.1.jar:6.0.1]
        ... 32 more
```

## Things to try

- [ ] to start a Filebeat container in the same subnet and feed data to `es6`
- [ ] to run elk6 on x86 machine to check the above issue of showing map

