# VNC, ROS and Gnome

This repository defines a docker image based on Ubuntu 16.04, packed with ROS Kinetic and a Gnome GUI through VNC.
It was put together to give readers of [Serial Robotics](https://serial-robotics.org) a ready-to-use environment for the [ros-playground](https://github.com/cyrillg/ros-playground) ROS workspace.
However it is fairly generic and can easily be used as a plug-and-play for any ROS project.

You can run it with:

```bash
docker run -p 5900:5900 \
            --volume=ROS-WS-ABS-PATH:/home/serial/ros_ws:rw \
            --name sr-docker \
            cyrillg/vnc-ros-gnome
```

Once your container is running, you can connect to the desktop with RealVNC, VNC client available as a Chrome extension (other VNC clients might do, but this one has been proven to work). The address is `localhost:5900`.

You can also have access inside the container through:

```bash
docker exec -it -u serial sr-docker "/bin/bash"
```

Coming soon:
* Installation guide
* Usage guide
