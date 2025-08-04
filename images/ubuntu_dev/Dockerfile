FROM ubuntu:noble
SHELL ["/bin/bash", "-c"]
ENV BASH_ENV="/etc/bash_env"
ARG TARGETARCH

# Install dependencies for development
RUN apt-get update && apt-get install -y build-essential net-tools iputils-ping \
git nss-updatedb locate curl libpci3 vim nano terminator unzip wget gpg apt-transport-https \
cmake extra-cmake-modules g++ fakeroot software-properties-common libxcb-cursor0 libxcb-cursor-dev \
xorg-dev libwayland-dev libxkbcommon-dev wayland-protocols gedit \
libeigen3-dev libzmq3-dev libboost-all-dev python3-pybind11 python3-pip thunar mc\
&& apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Install Qt creator
RUN apt-get update && apt-get install -y qtcreator \
    qtbase5-dev \
    libgl1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxi-dev \
    x11-apps \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install VSCode
# Detect architecture and set variables
RUN echo "Installing VSCode for architecture: ${TARGETARCH}" && \
    GPG_KEY="/usr/share/keyrings/packages.microsoft.gpg" && \
    mkdir -p /usr/share/keyrings/ && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ${GPG_KEY} && \
    echo "deb [arch=${TARGETARCH} signed-by=${GPG_KEY}] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code && \
    echo 'alias vscode="code --no-sandbox --user-data-dir=/tmp/vscode"' >> /etc/bash.bashrc
 

# Clone dockerman
RUN mkdir -p ~/git/ && cd ~/git/ && git clone https://github.com/juanjqo/dockerman.git --recursive

# Add custom functions 
RUN chmod +x ~/git/dockerman/scripts/custom_functions.sh
RUN bash -c '~/git/dockerman/scripts/custom_functions.sh'

# Clone docker_recipes
 RUN mkdir -p ~/git/ && cd ~/git/ && git clone https://github.com/Adorno-Lab/docker_recipes.git --recursive

# Install ROS2 Jazzy. 
RUN chmod +x ~/git/docker_recipes/dependencies/install_ros_jazzy.sh
RUN bash -c '~/git/docker_recipes/dependencies/install_ros_jazzy.sh'

# Install SAS
RUN curl -s --compressed "https://smartarmstack.github.io/smart_arm_stack_ROS2/KEY.gpg" \
| gpg --dearmor \
| tee /etc/apt/trusted.gpg.d/smartarmstack_lgpl.gpg >/dev/null \
&& curl -s --compressed -o /etc/apt/sources.list.d/smartarmstack_lgpl.list \
"https://smartarmstack.github.io/smart_arm_stack_ROS2/smartarmstack_lgpl.list" \
&& apt update && apt-get install ros-jazzy-sas-* -y

# Setting QtCreator
RUN mkdir -p /root/.config/QtProject && cp /root/git/dockerman/config/QtCreator.ini /root/.config/QtProject/
RUN mkdir -p /root/.config/QtProject/qtcreator/styles/ && cp /root/git/dockerman/config/modnokai_Juancho.xml /root/.config/QtProject/qtcreator/styles/


# Install Meslo Fonts
RUN wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv


# Install oh-my-posh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s && echo "export PATH=$PATH:/root/.local/bin" >> /etc/bash_env
RUN echo 'eval "$(oh-my-posh init bash)"' >> /etc/bash_env
RUN echo '[ -f /etc/bash_env ] && source /etc/bash_env' >> /root/.bashrc
#RUN echo "eval "$(oh-my-posh init bash)"" >> /etc/bash_env && exec bash && oh-my-posh font install meslo
#RUN source ~/.bashrc && oh-my-posh font install meslo
#RUN echo "eval "$(oh-my-posh init bash)"" >> /etc/bash_env

RUN echo "source /etc/bash_env" >> ~/.bashrc

# To prevent compilation erros with Pybind11
RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
RUN ldconfig
