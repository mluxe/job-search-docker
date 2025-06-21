#!/bin/bash

PROJ_DIR=/project
DIR=/var/www/html/api
git config --global credential.helper store

cd $PROJ_DIR

#mkdir -p $PROJ_DIR/server
#mkdir -p $PROJ_DIR/client

if [ ! -d $PROJ_DIR/server/.git ]
then
	git clone /var/www/html/api server
fi

cd $PROJ_DIR/server
git reset --hard
git pull



cd $PROJ_DIR

if [ ! -d $PROJ_DIR/client/.git ]
then
	git clone /opt/react client
fi

cd $PROJ_DIR/client
git reset --hard
git pull
