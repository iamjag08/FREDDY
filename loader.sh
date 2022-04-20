#!/bin/bash

IMDB_SOURCE="ftp://ftp.fu-berlin.de/pub/misc/movies/database"
FILE_LIST=(movies)

TARGET_DB="demodb"
TARGET_USER=demouser

echo "Username is set"
PROGRAM_NAME=$(basename ${0} | awk -F . '{print $1}')

cd "${PROGRAM_NAME}"

function run_psql() {
	sudo -u demouser psql -d demodb  -c "${1}"
}

run_psql 'DROP DATABASE IF EXISTS imdb;'
run_psql 'CREATE DATABASE imdb;'

export PGDATABASE="${TARGET_DB}"

cd imdb-to-sql 

## cp -rv ~/tmp/db_dump .

sed -i -E 's|type[[:blank:]]{1,}\=[[:blank:]]{1,}DatabaseTypes.*|type \= DatabaseTypes\.POSTGRES|' $(pwd)/settings.py
sed -i -E 's|database[[:blank:]]{1,}\=.*|database \= "'${TARGET_DB}'"|' $(pwd)/settings.py
sed -i -E 's|clear_old_db[[:blank:]]{1,}\=.*|clear_old_db \= True|' $(pwd)/settings.py
sed -i -E 's|user[[:blank:]]{1,}\=.*|user \= "'${TARGET_USER}'"|' $(pwd)/settings.py

cd db_dump
pwd
for item in ${FILE_LIST[@]}; do
	file_name="${item}.list.gz"
	echo processing ${file_name}...

	#gunzip "${file_name}"
done

cd ..
python2 tosql.py
