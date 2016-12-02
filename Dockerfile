FROM resin/rpi-raspbian:jessie
MAINTAINER Janek Thomaschewski <janek_docker@jbbr.net>

ARG GRAFANA_VERSION

RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
    apt-get clean && \
    curl -L -o /tmp/grafana.deb https://dl.bintray.com/fg2it/deb/main/g/grafana_${GRAFANA_VERSION}_armhf.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    curl -L https://github.com/tianon/gosu/releases/download/1.10/gosu-armhf > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
