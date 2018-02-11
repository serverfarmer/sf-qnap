#!/bin/sh
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install


if [ "$OSTYPE" != "qnap" ]; then
	echo "aborting; this is not a QNAP device"
	exit 0
fi

echo "applying changes to QNAP crontab"
rm -f /tmp/cron/crontabs/admin
cat /etc/crontab |sed -e s/root\ //g >/etc/config/crontab
/etc/init.d/crond.sh restart


if [ -d /share/HDA_DATA/.qpkg ]; then
	path=/share/HDA_DATA/.qpkg/ServerFarmer
else
	path=/share/MD0_DATA/.qpkg/ServerFarmer
fi

mkdir -p $path

if [ ! -f $path/startup.sh ]; then
	echo "copying QPKG support files"
	cp -af /opt/farm/ext/qnap/qpkg/startup.sh /opt/farm/ext/qnap/qpkg/.*.gif $path
fi

if [ -f /etc/config/qpkg.conf ]; then
	if ! grep -q ServerFarmer /etc/config/qpkg.conf; then
		save_original_config /etc/config/qpkg.conf
		echo "configuring QPKG application"
		echo "[ServerFarmer]
Name = ServerFarmer
Display_Name = Server Farmer
Author = Fajne.IT
QPKG_File = ServerFarmer.qpkg
Version = `date +%Y.%m`
Date = `date +%Y-%m-%d`
Shell = $path/startup.sh
Install_Path = $path
Enable = TRUE
Status = complete" >>/etc/config/qpkg.conf
	fi
fi
