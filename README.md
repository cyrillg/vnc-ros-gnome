# VNC, ROS and Gnome

Docker image based on Ubuntu 16.04, packed with ROS Kinetic and a Gnome GUI through VNC. It is meant as a plug-and-play for any ROS workspace, allowing the ease of use of Docker _and_ a GUI, often required for comfortable ROS development.

## Default image

If your ROS repo is in `/home/my_host_user/my_repo`, you can run the default image with only:

```bash
docker run -p 5900:5900 \
           --volume=/home/my_host_user/my_repo:/home/serial/ros_ws:rw \
           --name ros-container \
           cyrillg/vnc-ros-gnome
```

It will automatically pull `cyrillg/vnc-ros-gnome` image from docker-hub. 

Once your container is running, you can connect to the desktop with RealVNC, VNC client available as a Chrome extension (other VNC clients might do, but this one has been proven to work). The address is `localhost:5900`.

Note that, at the time I write this, the shell is not functional through the GUI. You can however access it through:

```bash
docker exec -it -u serial ros-container "/bin/bash"
```

## Custom build

Alternatively, the image can be rebuilt with a username different from the default _serial_. To that effect:

```bash
# Clone this repo
git clone https://github.com/cyrillg/vnc-ros-gnome.git

cd vnc-ros-gnome/

# Replacing <image-name> and <my-docker-user> by your own choices
docker build . -t <image-name> --build-arg user=<my-docker-user>
```

The same way as for the default image, if your ROS repo is in `/home/my_host_user/my_repo`, you can run this newly built image with:

```bash
docker run -p 5900:5900 \
           --volume=/home/my_docker_user/my_repo:/home/<my-docker-user>/ros_ws:rw \
           --name ros-container \
           <image-name>
```

You can also start an interactive shell within the container under your <my-docker-user> user account with:
```bash
docker exec -it -u <my-docker-user> ros-container "/bin/bash"
```

## sr-dev

The vnc-ros-gnome image was created while developing the [sr-dev image](https://github.com/cyrillg/sr-dev), meant to give readers of [Serial Robotics](https://serial-robotics.org) a ready-to-use environment for the [ros-playground](https://github.com/cyrillg/ros-playground) ROS workspace. 

You might be interested in taking a look at how it builds on top of the _vnc-ros-gnome_ image, and easily creates an environment tailored to a particular ROS project.

Another advantage of the sr-dev for those not familiar with docker is that it can be managed with the sr-cli command-line interface. See the [Github page](https://github.com/cyrillg/sr-cli) for more info as well as a demo.
