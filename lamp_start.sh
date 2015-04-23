#!/bin/bash

trap "pkill -SIGTERM -P $$" SIGTERM

cat /proc/mounts > /etc/mtab

chown :www-data -R /var/www
while :
do
	ps ax | grep apache2 | grep -v grep -q || (echo "restarting apache2" && source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND &)
	sleep 10
done

