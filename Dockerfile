FROM opsgang/devbox_aws:stable

MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL \
      name="jinal--shah/devbox_aws_coreos" \
      vendor="sortuniq" \
      description=" \
... see https://github.com/opsgang/docker_devbox_aws\n\
- adds shadow tools (useradd, usermod etc ...)\n\
- creates docker group to use host's docker.sock file\n\
- creates core user and sets workdir to /projects\
"

ARG DOCKER_GID=233

COPY assets /assets

RUN sh /assets/alpine_build_scripts/coreos_poweruser.sh \
    && sh /assets/build.sh $DOCKER_GID \
    && rm -rf /assets

WORKDIR /projects

USER core
