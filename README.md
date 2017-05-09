# docker-xo

Alpine Linux based Xen Orchestra Community Docker Image

## Requirements

You will need the docker daemon and docker-compose installed.

## Docker-compose Example

Save the following snippet as docker-compose.yaml in any folder you like.

```
xo:
  image: interlegis/xen-orchestra:latest
  ports:
    - "8080:80"
  links:
    - redis:redis
  volumes:
    - 'xodata:/var/lib/xo-server/data'
redis:
  image: bitnami/redis:latest
  environment:
    - REDIS_REPLICATION_MODE=master
    - REDIS_PASSWORD=aGoodRedisPassword
  volumes:
    - 'xoredisdata:/bitnami/redis'
```

## Running

```
cd <folder where docker-compose.yaml is>
docker-compose up -d
```

## Contributing

Pull requests welcome!

