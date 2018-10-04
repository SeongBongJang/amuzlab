#!/usr/bin/env bash

# confirm docker daemon is running and connected
docker version

# build the image based on the Dockerfile
docker build -t amuz_shot_solution:0.1 .
# confirm image is present
docker images
# enter container terminal
docker run --name=amuz_shot_solution -d --privileged=true --net=host --runtime=nvidia -it -v /home/seongbong/amuz_nas/VODMV:/home/amuz amuz_shot_solution:0.1 /usr/sbin/init

# build the image based on the Dockerfile
#docker build -t amuz_base:0.2 -f Dockerfile.amuz_base2 .
# confirm image is present
#docker images
# enter container terminal
#docker run --name=amuz_base -d --privileged=true --net=host --runtime=nvidia -it -v /home/seongbong/amuz_nas/VODMV:/home/amuz amuz_base:0.2 /usr/sbin/init

docker exec -it amuz_shot_solution /bin/bash


