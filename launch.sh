#!/bin/bash -x

if [ "$HOST" != "" ] && [  "$PORT0" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.public-address=$HOST:$PORT0 -Dhazelcast.network.port=$PORT0"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.network.public-address -Dhazelcast.network.port"
fi

if [ "$HZ_GROUP_NAME" != "" ]; then
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.group.name=$HZ_GROUP_NAME -Dhazelcast.group.password=$HZ_GROUP_PASSWORD"
else
	JAVA_OPTS="$JAVA_OPTS -Dhazelcast.group.name -Dhazelcast.group.password"
fi


echo
echo JAVA_OPTS=$JAVA_OPTS
echo

exec java -server -cp $HZ_HOME/hazelcast-$HZ_VERSION.jar $JAVA_OPTS com.hazelcast.core.server.StartServer
