#!/bin/bash

PIDOFDOCKER=$(pidof dockerd)

if [ "$PIDOFDOCKER" = : ]; then
        echo Starting Docker Daemon
        sudo dockerd &
        echo Started Docker Daemon
else
        echo The Docker Daemon is Already Running, No Need to Start!
fi

echo Starting Web Server
cd ../dockerFiles || exit
sudo docker-compose up -d
echo Started Web Server