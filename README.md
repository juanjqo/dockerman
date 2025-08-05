![GitHub License](https://img.shields.io/github/license/juanjqo/dockerman)[![publish](https://github.com/juanjqo/dockerman/actions/workflows/docker-image.yml/badge.svg)](https://github.com/juanjqo/dockerman/actions/workflows/docker-image.yml)

# dockerman

Some Docker images for development on DQ Robotics, ROS2, and more.

<img src="https://github.com/user-attachments/assets/5811197a-c725-49d4-927c-22feae49164c" alt="drawing" width="280"/>

## Docker Hub Instructions

|Images | Platform | Host SO | pulls | Description |
|----------------- |-------|--------|--------|--------|
|ubuntu_dev| ![Static Badge](https://img.shields.io/badge/linux-amd64-orange)![Static Badge](https://img.shields.io/badge/arm64-blue)| ![Static Badge](https://img.shields.io/badge/macOS-magenta)![Static Badge](https://img.shields.io/badge/ubuntu-blue) | ![Docker Pulls](https://img.shields.io/docker/pulls/juanjqo/ubuntu_dev)|Ubuntu with ROS2 Jazzy, libraries and QtCreator|

## Clone this rep
```shell
mkdir -p ~/git && cd ~/git
git clone https://github.com/juanjqo/dockerman --recursive
cd dockerman
```

### macOS with Apple Silicon:
```shell
docker pull juanjqo/ubuntu_dev:arm64
sh run_container.sh ubuntu_dev juanjqo/ubuntu_dev:arm64
```

### AMD64 systems:
```shell
docker pull juanjqo/ubuntu_dev:amd64
chmod +x run_container.sh 
./run_container.sh ubuntu_dev juanjqo/ubuntu_dev:amd64
```
---------------------------------------

### Instructions for local tests

Clone and build:

```shell
cd ~/git/dockerman
docker build -t ubuntu_dev images/ubuntu_dev/
```

### Run
#### Ubuntu
```shell
chmod +x run_container.sh
```
```shell
./run_container.sh ubuntu_dev ubuntu_dev
```
#### macOS
```shell
sh run_container.sh ubuntu_dev ubuntu_dev
```

