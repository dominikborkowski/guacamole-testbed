#!/bin/sh

/usr/sbin/xrdp-sesman &
tail -f /var/log/xrdp-sesman.log &
/usr/sbin/xrdp -nodaemon

