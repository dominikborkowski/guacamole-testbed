#!/bin/bash -ex

echo '[Logging]' >> /etc/xrdp/xrdp.ini
echo 'LogLevel=DEBUG' >> /etc/xrdp/xrdp.ini

xrdp-keygen xrdp auto

/usr/sbin/xrdp-sesman --nodaemon &
sleep 1
tail -f /var/log/xrdp-sesman.log &
/usr/sbin/xrdp -nodaemon

