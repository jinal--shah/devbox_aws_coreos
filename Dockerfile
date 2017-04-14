FROM opsgang/devbox_aws:stable

MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL \
      name="jinal--shah/devbox_aws_coreos" \
      vendor="sortuniq" \
      description=" \
... see https://github.com/opsgang/docker_devbox_aws \
- creates core user as default and workdir /projects \
"

COPY assets /assets

RUN sh /assets/alpine_build_scripts/coreos_poweruser.sh \
    && rm -rf /assets

WORKDIR /projects

USER core
