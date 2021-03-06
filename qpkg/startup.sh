#!/bin/sh

for F in ipkg git nc mc mcedit sudo; do
	if [ -x /opt/bin/$F ] && [ ! -x /bin/$F ]; then
		ln -s /opt/bin/$F /bin/$F
	fi
done

if [ -d /etc/config/.gnupg ]; then
	rm -rf /share/homes/admin/.gnupg
	ln -sf /etc/config/.gnupg /share/homes/admin/.gnupg

	if [ ! -d /root/.gnupg ] && [ ! -h /root/.gnupg ]; then
		ln -s /etc/config/.gnupg /root/.gnupg
	fi
fi

if [ ! -d /root/.ssh ] && [ ! -h /root/.ssh ]; then
	ln -s /etc/config/ssh /root/.ssh
fi

if [ -f /etc/config/farmconfig ] && [ ! -f /etc/farmconfig ]; then
	ln -s /etc/config/farmconfig /etc/farmconfig
fi

if [ -x /opt/farm/config/get-local-backup-directory.sh ]; then
	path=`/opt/farm/config/get-local-backup-directory.sh`
	if [ ! -h $path ]; then
		if [ -d /share/HDA_DATA/.qpkg/ServerFarmer/backup ]; then
			ln -s /share/HDA_DATA/.qpkg/ServerFarmer/backup $path
		elif [ -d /share/MD0_DATA/.qpkg/ServerFarmer/backup ]; then
			ln -s /share/MD0_DATA/.qpkg/ServerFarmer/backup $path
		fi
	fi
fi
