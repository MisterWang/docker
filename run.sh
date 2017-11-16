#!/bin/bash

#phpfpm
docker run -p 9000:9000 --name phpfpm -v /www:/usr/share/nginx/html:rw -d php:7.2-rc-fpm-alpine3.6

#nginx link phpfpm
docker run --name nginx -d -p 80:80 \
-v /etc/nginx/conf.d:/etc/nginx/conf.d:ro \
--link phpfpm:phpfpm \
--volumes-from phpfpm \
nginx:alpine

function stop(){
    docker stop nginx && sudo docker rm nginx
    docker stop phpfpm && sudo docker rm phpfpm    
}

function restart()[
    docker restart nginx 
    docker restart phpfpm   
]