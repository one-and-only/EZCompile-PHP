#!/bin/bash

NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[1;31m'

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

PHPSetup

if [ ! "$(docker ps -q -f name=php74)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=php74)" ]; then
        # cleanup
        docker rm php74
    fi
    # run your container
    docker run -d -p 80:80 -p 443:443 --volume "$APACHEFOLDERLOCATION":/var/www/html/ --name php74 frostedflakez/php-mysql-webserver:php-latest-7.4
fi
