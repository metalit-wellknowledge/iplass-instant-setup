#!/bin/sh
SCRIPT_DIR=$(pwd)
source $SCRIPT_DIR/shell-property

DOCKER_ID=$(sudo docker ps |grep $DOCKER_IMAGE_NAME |awk '{print $1}')

sudo docker cp iplass-conf/iplass-service-config.xml $DOCKER_ID:/home/tomcat/.iplass/
sudo docker cp iplass-conf/logback.xml $DOCKER_ID:/home/tomcat/.iplass/

sudo docker restart $DOCKER_IMAGE_NAME