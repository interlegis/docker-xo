#!/bin/bash

cd /opt/xo-server

# Replace Redis Server configuration
sed -i /#uri/a\\"    uri: 'redis://$REDIS_SERVER:$REDIS_PORT'" .xo-server.yaml

# Start Xen Orchestra
echo "Starting Xen Orchestra..."
exec /usr/local/bin/node ./bin/xo-server
