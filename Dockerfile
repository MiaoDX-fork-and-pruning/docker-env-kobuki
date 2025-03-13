ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}

ENV COLCON_WS=/root/colcon_ws
ENV COLCON_WS_SRC=/root/colcon_ws/src

ENV DEBIAN_FRONTEND noninteractive

# Note that this is not needed with ROS 2 jazzy anymore
ENV PYTHONWARNINGS="ignore:setup.py install is deprecated::setuptools.command.install"

# install all dependencies
RUN apt-get update \ 
    && apt-get install -y \
        libudev-dev \
        udev \
        python3-bloom \
        python3-rosdep \
        fakeroot \
        debhelper \
        dh-python \
        ros-${ROS_DISTRO}-kobuki-ros-interfaces \
        ros-${ROS_DISTRO}-kobuki-velocity-smoother \
        ros-${ROS_DISTRO}-kobuki-core \
        ros-${ROS_DISTRO}-ros2test \
        ros-${ROS_DISTRO}-ros-testing \
        ros-${ROS_DISTRO}-angles \
        ros-${ROS_DISTRO}-diagnostic-updater \
        ros-${ROS_DISTRO}-xacro \
        ros-${ROS_DISTRO}-joint-state-publisher \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \ 
    && apt-get install -y \
        wget \
        unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${COLCON_WS}

ARG ARCH
ARG UBUNTU

RUN mkdir /tmp/debs/ \
    && cd /tmp/debs/ \
    && wget https://github.com/helloric/docker-kobuki-compile/releases/download/kobuki-ros-1.0.0-0/ros-${ROS_DISTRO}-kobuki-ros-1.0.0-0${UBUNTU}_${ARCH}.zip \
    && unzip ros-${ROS_DISTRO}-kobuki-ros-1.0.0-0${UBUNTU}_${ARCH}.zip \
    && dpkg -i *.deb \
    && rm -Rf /tmp/debs/

CMD [ "ros2", "launch", "kobuki_node", "kobuki_node-launch.py" ]
