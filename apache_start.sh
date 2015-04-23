#!/bin/bash

#cat /proc/mounts > /etc/mtab
chown :www-data -R /var/www
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

source /etc/apache2/envvars && exec apache2 -DFOREGROUND

