# Outline
This docker container runs socat to setup a tunnel to squid proxy with credentials.
It will exposes a LOCAL_PORT to allow connection to remote site from squid proxy server.

## Docker build
```
$ docker build -t socat -f Dockerfile .
```

## Start docker container(s)
```
$ docker-compose up -d
```

## Stop docker container(s)
```
$ docker-compose down
```

## Squid user accounts
```
MariaDB [squid]> SELECT * FROM passwd;
```
| user                | password                                                         | enabled | fullname      | comment  |
|---------------------|------------------------------------------------------------------|---------|---------------|----------|
| agency1             | fd01c49d99cef6b481cc8dc5a84fc8b0b7612d7789d457fc262956d73b2739fd |       1 | Agency 1 User | pass1234 |
| agency2             | ce773607ed22e5eab3082c740814fc5233d6f9e0062a5d7434a53f85a497977b |       1 | Agency 2 User | pass1234 |
| nectar_i_spf_jarvis | 326e73e33d1f162448923be4700f347eabe083e8de0338293efe3f9cdab9ba81 |       1 | JARVIS User   | XrCcP4q4 |
| wallace             | 80e4e5f54ec7e5bb2ced21e96a39c0ff1882f95649cc69e5762cbdeff5f05241 |       1 | Wallace User  | pass1234 |

## /etc/squid/squid.conf
```
## JARVIS test
#acl nectar_i_spf_jarvis_port port 389
#acl nectar_i_spf_jarvis_port port 636
acl nectar_i_spf_jarvis_port port 22
acl nectar_i_spf_jarvis_port port 3389     # Destination RDP port

acl nectar_i_spf_jarvis_dst dst 10.8.2.161 # userad.rpaas.gdshive.com
acl nectar_i_spf_jarvis_dst dst 10.8.2.162 # sysad.rpaas.gdshive.com
acl nectar_i_spf_jarvis_dst dst 10.8.0.224 # Destination IP for bastion.rpass.gdshive.com
acl nectar_i_spf_jarvis_dst dst 10.8.1.5   # Destination IP for test-gw

acl ncsa_users_nectar_i_spf_jarvis proxy_auth nectar_i_spf_jarvis

http_access allow ncsa_users_nectar_i_spf_jarvis nectar_i_spf_jarvis_dst nectar_i_spf_jarvis_port
http_access deny nectar_i_spf_jarvis_dst
```

## view squid logs
```
$ ssh centos@10.8.0.158 -i ~/.ssh/rpaas.pem
# multitail /var/log/squid/access.log /var/log/squid/cache.log /var/log/squid/ext_mysql_auth.log
```

## View docker containers
```
$ docker ps
CONTAINER ID  IMAGE  COMMAND                 CREATED         STATUS         PORTS                   NAMES
b7cb1c2b3596  socat  "/bin/sh -- /usr/loc…"  21 minutes ago  Up 21 minutes  0.0.0.0:2815->8080/tcp  jarvis-ssh-test-gw
3d37c64d8024  socat  "/bin/sh -- /usr/loc…"  21 minutes ago  Up 21 minutes  0.0.0.0:2161->8080/tcp  jarvis-rdp-userad
```

## Test socat squid endpoints

```
# localhost:2815 ->
ssh ec2-user@127.0.0.1 -p 2815 -i ~/.ssh/rpaas.pem
```
```
curl -I --proxy http://54.169.177.112:3128 --proxy-basic --proxy-user nectar_i_spf_jarvis:XrCcP4q4 www.whatismyip.com 2>null | head -n1
```
