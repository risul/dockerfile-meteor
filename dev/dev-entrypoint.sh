#!/bin/bash
set -e

cd /app

#Check if we have been given $SETTINGS_FILE
if [[ $SETTINGS_FILE ]]; then
    if [ -f $SETTINGS_FILE ]; then
        echo "=> $SETTINGS_FILE found.. starting meteor with settings!"
        meteor --settings $SETTINGS_FILE --port $PORT
    else
        echo "=> Settings file not found!"
        exit 1
    fi
else
    echo "=> No settings file provided.. starting meteor without settings!"
    meteor --port $PORT
fi
