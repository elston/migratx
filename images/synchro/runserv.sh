#!/bin/bash
# ...
source /$PROJECT/.env/$PROJECT/bin/activate     
cd /$PROJECT
# ...
# TWISTD_OPTS="--pidfile=/var/run/syncinvoice.pid \
#              -o \
#              --rundir=/$PROJECT \
#              --python=/$PROJECT/app.py \
#              --uid=root \
#              --gid=root \
#              --reactor=epoll \
#              -l /dev/null"
# # ...
# twistd $TWISTD_OPTS
twistd -ny /$PROJECT/app.py