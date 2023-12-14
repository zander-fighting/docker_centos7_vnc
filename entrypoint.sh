#!/bin/bash
# This script is for docker to run VNC on CentOS 7
# Usage: ./entrypoint.sh

# print the messages of VNC connect ip:port and passwords
echo -e "The eth0 address of this container is: "$(ifconfig eth0 | grep "inet" | awk '{print $2}')"\n\
The lo address of this container is: "$(ifconfig lo | grep "inet" | awk '{print $2}')"\n\
VNC server is installed and configured on port 5901\n\
root PASSWORD default is 123456\n\
root VNC_PASSWORD default is 123456\n\
The VNC ip maybe "$(ifconfig eth0 | grep "inet" | awk '{print $2}')":5901 or "$(ifconfig lo | grep "inet" | awk '{print $2}')":5901"
exec /usr/sbin/init