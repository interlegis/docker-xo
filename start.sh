#!/bin/bash

cd /opt/xo-server

# Replace Redis Server configuration
if [ ! -z "$REDIS_ENV_REDIS_PASSWORD" ]; then
  sed -i "s/#uri: ''/uri: 'redis://0:$REDIS_ENV_REDIS_PASSWORD@$REDIS_SERVER:$REDIS_PORT'/" .xo-server.yaml
else
  sed -i "s/#uri: ''/uri: 'redis://$REDIS_SERVER:$REDIS_PORT'/" .xo-server.yaml
fi

# Start Xen Orchestra
echo "Starting Xen Orchestra..."
exec /usr/local/bin/node ./bin/xo-server
