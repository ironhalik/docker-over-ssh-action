FROM alpine:3.11

ENV DOCKER_DOWNLOAD_URL=https://download.docker.com/linux/static/stable/x86_64/docker-19.03.6.tgz

RUN apk add --no-cache \
    openssh-client \
    bash \
    curl &&\
    curl -s -L ${DOCKER_DOWNLOAD_URL} | tar -xz -C /tmp/ &&\
    mv /tmp/docker/docker /usr/local/bin &&\
    rm -rf /tmp/* &&\
    apk del --purge curl &&\
    mkdir -p /root/.ssh

COPY ssh-config /root/.ssh/config

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
