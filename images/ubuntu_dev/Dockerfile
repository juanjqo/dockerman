FROM ubuntu:noble
SHELL ["/bin/bash", "-c"]
ENV BASH_ENV="/etc/bash_env"

# Install dependencies for development
RUN apt-get update && apt-get install -y build-essential net-tools iputils-ping \
git nss-updatedb locate curl libpci3 vim nano terminator qtcreator \
cmake extra-cmake-modules g++ fakeroot software-properties-common libxcb-cursor0 libxcb-cursor-dev \
xorg-dev libwayland-dev libxkbcommon-dev wayland-protocols \
libeigen3-dev libzmq3-dev libboost-all-dev python3-pybind11 python3-pip \
&& apt-get clean && \
rm -rf /var/lib/apt/lists/*




# To prevent compilation erros with Pybind11
RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
RUN ldconfig
