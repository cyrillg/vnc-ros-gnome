FROM ubuntu:16.04
MAINTAINER Cyrill Guillemot "https://github.com/cyrillg"

ENV DEBIAN_FRONTEND noninteractive

# Install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > \
                /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 \
                --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 && \
    apt-get update && apt-get install -y ros-kinetic-desktop && \
    rosdep init

# Install other utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel \
      gnome-settings-daemon \
      metacity \
      nautilus \
      gnome-terminal \
      x11vnc \
      xvfb \
      vim \
      tmux \
      git \
      locales \
      sudo \
      apt-utils \
      supervisor

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Environment variables
ENV DISPLAY=:1 USER=serial TERM=xterm-color
ENV HOME /home/$USER

# Configure user
RUN groupadd $USER && \
    useradd --create-home --no-log-init -g $USER $USER && \
    usermod -aG sudo $USER && \
    echo "$USER:$USER" | chpasswd && \
    chsh -s /bin/bash $USER

# Add files
WORKDIR $HOME
RUN mkdir ros_ws && \
    mkdir .gazebo && \
    mkdir -p ./.config/nautilus && \
    mkdir -p /var/log/supervisor && \
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > .git-prompt.bash && \
    touch .bash_history
COPY ["files/.bashrc", \
      "files/.tmux.conf", \
      "files/.vimrc", \
      "files/autumn.jpg", \
      "files/init_ros", "./"]
COPY files/.gazebo .gazebo
COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set user and group ownership
RUN chown -R serial:serial . && \
    chmod +x init_ros

# WHEN THE SETUP IS STABLE, THIS WILL NEED TO BE OUTSIDE OF THE IMAGE,
# SINCE IT BELONGS TO THE APPLICATION
RUN apt-get install -y ros-kinetic-gazebo-ros-pkgs
#        ros-kinetic-ros-control \
#        ros-kinetic-ros-controllers \
#        ros-kinetic-teleop-twist-keyboard \

# Install ROS dependencies

EXPOSE 22 5900

CMD    ["/usr/bin/supervisord"]

