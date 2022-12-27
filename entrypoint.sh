#!/bin/sh

umask 0002
PUID=${PUID:-`id -u squeezeboxserver`}
PGID=${PGID:-`id -g squeezeboxserver`}

groupmod -o -g "$PGID" nogroup
usermod -o -u "$PUID" squeezeboxserver

if [ "$SQUEEZE_VOL" ] && [ -d "$SQUEEZE_VOL" ]; then
	for subdir in prefs logs cache; do
		mkdir -p $SQUEEZE_VOL/$subdir
		chown -R squeezeboxserver:nogroup $SQUEEZE_VOL/$subdir
	done
fi

myip=$( ip addr show eth0 | awk '$1 == "inet" {print $2}' | cut -f1 -d/ )
url="http://$myip:9000/"

echo ======================================================================
echo "$url"
echo ======================================================================
echo

umask 0002
exec squeezeboxserver --user squeezeboxserver --group nogroup \
        --prefsdir $SQUEEZE_VOL/prefs \
        --logdir $SQUEEZE_VOL/logs \
        --cachedir $SQUEEZE_VOL/cache "$@"
