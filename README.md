# docker-xo

Xen Orchestra Community Docker Image

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
redis:
  image: redis:3-alpine
```

## Running

```
cd <folder where docker-compose.yaml is>
docker-compose up -d
```

## Contributing

Pull requests welcome!

