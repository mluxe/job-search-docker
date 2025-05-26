#!/bin/bash

DIR=/var/www/html/api

git config --global credential.helper store

cat "https://$GITHUB_USER:$GITHUB_TOKEN@github.com" >> ~/.git-credentials

if [ -d $DIR/.git ]
then
	echo "> update api project code"
	cd $DIR
	git reset --hard
	git pull
else
	echo "> clone api project code"
	mkdir /var/www/html/api -p
	cd $DIR
	git clone https://github.com/mluxe/job-search-api.git $DIR
fi


if [ -d /opt/react ]
then
	echo "> update react project code"
	cd /opt/react
	git reset --hard
	git pull
else
	echo "> clone react project code"
	mkdir /opt/react -p
	cd /opt/react
	git clone https://github.com/mluxe/job-search-web.git /opt/react
fi

git submodule set-url packages/framework/react https://github.com/mluxe/js-framework-react.git
git submodule set-url packages/framework/core https://github.com/mluxe/js-framework-core.git
git submodule sync
git submodule update --init --recursive


# apply config
#

if [ -f /opt/app_config/app_local.php ]
then
	echo "> apply api config: app_local.php"
	cp /opt/app_config/app_local.php /var/www/html/api/config/app_local.php
else
	echo "! api config not found, expecting /opt/app_config/app_local.php"
fi

if [ -f /opt/app_config/config.js ]
then
	echo "> apply react config: config.js"
	cp /opt/app_config/config.js /opt/react/src/configs/config.js
else
	echo "! react config not found, expecting /opt/app_config/config.js"
fi
