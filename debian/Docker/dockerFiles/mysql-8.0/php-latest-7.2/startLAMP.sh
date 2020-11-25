#!/bin/bash

NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[1;31m'

function SQLSetup() {
    read -p 'Where would you like your MySQL server files to reside on your local machine (absolute path, must exist)? ' MYSQLFOLDERLOCATION
    ls "$MYSQLFOLDERLOCATION"
    ISMYSQLFOLDERPRESENT=$?
    if [ -z "$MYSQLFOLDERLOCATION" ]; then
        echo -e """${YELLOW}""The path of the MySQL file folder cannot be empty. Please choose a folder.${NC}"
        SQLSetup
    elif [ "$ISMYSQLFOLDERPRESENT" = 2 ]; then
        echo -e "$MYSQLFOLDERLOCATION" "${RED}"does not exist, please choose another folder."${NC}"
        SQLSetup
    fi
}
function PHPSetup() {
    read -p 'Where would you like your PHP website files to reside on your local machine (absolute path, must exist)? ' APACHEFOLDERLOCATION
    ls "$APACHEFOLDERLOCATION"
    ISAPACHEFOLDERPRESENT=$?
    if [ -z "$APACHEFOLDERLOCATION" ]; then
        echo -e """${YELLOW}""The path of the PHP website files folder cannot be empty. Please choose a folder.${NC}"
        PHPSetup
    elif [ "$ISAPACHEFOLDERPRESENT" = 2 ]; then
        echo -e "$APACHEFOLDERLOCATION" "${RED}"does not exist, please choose another folder."${NC}"
        PHPSetup
    fi
}

SQLSetup
PHPSetup

if [ ! "$(sudo docker ps -q -f name=php72)" ]; then
    if [ "$(sudo docker ps -aq -f status=exited -f name=php72)" ]; then
        # cleanup
        sudo docker rm php72
    fi
    # run your container
    sudo docker run -d -p 80:80 -p 443:443 --volume "$APACHEFOLDERLOCATION":/var/www/html/ --name php72 frostedflakez/php-mysql-webserver:php-latest-7.2
fi

if [ ! "$(sudo docker ps -q -f name=mysql80)" ]; then
    if [ "$(sudo docker ps -aq -f status=exited -f name=mysql80)" ]; then
        # cleanup
        sudo docker rm mysql80
    fi
    # run your container
    sudo docker run -d -p 3306:3306 -p 33060:33060 --volume "$MYSQLFOLDERLOCATION":/var/lib/mysql --name mysql80 frostedflakez/php-mysql-webserver:mysql-latest-8.0
fi
