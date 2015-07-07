#!/bin/bash
set -e

cd /app

#Check if we have been given $SETTINGS_FILE
if [[ $SETTINGS_FILE ]]; then
    #yes, but does the file exist?
    if [ -f $SETTINGS_FILE ]; then
        meteor --settings $SETTINGS_FILE --port $PORT
    else
        meteor --port $PORT
    fi
else
    meteor --port $PORT
fi
