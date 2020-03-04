#!/bin/bash -ex

# set up student user
addgroup --gid 999 student
useradd -m -u 999 -s /bin/bash -g student student
echo 'student:$1$HQ0IICOH$TMl3CWh6xP/EipmQMYUHn1' | /usr/sbin/chpasswd -e
echo 'student ALL=(ALL) ALL' >> /etc/sudoers

# enable debug logging for xrdp
echo '[Logging]' >> /etc/xrdp/xrdp.ini
echo 'LogLevel=DEBUG' >> /etc/xrdp/xrdp.ini

# generate xrdp keys
xrdp-keygen xrdp auto

# start xrdp components and tail the logs
/usr/sbin/xrdp-sesman --nodaemon &
sleep 1
tail -f /var/log/xrdp-sesman.log &
/usr/sbin/xrdp -nodaemon
