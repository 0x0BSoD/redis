FROM alpine:3.8

ENV REDIS_PASS      devpassword
ENV REDIS_BIND      0.0.0.0
ENV REDIS_PORT      6397

# install dependencys
RUN apk add wget curl g++ lua linux-headers make tcl git tini

# build redis
RUN wget http://download.redis.io/redis-stable.tar.gz && \
    tar -xvzf redis-stable.tar.gz                     && \
    cd redis-stable && make install                   && \
    mkdir /etc/redis                                  && \
    mkdir /var/redis                                  && \
    mkdir /data                                       && \
    addgroup redis                                    && \
    adduser -S -H -G redis redis                      && \
    chown redis:redis /var/redis                      && \
    chmod 770 /var/redis

# build rejson
RUN git clone https://github.com/RedisLabsModules/rejson.git && \
    cd rejson && make && mv src/rejson.so /etc/redis

COPY redis.conf /etc/redis/
COPY entrypoint.sh /srv

RUN ["chmod", "+x", "/srv/entrypoint.sh"]

ENTRYPOINT ["/bin/sh", "-c", "/srv/entrypoint.sh"]