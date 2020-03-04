FROM ubuntu:14.04

# install xrdp, create user 'ubuntu' with password 'ubuntu'
# different password can be produced by: $(openssl passwd -1 'PASSWORD_HERE')
RUN apt-get update && \
    apt-get install -y xrdp && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh
RUN ["chmod", "+x", "/root/entrypoint.sh"]
ENTRYPOINT ["/root/entrypoint.sh"]

