#!/bin/bash
echo "Container name:" $1
echo "Image:" $2
# Argument validation check
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    echo "Example: sh run_container.sh desired_container_name  docker_image"
    exit 1
fi

if [ $# != 2 ]; then
    echo "Error: You need to provide two arguments."
    echo "Example: sh run_container.sh desired_container_name  docker_image"
    exit 1
fi

xhost +local:root
docker run -it --name=$1 \
--rm --privileged --network=host --ipc=host --env=DISPLAY \
$2 /bin/bash
