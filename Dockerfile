# From ubuntu:bionic
# SHELL ["/bin/bash", "-c"]
# RUN apt update && \
#     apt install -y lsb-release && \
#     sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
#     apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
#     apt update && \
#     apt install -y ros-melodic-desktop-full && \
#     source /opt/ros/melodic/setup.bash && \
#     apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential && \
#     rosdep init && \
#     rosdep update
From osrf/ros:melodic-desktop-full
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get install -y python3-pip
RUN source /opt/ros/melodic/setup.bash && \
    export ROS_PYTHON_VERSION=3 && \
    mkdir -p ~/raceon_sim_ws/src && \
    cd ~/raceon_sim_ws && \
    pip3 install catkin-pkg && \
    catkin_make
RUN source /opt/ros/melodic/setup.bash && \
    source ~/raceon_sim_ws/devel/setup.bash && \
    export ROS_PYTHON_VERSION=3 && \
    apt-get update && \
    apt-get install -y \
    ros-melodic-ros-control \
    ros-melodic-gazebo-ros-control \
    ros-melodic-ros-controllers \
    python3-opencv \
    ros-melodic-ackermann-msgs \
    python3-empy && \
    pip3 install pynput
RUN source /opt/ros/melodic/setup.bash && \
    source ~/raceon_sim_ws/devel/setup.bash && \
    export ROS_PYTHON_VERSION=3 && \
    cd ~/raceon_sim_ws/src && \
    git clone https://github.com/wjwwood/serial.git && \
    git clone https://github.com/ros-drivers/ackermann_msgs.git && \
    git clone https://github.com/mit-racecar/racecar.git && \
    git clone https://github.com/mit-racecar/vesc.git && \
    git clone https://github.com/d4n1elchen/raceon.git && \
    git clone https://github.com/d4n1elchen/raceon_simulation.git && \
    git clone https://github.com/d4n1elchen/raceon_visualizer.git && \
    git clone https://github.com/d4n1elchen/racecar_gazebo.git
RUN source /opt/ros/melodic/setup.bash && \
    source ~/raceon_sim_ws/devel/setup.bash && \
    export ROS_PYTHON_VERSION=3 && \
    cd ~/raceon_sim_ws && \
    pip3 install rospkg && \
    catkin_make
# WORKDIR /root/raceon_sim_ws
# CMD ["/bin/bash"]
