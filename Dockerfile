FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="Sys-Dig_Inspect"
ARG SYS_DIG_INSPECT_LINK="https://github.com/draios/sysdig-inspect/archive/refs/tags/v0.7.2.tar.gz"
ARG SYSDIG_INSPECT_VERSION="sysdig-inspect-0.7.2"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
# ENV FOO="BAR"

EXPOSE 8080

# Switch to non-root user
# USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
