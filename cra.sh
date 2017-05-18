#!/bin/bash

DBHOST='localhost'
PASS=TRUE

while getopts ":u:d:h:p:" option
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
    p)
      PASS=${OPTARG}
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
    if [[ "$PASS" = "FALSE" || "$PASS" = "F" ]]
    then
      echo 'Copying csv data to tmp folder to prepare for MySQL import.'
      cp ./ntsb_mdb_export/*.csv /tmp/
      cat ./scripts/*.sql | $MYSQL --host=$DBHOST -u$DBUSER $DATABASE --skip-column-names
    elif [[ "$PASS" = "TRUE" || "$PASS" = "T" ]]
    then
      echo 'Copying csv data to tmp folder to prepare for MySQL import.'
      cp ./ntsb_mdb_export/*.csv /tmp/
      cat ./scripts/*.sql | $MYSQL --host=$DBHOST -u$DBUSER -p $DATABASE --skip-column-names
    else
      echo "Option -p only accepts TRUE (T) or FALSE (F) as arguments."
      exit 1
    fi

    echo 'Replace NULL values with empty fields for clean imports to R and Stata.'
    sed -i'.bak' 's/,NULL/,/g' /tmp/aircraft-GAaccidents-final.csv
    echo 'Moving exported dataset to working directory.'
    mv /tmp/aircraft-GAaccidents-final.csv .
  fi
fi