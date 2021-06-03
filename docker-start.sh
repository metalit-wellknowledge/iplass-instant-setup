#!/bin/sh
SCRIPT_DIR=$(pwd)

yum -y install dos2unix unix2dos
dos2unix $SCRIPT_DIR/shell-property
dos2unix $SCRIPT_DIR/iplass-build/container-start.sh
dos2unix $SCRIPT_DIR/iplass-build/rc.local

source $SCRIPT_DIR/shell-property

sudo docker build -t $DOCKER_IMAGE_NAME $SCRIPT_DIR/iplass-build/
wait
sudo docker run --privileged -it -d -p 80:80 --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME /sbin/init
wait
sudo docker exec -it $DOCKER_CONTAINER_NAME bash