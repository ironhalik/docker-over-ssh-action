FROM alpine:3.11

ENV DOCKER_DOWNLOAD_URL=https://download.docker.com/linux/static/stable/x86_64/docker-19.03.6.tgz

RUN apk add --no-cache \
    openssh-client \
    bash \
    curl \
    python3 \
    py3-pip&&\
    curl -s -L ${DOCKER_DOWNLOAD_URL} | tar -xz -C /tmp/ &&\
    mv /tmp/docker/docker /usr/local/bin &&\
    pip3 install --no-cache-dir awscli &&\
    rm -rf /tmp/* &&\
    apk del --purge curl py3-pip &&\
    mkdir -p /root/.ssh

COPY ssh-config /root/.ssh/config

RUN chmod 600 /root/.ssh/config

COPY entrypoint.sh wait-for-stack /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
