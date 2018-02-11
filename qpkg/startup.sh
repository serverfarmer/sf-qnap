#!/bin/sh

for F in ipkg git nc mc mcedit sudo; do
	if [ -x /opt/bin/$F ] && [ ! -x /bin/$F ]; then
		ln -s /opt/bin/$F /bin/$F
	fi
done

if [ -d /etc/config/.gnupg ] && [ ! -d /root/.gnupg ]; then
	ln -s /etc/config/.gnupg /root/.gnupg
fi

if [ -f /etc/config/farmconfig ] && [ ! -f /etc/farmconfig ]; then
	ln -s /etc/config/farmconfig /etc/farmconfig
fi

if [ -f /opt/farm/scripts/functions.custom ]; then
	. /opt/farm/scripts/functions.custom
	path=`local_backup_directory`
	if [ ! -h $path ]; then
		if [ -d /share/HDA_DATA/.qpkg/ServerFarmer/backup ]; then
			ln -s /share/HDA_DATA/.qpkg/ServerFarmer/backup $path
		elif [ -d /share/MD0_DATA/.qpkg/ServerFarmer/backup ]; then
			ln -s /share/MD0_DATA/.qpkg/ServerFarmer/backup $path
		fi
	fi
fi
