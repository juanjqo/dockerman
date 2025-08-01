![GitHub License](https://img.shields.io/github/license/juanjqo/dockerman)[![publish](https://github.com/juanjqo/dockerman/actions/workflows/docker-image.yml/badge.svg)](https://github.com/juanjqo/dockerman/actions/workflows/docker-image.yml)

# dockerman

Some Docker images for development on DQ Robotics, ROS2, and more.

<img src="https://github.com/user-attachments/assets/5811197a-c725-49d4-927c-22feae49164c" alt="drawing" width="280"/>

## Docker Hub Instructions

|Images | Platform | pulls | Description |
|----------------- |-------|--------|--------|
|ubuntu_dev| ![Static Badge](https://img.shields.io/badge/linux-amd64-orange)![Static Badge](https://img.shields.io/badge/arm64-blue)| pulls |Ubuntu with ROS2 Jazzy, libraries and QtCreator|

```shell
docker run juanjqo/ubuntu_dev
```

## Instructions for local tests

Clone and build:

```shell
cd ~/Downloads
git clone https://github.com/juanjqo/dockerman.git --recursive
cd ~/dockerman
docker build -t ubuntu_dev images/ubuntu_dev/
```

## Run

```shell
sh run_container.sh ubuntu_dev ubuntu_dev
```

