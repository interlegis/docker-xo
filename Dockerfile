FROM debian:jessie
MAINTAINER Fabio Rauber <fabiorauber@gmail.com>

ENV REDIS_SERVER="redis" \
    REDIS_PORT="6379"

WORKDIR /opt

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y nfs-common curl && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y nodejs && \
    curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n && \
    chmod +x /usr/local/bin/n && \
    n stable && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y build-essential libpng12-dev git python-minimal && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b stable https://github.com/vatesfr/xo-server && \
    git clone -b stable https://github.com/vatesfr/xo-web && \
    cd /opt/xo-web && \
    git checkout tags/5.1.9 && \
    cd /opt/xo-server && \
    git checkout tags/5.1.6 && \
    npm install && npm run build && \
    cp sample.config.yaml .xo-server.yaml && \
    sed -i /mounts/a\\"    '/': '/opt/xo-web/dist'" .xo-server.yaml && \
    cd /opt/xo-web && \
    npm i lodash.trim@3.0.1 && \
    npm install && npm run build

RUN cd /opt/xo-server/node_modules && \
    git clone https://github.com/vatesfr/xo-server-auth-ldap.git && \
    cd xo-server-auth-ldap && \
    git checkout tags/v0.5.1 && \
    npm run build || npm install || npm run build

EXPOSE 80

ADD src/ /opt/xo-web/dist/

ADD start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
