#!/bin/bash -ex

# create user 'ubuntu' with password 'ubuntu'
# different password can be produced by: $(openssl passwd -1 'PASSWORD_HERE')
if ! grep -q ^ubuntu /etc/passwd; then
    addgroup --gid 1000 ubuntu
    useradd -m -u 1000 -s /bin/bash -g ubuntu ubuntu
    echo 'ubuntu:$1$ke6ANMsy$IMwFu5kYAnrsUyKs93EYV1' | /usr/sbin/chpasswd -e
    # make sure group ubuntu can login to xrdp
    sed -i '/^TerminalServerUsers/s/tsusers/ubuntu/' /etc/xrdp/sesman.ini
fi

# enable debug logging for xrdp
if ! grep -q LogLevel /etc/xrdp/ini; then
    echo '[Logging]' >> /etc/xrdp/xrdp.ini
    echo 'LogLevel=DEBUG' >> /etc/xrdp/xrdp.ini
fi

# run basic xterm for our rdp session
if ! grep -q xterm /etc/xrdp/startwm.sh; then
    echo xterm >> /etc/xrdp/startwm.sh
fi

# generate xrdp keys
 if [ ! -s /etc/xrdp/rsakeys.ini ]; then
    xrdp-keygen xrdp auto
fi

# start xrdp components and tail the logs
/usr/sbin/xrdp-sesman --nodaemon &
sleep 1
tail -f /var/log/xrdp-sesman.log &
/usr/sbin/xrdp -nodaemon
