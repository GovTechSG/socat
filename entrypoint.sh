#!/bin/sh

# /bin/socat TCP-L:$LOCAL_PORT,fork,reuseaddr PROXY:$PROXY_HOST:$DEST_HOST:$DEST_PORT,proxyport=$PROXY_PORT
/bin/socat TCP-L:$LOCAL_PORT,fork,reuseaddr PROXY:$PROXY_HOST:$DEST_HOST:$DEST_PORT,proxyport=$PROXY_PORT,proxyauth=$PROXY_USER:$PROXY_PASS

# /bin/socat TCP-L:6660,fork,reuseaddr PROXY:54.169.177.112:bastion.rpaas.gdshive.com:22,proxyport=3128
# /bin/socat TCP-L:$LOCAL_PORT,fork,reuseaddr PROXY:$PROXY_HOST:$DEST_HOST:$DEST_PORT,proxyport=$PROXY_PORT
