#!/bin/bash

function PHPSetup() {
    read -p 'Where would you like your PHP website files to reside on your local machine (absolute path, must exist)? ' APACHEFOLDERLOCATION
    ls "$APACHEFOLDERLOCATION"
    ISAPACHEFOLDERPRESENT=$?
    if [ -z "$APACHEFOLDERLOCATION" ]; then
        echo The path of the PHP website files folder cannot be empty. Please choose a folder.
        PHPSetup
    if [ "$ISAPACHEFOLDERPRESENT" = 1 ]; then
        echo "$APACHEFOLDERLOCATION" does not exist, please choose another folder.
        PHPSetup
    fi
}

PHPSetup

if [ ! "$(docker ps -q -f name=php80)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=php80)" ]; then
        # cleanup
        docker rm php80
    fi
    # run your container
    docker run -d -p 80:80 -p 443:443 --volume "$APACHEFOLDERLOCATION":/var/www/html/ --name php80 frostedflakez/php-mysql-webserver:0.9-beta.3-php-latest-8.0
fi
