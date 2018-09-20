#!/bin/sh
set -euo pipefail

: ${REDIS_PASS:=devpassword}
: ${REDIS_PORT:=0.0.0.0}
: ${REDIS_BIND:=6397}

sed -i "s/requirepass {{REDIS_PASS}}/requirepass ${REDIS_PASS}/" /etc/redis/redis.conf
sed -i "s/port {{REDIS_PORT}}/port ${REDIS_PORT}/" /etc/redis/redis.conf
sed -i "s/bind {{REDIS_BIND}}/bind ${REDIS_BIND}/" /etc/redis/redis.conf

redis-server /etc/redis/redis.conf
