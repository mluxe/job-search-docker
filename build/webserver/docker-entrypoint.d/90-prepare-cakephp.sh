#!/bin/bash


DIR=/var/www/html/api

cd $DIR

if ping -c 1 getcomposer.org > /dev/null 2>&1; then
  echo "> install cakephp packages"
  composer install
else
  echo "! getcomposer.org is not reachable, skip composer install."
fi

echo "> update file permissions"

if [ ! -f $DIR/logs/error.log ]
then
	touch $DIR/logs/error.log
fi
chown -R www-data:www-data tmp
chown -R www-data:www-data logs

#cp config/.env.example config/.env

rm config/.env
echo "> prepare env variables"
echo > config/.env
env | sort |  grep -v "^_" | grep -v "^PATH" | sed 's/^/export /' >> config/.env

#cat config/.env
#
#
echo "> clear cakephp cache"
rm -rf /var/www/html/api/tmp/cache/*

