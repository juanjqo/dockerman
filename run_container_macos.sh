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

# Open XQuartz if not running
open -a XQuartz

# Allow connections to XQuartz
xhost + 127.0.0.1

# Run container with proper display forwarding
docker run -it --name=$1 --rm \
  -e DISPLAY=host.docker.internal:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/.Xauthority:/root/.Xauthority \
  --ipc=host \
  $2 \
  /bin/bash
