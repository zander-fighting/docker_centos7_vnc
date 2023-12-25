#!/bin/bash
# This script is for docker to run VNC on CentOS 7
# Usage: ./entrypoint.sh

# Define some functions
check_error() {
  # Check the last command result, if not 0, output the error message and exit the script
  if [ $? -ne 0 ]; then
    printf "[ERROR] %s\n" "$1"
    exit 1
  fi
}

print_error() {
  # Print the information message with a prefix
  printf "[ERROR] %s\n" "$1"
}

print_info() {
  # Print the information message with a prefix
  printf "[INFO] %s\n" "$1"
}

# print the messages of VNC connect ip:port and passwords
print_successful(){
  # Print successful message
  print_info "VNC user and password added successfully"
  print_info "username: admin1"
  print_info "VNC password: admin1"
  print_info "The eth0 address of this container is: $(ifconfig eth0 | grep "inet" | awk '{print $2}')"
  print_info "The lo address of this container is: $(ifconfig lo | grep "inet" | awk '{print $2}')"
  print_info "VNC server is installed and configured on port 5901"
  print_info "The VNC ip maybe "$(ifconfig eth0 | grep "inet" | awk '{print $2}')":5901 or "$(ifconfig lo | grep "inet" | awk '{print $2}')":5901"
}

# Call the functions
print_successful

# contain docker container
exec /usr/sbin/init