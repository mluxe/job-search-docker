#!/bin/bash


cd /var/www/html/api

echo "> create database"

echo "CREATE DATABASE IF NOT EXISTS job_search " > /tmp/check.sql
mysql -h mariadb.job -u $MARIADB_USERNAME "-p$MARIADB_PASSWORD" < /tmp/check.sql

echo "> execute database migration"
./bin/cake migrations migrate
