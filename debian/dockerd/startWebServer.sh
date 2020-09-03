#!/bin/bash

if [ "$PIDOF" = : ]; then
        sudo dockerd &
        exit 0
else
        echo The Docker Daemon is Already Running, no Need to Start!
        exit 0
fi

cd ../dockerFiles || exit
docker-compose up
