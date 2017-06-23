#!/bin/bash

# ...env
mkdir -p /$PROJECT/.env
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv $PROJECT
pip install -r /tmp/requirements.txt

# ...log
mkdir -p /$PROJECT/.logs
echo '' > /$PROJECT/.logs/synchro.log


# ...containers
mkdir -p /$PROJECT/.containers