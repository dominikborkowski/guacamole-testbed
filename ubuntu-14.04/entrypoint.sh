#!/bin/bash -ex

/usr/sbin/xrdp-sesman --nodaemon &
sleep 1
tail -f /var/log/xrdp-sesman.log &
/usr/sbin/xrdp -nodaemon

