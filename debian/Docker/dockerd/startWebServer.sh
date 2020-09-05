#!/bin/bash

PIDOFDOCKER=$(pidof dockerd)

if [ "$PIDOFDOCKER" = : ]; then
        echo Starting Docker Daemon
        sudo dockerd &
        echo Started Docker Daemon
else
        echo The Docker Daemon is Already Running, No Need to Start!
fi

echo Starting Web Server in Headless Mode
cd ../dockerFiles || exit
sudo docker-compose up
echo Started Web Server in Headless Mode
exit 0
