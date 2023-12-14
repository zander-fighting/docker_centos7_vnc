#!/bin/bash
# This script is for installing gnome desktop on CentOS 7
# Usage: ./gnome_install.sh [UUSER] [USER_PASSWORD]
# default setting [USER_=123456] [USER_PASSWORD=123456]

# Use the parameters passed to the script, or use default values
USER=${1:-"root"}
USER_PASSWORD=${2:-"123456"}

# Check if the user is root or has sudo privileges
if [ $(id -u) -ne 0 ]; then
  echo "You need to be root or have sudo privileges to run this script"
  exit 1
fi

# Define a function to install GNOME Desktop and Graphical Administration Tools
install_gnome() {
  echo "Installing GNOME Desktop..."
  yum -y groupinstall GNOME Desktop
  # Set the default target to graphical.target
  systemctl set-default graphical.target
  useradd "$USER"
  echo "$USER_PASSWORD" | passwd "$VNC_USER" --stdin
}

# Define a function to print a success message
print_success() {
  # Use printf command to format the output
  printf "GNOME Deskpot is installed and create a user %s with password %s\n" "$USER" "$USER_PASSWORD"
}

# Define a function to clean up on exit
cleanup() {
  echo "Cleaning up..."
  # Add any commands to clean up here
  yum clean all
}

# Trap the exit signal and call the cleanup function
trap cleanup EXIT

# Call the functions
install_gnome
print_success