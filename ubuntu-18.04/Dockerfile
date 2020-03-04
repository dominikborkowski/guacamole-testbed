FROM ubuntu:18.04

# install xrdp
RUN apt-get update && \
    apt-get install -y xrdp && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh
RUN ["chmod", "+x", "/root/entrypoint.sh"]
ENTRYPOINT ["/root/entrypoint.sh"]

