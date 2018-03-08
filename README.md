# Outline
This docker container runs socat to setup a tunnel to squid proxy with credentials.
It will exposes a LOCAL_PORT to allow connection to remote site from squid proxy server.

## Docker build
```
$ docker build -t socat -f Dockerfile .
```
