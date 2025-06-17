#!/bin/bash

echo "select count(*) as total from job_search.users;" > /tmp/check.sql

cnt=$(mysql -h mariadb.job -u $MARIADB_USERNAME "-p$MARIADB_PASSWORD" job_search  < /tmp/check.sql  | tail -n 1)


seeds="CompaniesSeed UsersSeed UserStatementsSeed UserSkillsSeed UserEducationsSeed UserContactsSeed UserWorkExperiencesSeed UserSkillsSeed JobStatusSeed JobsSeed JobApplicationsSeed WatchListsSeed"

echo "> $cnt users found"

if [ $cnt -eq 0 ]
then
	cd /var/www/html/api
	echo "> populate initial data"

	for seed in $seeds
	do
		echo "  - $seed"
		./bin/cake migrations seed --seed $seed
	done
else
	echo "> populate initial data"
	echo "  - existing data found, skip"

fi
