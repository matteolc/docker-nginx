FROM nginx

LABEL \
	io.voxbox.build-date=${BUILD_DATE} \
	io.voxbox.name=nginx \
	io.voxbox.vendor=voxbox.io \
    maintainer=matteo@voxbox.io \
	io.voxbox.vcs-url=https://github.com/matteolc/docker-nginx.git \
	io.voxbox.vcs-ref=${VCS_REF} \
	io.voxbox.license=MIT

# Install the NGINX Amplify Agent
RUN apt-get update \
    && apt-get install -y curl python apt-transport-https apt-utils gnupg1 procps openssl \
    && echo 'deb https://packages.amplify.nginx.com/debian/ stretch amplify-agent' > /etc/apt/sources.list.d/nginx-amplify.list \
    && curl -fs https://nginx.org/keys/nginx_signing.key | apt-key add - > /dev/null 2>&1 \
    && apt-get update \
    && apt-get install -qqy nginx-amplify-agent \
    && apt-get purge -qqy curl apt-transport-https apt-utils gnupg1 \
    && rm -rf /var/lib/apt/lists/*

ARG DH_SIZE

ENV APP=nginx \
    DH_SIZE=${DH_SIZE:-"2048"}

ENV HOME=/etc/${APP} \
    LOGDIR=/var/log/${APP}

# Keep the nginx logs inside the container
RUN unlink ${LOGDIR}/access.log \
    && unlink ${LOGDIR}/error.log \
    && touch ${LOGDIR}/access.log \
    && touch ${LOGDIR}/error.log \
    && chown nginx ${LOGDIR}/*log \
    && chmod 644 ${LOGDIR}/*log

RUN rm -Rf ${HOME}/conf.d/* \
    && rm ${HOME}/nginx.conf \
    && mkdir ${HOME}/conf.d/location \
    && mkdir ${HOME}/ssl
COPY build/nginx.conf ${HOME}/nginx.conf
COPY build/conf.d/ssl.conf ${HOME}/conf.d
# Copy nginx stub_status config
COPY build/conf.d/stub_status.conf ${HOME}/conf.d
COPY build/conf.d/location/default ${HOME}/conf.d/location

# API_KEY is required for configuring the NGINX Amplify Agent.
# It could be your real API key for NGINX Amplify here if you wanted
# to build your own image to host it in a private registry.
# However, including private keys in the Dockerfile is not recommended.
# Use the environment variables at runtime as described below.
ARG API_KEY
ENV API_KEY=${API_KEY:-}

# If AMPLIFY_IMAGENAME is set, the startup wrapper script will use it to
# generate the 'imagename' to put in the /etc/amplify-agent/agent.conf
# If several instances use the same 'imagename', the metrics will
# be aggregated into a single object in NGINX Amplify. Otherwise Amplify
# will create separate objects for monitoring (an object per instance).
# AMPLIFY_IMAGENAME can also be passed to the instance at runtime as
# described below.

ARG AMPLIFY_IMAGENAME
ENV AMPLIFY_IMAGENAME=${AMPLIFY_IMAGENAME:-my-docker-instance-123}

ARG NGINX_HOST
ENV NGINX_HOST=${NGINX_HOST:-"localhost"}

# The /entrypoint.sh script will launch nginx and the Amplify Agent.
# The script honors API_KEY and AMPLIFY_IMAGENAME environment
# variables, and updates /etc/amplify-agent/agent.conf accordingly.

COPY runtime/ ${HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# TO set/override API_KEY and AMPLIFY_IMAGENAME when starting an instance:
# docker run --name my-nginx1 -e API_KEY='..effc' -e AMPLIFY_IMAGENAME="service-name" -d nginx-amplify

ENTRYPOINT ["/sbin/entrypoint.sh"]



