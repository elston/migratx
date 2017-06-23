#!/bin/bash
# ...
source /$PROJECT/.env/$PROJECT/bin/activate    
cd  /$PROJECT
./manage.py syncdb
./manage.py migrate