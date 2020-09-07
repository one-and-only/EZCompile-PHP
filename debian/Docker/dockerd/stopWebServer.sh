#!/bin/bash

PIDOFMYSQL=$(sudo docker inspect -f '{{.State.Pid}}' mysql8)
PIDOFPHP74=$(sudo docker inspect -f '{{.State.Pid}}' php74)

if [ "$PIDOFMYSQL" = 0 ] || [ "$PIDOFPHP74" = 0 ]; then
    echo The Web Server Has Not Been Started Yet, No Need To Shut It Down.
    exit 0
else
    echo Shutting Down Web Server
    cd ../dockerFiles/ || exit
    sudo docker-compose stop
    echo Web Server Shut Down
    exit 0
fi
