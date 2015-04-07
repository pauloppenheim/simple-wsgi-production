#!/bin/bash

# assuming this is run as root

DATA_DIR=$(dirname $(readlink -f $0))
if [ ! -d ${DATA_DIR}/static/ ] ; then
	DATA_DIR=/vagrant
fi

update() {
	# Update if there hasn't been an apt-get update in the past day (1440 min)
	if [ ! $(find "/var/lib/apt/periodic/update-success-stamp" -cmin -1440 | wc -l) -eq 1 ] ; then
		aptitude update
		aptitude -q=2 -y upgrade
	fi
}

install_dev_tools() {
	aptitude -q=2 -y install vim
}

install_web_server() {
	echo install_web_server
	aptitude -q=2 -y install nginx
	aptitude -q=2 -y install build-essential python-dev
	# I'M SORRY
	aptitude -q=2 -y install python-setuptools python-virtualenv
	easy_install pip
	# the debian / ubuntu uwsgi is pretty old
	#pip install uwsgi
	# nvm, forget uwsgi
	aptitude -q=2 -y install gunicorn
}

setup_web_data() {
	echo setup_web_data
	mkdir /webserver 2>/dev/null
	rsync -a ${DATA_DIR}/static/ /webserver/static
	rsync -a ${DATA_DIR}/app/ /webserver/app
	rsync -a ${DATA_DIR}/etc/ /etc
	virtualenv /webserver/venv
	ln -sf /etc/nginx/sites-available/simplewsgipro /etc/nginx/sites-enabled/
	rm /etc/nginx/sites-enabled/default 2> /dev/null
	# upstart daemon for gunicorn
	initctl restart simplewsgipro-app
	initctl start simplewsgipro-app
	nginx -s reload
}

main() {
	update
	install_web_server
	setup_web_data
	if [ "x$INSTALL_DEV_TOOLS" != "x" ] ; then
		install_dev_tools
	fi
}

main

echo
echo "vm_bootstrap setup complete"
