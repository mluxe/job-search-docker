#!/bin/bash



cd /opt/react

last_build=""

if [ -f ./build/last_build.checksum ]
then
	last_build=$(cat ./build/last_build.checksum)
fi

current_version=$(git log | head -n 1 | sed 's/commit //')


echo "> last build:   $last_build"
echo "> curr. commit: $current_version"

git log | head -n 6


if [ "$last_build" != "$current_version" ]
then

  if ping -c 1 npmjs.com > /dev/null 2>&1; then
    echo ">  install packages"
    npm install
  else
    echo "! npmjs.com is not reachable, skip npm install."
  fi

	echo ">  build application"
	npm run build
	echo $current_version > ./build/last_build.checksum

	echo ">  deploy application"
	cp -R ./build/* /var/www/html
else
	echo "> version unchanged, skip react app build"
fi

cp ./build/.htaccess /var/www/html

