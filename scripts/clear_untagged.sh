#!/bin/bash
# ...
images=$(docker images | grep "<none>" | awk "{print \$3}")

# ...
if [[ $images ]]; then
    echo $images    
    docker rmi -f $images    
else
    echo "nothing remove"
fi

