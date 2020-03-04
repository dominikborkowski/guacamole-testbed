ARG UBUNTU_VERSION
ARG RDP_PACKAGE
FROM ubuntu:${UBUNTU_VERSION:-14.04}

# install xrdp
RUN apt-get update && \
    apt-get install -y xrdp xterm ${RDP_PACKAGE} && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh
RUN ["chmod", "+x", "/root/entrypoint.sh"]
ENTRYPOINT ["/root/entrypoint.sh"]

