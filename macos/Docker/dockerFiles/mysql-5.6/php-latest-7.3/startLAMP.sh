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
function PHPSetup() {
    read -p 'Where would you like your PHP website files to reside on your local machine (absolute path, must exist)? ' APACHEFOLDERLOCATION
    ls "$APACHEFOLDERLOCATION"
    ISAPACHEFOLDERPRESENT=$?
    if [ -z "$APACHEFOLDERLOCATION" ]; then
        echo -e "${YELLOW}The path of the PHP website files folder cannot be empty. Please choose a folder.${NC}"
        PHPSetup
    elif [ "$ISAPACHEFOLDERPRESENT" = 1 ]; then
        echo -e "$APACHEFOLDERLOCATION" "${RED}"does not exist, please choose another folder."${NC}"
        PHPSetup
    fi
}

SQLSetup
PHPSetup

if [ ! "$(docker ps -q -f name=php73)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=php73)" ]; then
        # cleanup
        docker rm php73
    fi
    # run your container
    docker run -d -p 80:80 -p 443:443 --volume "$APACHEFOLDERLOCATION":/var/www/html/ --name php73 frostedflakez/php-mysql-webserver:php-latest-7.3
fi

if [ ! "$(docker ps -q -f name=mysql56)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=mysql56)" ]; then
        # cleanup
        docker rm mysql56
    fi
    # run your container
    docker run -d -p 3306:3306 -p 33060:33060 --volume "$MYSQLFOLDERLOCATION":/var/lib/mysql --name mysql56 frostedflakez/php-mysql-webserver:mysql-latest-5.6
fi
