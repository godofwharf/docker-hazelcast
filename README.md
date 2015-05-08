# Hazelcast
Hazelcast with clustering configuration based off the official Hazelcast Docker image. Uses 
multicast to automatically form a cluster. 

## Environment Variables
The default parameters can be overridden by setting environment variables on the container using the **docker run -e** flag.

 * **HZ_GROUP_NAME** - Group name to avoid different clusters from joining each other.
 * **HZ_GROUP_PASSWORD** - Password required to join the cluster.

## Deployment
Deployment and clustering config examples.

### Marathon

```
{
  "id": "/myproduct/mysubsystem/hazelcast",
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "meltwater/hazelcast:latest"
    }
  },
  "ports": [
    0
  ],
  "env": {
    "HZ_GROUP_NAME": "mygroup",
    "HZ_GROUP_PASSWORD": "secret"
  },
  "instances": 3
}
```

### Puppet Hiera

Using the [garethr-docker](https://github.com/garethr/garethr-docker) module

```
classes:
  - docker::run_instance

docker::run_instance:
  'hazelcast':
    image: 'meltwater/hazelcast:latest'
    net: 'host'
    env:
      - "HZ_GROUP_NAME=mygroup"
      - "HZ_GROUP_PASSWORD=secret"
```

### Command Line
```
docker run --net=host \
  -e HZ_GROUP_NAME=mygroup \
  -e HZ_GROUP_PASSWORD=secret \
  meltwater/hazelcast:latest
```
