#!/bin/bash -x

# Evaluate variables in the value of HZ_* env vars
for var in ${!HZ_@}; do
	export ${var}="`eval echo -e ${!var}`"
done

# Default public port to same as bind port
HZ_PUBLIC_PORT=${HZ_PUBLIC_PORT:-${HZ_PORT}}

if [ "$HZ_PORT" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.port=$HZ_PORT"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.port"
fi

if [ "$HZ_PUBLIC_HOST" != "" ] && [ "$HZ_PUBLIC_PORT" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.public-address=$HZ_PUBLIC_HOST:$HZ_PUBLIC_PORT"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.public-address"
fi

if [ "$HZ_GROUP_NAME" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.group.name=$HZ_GROUP_NAME -Dhazelcast.group.password=$HZ_GROUP_PASSWORD"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.group.name -Dhazelcast.group.password"
fi

if [ "$HZ_ZK_URL" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.zk.url=$HZ_ZK_URL"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.zk.url"
fi

JAR="$HZ_HOME/hazelcast-all-$HZ_VERSION.jar:$HZ_HOME/hazelcast-zookeeper-3.7-SNAPSHOT.jar"
#if [ ! -e "$JAR" ]; then
#	echo "Failed to find Hazelcast JAR file at $JAR"
#	exit 1
#fi

echo
echo java -cp $JAR $JAVA_OPTS -Dhazelcast.config=$HZ_HOME/hazelcast.xml com.hazelcast.core.server.StartServer
echo

exec java -cp $JAR $JAVA_OPTS -Dhazelcast.config=$HZ_HOME/hazelcast.xml com.hazelcast.core.server.StartServer
