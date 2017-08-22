FROM node:6.10-alpine
MAINTAINER Fabio Rauber <fabiorauber@gmail.com>

ENV REDIS_SERVER="redis" \
    REDIS_PORT="6379"

LABEL xo-server=5.11.0 xo-web=5.11.0

ENV USER=node USER_HOME=/home/node XOA_PLAN=5 DEBUG=xo:main

WORKDIR /home/node

RUN apk update && apk upgrade && \
    apk add --no-cache git python g++ make && \
    git clone -b stable http://github.com/vatesfr/xo-server && \
    git clone -b stable http://github.com/vatesfr/xo-web && \
    rm -rf xo-server/.git xo-web/.git xo-server/sample.config.yaml && \
    yarn global add node-gyp && \
    cd /home/node/xo-server && yarn && yarn run build && yarn clean && \
    cd /home/node/xo-web && yarn && yarn run build && yarn clean && \
    yarn global remove node-gyp && \
    # install auth-ldap
    cd /home/node/xo-server/node_modules && \
    git clone https://github.com/vatesfr/xo-server-auth-ldap.git && \
    cd xo-server-auth-ldap && \
    git checkout tags/v0.6.0 && \
    yarn && yarn run build && yarn clean && \
    # clean a bit
    apk del git python g++ make && \
    rm -rf /root/.cache /root/.node-gyp /root/.npm

COPY xo-server.config.yaml /home/node/xo-server/.xo-server.yaml

EXPOSE 80

ADD start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
