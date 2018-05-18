#!/bin/sh

cd /home/node/xen-orchestra/packages/xo-server

# Replace Redis Server configuration
if [ ! -z "$REDIS_ENV_REDIS_PASSWORD" ]; then
  sed -i "s|#uri: ''|uri: 'redis://0:$REDIS_ENV_REDIS_PASSWORD@$REDIS_SERVER:$REDIS_PORT'|" .xo-server.yaml
else
  sed -i "s|#uri: ''|uri: 'redis://$REDIS_SERVER:$REDIS_PORT'|" .xo-server.yaml
fi

# storage directory and fix perms
mkdir -p /var/lib/xo-server/data 
chown -R ${USER}:${USER} /var/lib/xo-server/data

# Start Xen Orchestra
echo "Starting Xen Orchestra..."
cd /home/node/xen-orchestra/packages/xo-server && exec yarn start
