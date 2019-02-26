#!/bin/bash

DBHOST="localhost"
USAGE=$'Usage: ./aircra.sh -d database -u username -p -h localhost

Options:
-d (required): mysql database name that must be created before running command.
-u (required): mysql user that must have all privileges for database.
-p (optional): Add this option if password is required for the mysql user. This option does not accept arguments. By default, aircra.sh does not expect a password for your mysql user.
-h (optional): database host name. Default value is \'localhost\'.'

while getopts ":d:u:ph:" option
do
  case "${option}" in
    u) 
      DBUSER=${OPTARG}
      ;;
    d)
      DATABASE=${OPTARG}
      ;;
    p)
      PASS="TRUE"
      ;;
    h) 
      DBHOST=${OPTARG}
      ;;
    \?)
      echo "$USAGE" >&2
      exit 1
      ;;
    :) 
      echo "$USAGE" >&2
      exit 1
      ;;
  esac
done

MYSQL=$(which mysql)

if [ -z "$MYSQL" ]
then
  echo 'MySQL was not found. Please make sure that you have MySQL installed on your machine.'
  exit 1
else
  if [[ -z "$DBUSER" || -z "$DATABASE" ]]
  then
    echo "$USAGE"
    exit 1
  else
    echo 'Copying csv data to tmp folder to prepare for MySQL import.'
    cp ./ntsb_mdb_export/*.csv /tmp/
    cat ./scripts/01_ntsbavall-create.sql ./scripts/02_ntsbavall-merge.sql ./scripts/03_ntsbavall-GAaccidents_export.sql > /tmp/ntsbavall-scripts.sql

    if [[ -n "$PASS" ]]
    then
      $MYSQL --host=$DBHOST -u$DBUSER -p $DATABASE --skip-column-names < /tmp/ntsbavall-scripts.sql
    elif [[ -z "$PASS" ]]
    then
      $MYSQL --host=$DBHOST -u$DBUSER $DATABASE --skip-column-names < /tmp/ntsbavall-scripts.sql
    fi

    rm /tmp/ntsbavall-scripts.sql

    echo 'Prepend exported dataset with header row containing column names.'
    cat ./head.csv /tmp/aircraft-GAaccidents.csv > /tmp/aircraft-GAaccidents-final.csv && mv /tmp/aircraft-GAaccidents-final.csv . && rm /tmp/aircraft-GAaccidents.csv && echo 'Final dataset has been placed in the working directory.'
  fi
fi
