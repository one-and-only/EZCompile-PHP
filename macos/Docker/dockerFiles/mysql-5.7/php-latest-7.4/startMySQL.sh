#!/bin/bash

NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[1;31m'

function SQLSetup() {
    read -p 'Where would you like your MySQL server files to reside on your local machine (absolute path, must exist)? ' MYSQLFOLDERLOCATION
    ls "$MYSQLFOLDERLOCATION"
    ISMYSQLFOLDERPRESENT=$?
    if [ -z "$MYSQLFOLDERLOCATION" ]; then
        echo -e "${YELLOW}The path of the MySQL file folder cannot be empty. Please choose a folder.${NC}"
        SQLSetup
    elif [ "$ISMYSQLFOLDERPRESENT" = 1 ]; then
        echo -e "$MYSQLFOLDERLOCATION" "${RED}"does not exist, please choose another folder."${NC}"
        SQLSetup
    fi
}

SQLSetup

if [ ! "$(docker ps -q -f name=mysql57)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=mysql57)" ]; then
        # cleanup
	echo deleting mysql57
        docker rm mysql57
    fi
    # run your container
    docker run -d -p 3306:3306 -p 33060:33060 --volume "$MYSQLFOLDERLOCATION":/var/lib/mysql --name mysql57 frostedflakez/php-mysql-webserver:mysql-latest-5.7
fi
