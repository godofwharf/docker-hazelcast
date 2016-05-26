FROM hazelcast/hazelcast:latest

ADD hazelcast.xml /opt/hazelcast/
ADD hazelcast-zookeeper-3.7-SNAPSHOT.jar /opt/hazelcast/
ADD launch.sh /

ENTRYPOINT /launch.sh
CMD ""
