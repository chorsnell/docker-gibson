#!/bin/bash

#docker run --rm -it --name melondevx -v mysql:/var/lib/mysql -v www:/var/www/html -p 8066:80 -p 3306:3306 poppahorse/melondevx
#docker run -d --name melondevx -v mysql:/var/lib/mysql -v www:/var/www/html -p 8066:80 -p 3306:3306 poppahorse/melondevx

PID=$(docker run -d --name melondevx -v mysql:/var/lib/mysql -v www:/var/www/html -p 8066:80 -p 3306:3306 poppahorse/melondevx)
echo "Starting Melon Dev Container"
[ -z "$PID" ] && echo "Container failed to start!" && exit 1 || (docker wait $PID && docker rm $PID)&