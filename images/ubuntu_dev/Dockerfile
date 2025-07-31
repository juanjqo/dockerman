FROM ubuntu:noble
SHELL ["/bin/bash", "-c"]
ENV BASH_ENV="/etc/bash_env"

# Install dependencies for development
RUN apt-get update && apt-get install -y build-essential net-tools iputils-ping \
git nss-updatedb locate curl libpci3 vim nano terminator qtcreator unzip wget \
cmake extra-cmake-modules g++ fakeroot software-properties-common libxcb-cursor0 libxcb-cursor-dev \
xorg-dev libwayland-dev libxkbcommon-dev wayland-protocols \
libeigen3-dev libzmq3-dev libboost-all-dev python3-pybind11 python3-pip \
&& apt-get clean && \
rm -rf /var/lib/apt/lists/*


# Clone dockerman
RUN mkdir -p ~/git/ && cd ~/git/ && git clone https://github.com/juanjqo/dockerman.git --recursive

# Setting QtCreator
RUN mkdir /root/.config/QtProject && cp /root/git/dockerman/config/QtCreator.ini /root/.config/QtProject/

# [Terminal]
# ShellPath=/usr/bin/bash

# cd /root/.config/QtProject
# sed -i -e 's/option(BUILD_SHARED_LIBS "If ON, build shared library instead of static" OFF)/option(BUILD_SHARED_LIBS "If ON, build shared library instead of static" ON)/g' CMakeLists.txt
# sed -i -e 's/option(BUILD_SHARED_LIBS "If ON, build shared library instead of static" OFF)/option(BUILD_SHARED_LIBS "If ON, build shared library instead of static" ON)/g' QtCreator.ini




# Install Meslo Fonts
RUN wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv


# Install oh-my-posh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s && echo "export PATH=$PATH:/root/.local/bin" >> /etc/bash_env
RUN echo "eval "$(oh-my-posh init bash)"" >> /etc/bash_env && exec bash && oh-my-posh font install meslo
#RUN source ~/.bashrc && oh-my-posh font install meslo
#RUN echo "eval "$(oh-my-posh init bash)"" >> /etc/bash_env

RUN echo "source /etc/bash_env" >> ~/.bashrc

# To prevent compilation erros with Pybind11
RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
RUN ldconfig
