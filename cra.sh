#!/bin/bash

DBHOST='localhost'

while getopts ":u:d:h:" option
do
  case "${option}" in
    u) 
      DBUSER=${OPTARG}
      ;;
    d) 
      DATABASE=${OPTARG}
      ;;
    h) 
      DBHOST=${OPTARG}
      ;;
    \?)
      echo "Invalid option -$OPTARG specified." >&2
      exit 1
      ;;
    :) 
      echo "Option -$OPTARG requires an argument." >&2
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
    echo 'The database name and user must be passed as arguments. Specify the user name with `-u` and the database name with `-d`.'
    exit 1
  else
    echo 'Copying csv data to tmp folder to prepare for MySQL import.'
    cp ./ntsb_mdb_export/* /tmp/
    cat ./scripts/*.sql | $MYSQL --host=$DBHOST -u$DBUSER -p $DATABASE --skip-column-names
    echo 'Moving exported dataset to working directory.'
    mv /tmp/aircraft-GAaccidents-final.csv .
  fi
fi