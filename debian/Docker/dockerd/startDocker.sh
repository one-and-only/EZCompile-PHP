#!/bin/bash

PIDOFDOCKERD=$(pidof dockerd)

if [ -z "$PIDOFDOCKERD" ]; then
    echo starting docker
    sudo dockerd &
    echo 'started docker. Press ^C to break from the window'
elif [ "$PIDOFDOCKERD" != '' ]; then
    echo Docker is running, no need to start!
fi
