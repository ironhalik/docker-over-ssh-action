FROM alpine:3.24

ENV PYTHONUNBUFFERED=1

ENV DOCKER_VERSION=29.9.0

RUN apk add --no-cache \
    openssh-client \
    bash \
    curl \
    aws-cli &&\
    curl -fsSL https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz | tar -xz -C /tmp/ &&\
    mv /tmp/docker/docker /usr/local/bin &&\
    rm -rf /tmp/* &&\
    apk del --purge curl &&\
    mkdir -p /root/.ssh

COPY ssh-config /root/.ssh/config

RUN chmod 600 /root/.ssh/config

COPY entrypoint.sh wait-for-stack tail-service-until /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
