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

# Taken from https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script (Brad user)
unameOut=$(uname -a)
case "${unameOut}" in
    *Microsoft*)     OS="WSL";; #must be first since Windows subsystem for linux will have Linux in the name too
    *microsoft*)     OS="WSL2";; #WARNING: My v2 uses ubuntu 20.4 at the moment slightly different name may not always work
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*)    OS="Cygwin";;
    MINGW*)     OS="Windows";;
    *Msys)      OS="Windows";;
    *)          OS="UNKNOWN:${unameOut}"
esac

echo "Platform: " ${OS}

if [[ "${OS}" == "Linux" ]]; then

    xhost +local:root
    docker run -it --name=$1 \
    --rm --privileged --network=host --ipc=host --env=DISPLAY \
    $2 /bin/bash

elif  [[ "${OS}" == "Mac" ]]; then
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
else
    echo "Unsupported platform: ${OS}"
    exit 1
fi

