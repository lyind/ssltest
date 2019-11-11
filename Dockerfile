FROM openjdk:11-jre-slim
MAINTAINER Jonas Zeiger <jonas.zeiger@talpidae.net>

# java-11 SSL test application
#
# Don't forget to mount the following paths:
#   /etc/ssl          # host SSL certificate store

# escape=`

# install additional dependencies
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        procps \
        net-tools \
        lsof \
        htop \
	&& apt-get clean

# create application images base directory
RUN mkdir /app && mkdir /app/libs && chown daemon:daemon /app

# 1. set unusable root password (prevent su in container)
# 2. remove backup files
RUN sed -ie 's/^root::/root:!:/' /etc/shadow \
    && rm -rf /etc/shadow- /etc/passwd- /etc/group-

VOLUME /etc/ssl

# copy ssltest JAR archive
COPY [ \
    "build/ssltest.jar", \
    "ssltest.sh", \
	"/app/" \
]
RUN chown daemon /app -R && chmod a+rx /app/ssltest.sh

USER daemon

# Execute service manager instance (responsible for booting and managing micro-services)
# Access port 13300 for management UI
ENTRYPOINT ["/app/ssltest.sh"]

