#!/bin/bash
SCRIPTDIR=$(pwd)
rm Docker.dmg
wget https://download.docker.com/mac/stable/Docker.dmg || exit
function install() {
    cd /Volumes/Docker/
    MOUNTEXIST=$?
    if [ "$MOUNTEXIST" = 1 ]; then
        cd "$SCRIPTDIR"
        hdiutil attach Docker.dmg
        cd /Volumes/Docker/ || exit
        ls Applications/Docker.app
        DOCKERINSTALLED=$?
        if [ "$DOCKERINSTALLED" = 1 ]; then
            echo installing Docker Desktop
            cp -r Docker.app/ /Applications || exit
            echo Docker Desktop installed successfully
            cd ~/
            diskutil unmount /Volumes/Docker
            exit 0
        elif [ "$DOCKERINSTALLED" = 0 ]; then
            read -p 'Docker Desktop is already installed. Would you like to remove it?[Yes/default: No] ' UNINSTALLCHOICE
            UNINSTALLCHOICE=${UNINSTALLCHOICE:-No}
            if [ "$UNINSTALLCHOICE" = Yes ]; then
                echo uninstalling Docker Desktop
                sudo rm -r Applications/Docker.app
                echo uninstalled Docker Desktop
                echo installing docker Desktop
                cp -r Docker.app Applications/ || exit
                echo installed docker desktop
                cd ~/
                echo unmounting install volume
                diskutil unmount /Volumes/Docker
                echo unmounted install volume
                exit 0
            elif [ "$UNINSTALLCHOICE" = No ]; then
                echo cancelling installation
                exit 130
            else
                invalid argument, exiting...
                exit 1
            fi
        fi
    elif [ "$MOUNTEXIST" = 0 ]; then
        cd ~/ || exit
        read -p "A version of this image is already mounted. Would you like to automatically unmount this volume?[Yes/default: No] " UNMOUNTCHOICE
        UNMOUNTCHOICE=${UNMOUNTCHOICE:-No}
        if [ "$UNMOUNTCHOICE" = Yes ]; then
            diskutil unmount /Volumes/Docker
            install
        elif [ "$UNMOUNTCHOICE" = No ]; then
            echo cancelling installation
            exit 130
        else
            echo invalid argument, exiting...
            exit 1
        fi
    fi
}

install
