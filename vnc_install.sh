#!/bin/bash
# This script is for installing VNC on CentOS 7
# Usage: ./vnc_install.sh [VNC_USER] [USER_PASSWORD] [VNC_PASSWORD] [VNC_PORT]
# default setting [USER_PASSWORD=123456] [VNC_PASSWORD=123456] [VNC_PORT=5901] [VNC_USER=root]

# Set the VNC password and port as variables
# Use the parameters passed to the script, or use default values
VNC_USER=${1:-"root"}
USER_PASSWORD=${2:-"123456"}
VNC_PASSWORD=${3:-"123456"}
VNC_PORT=${4:-5901}

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
  useradd "$VNC_USER"
  echo "$USER_PASSWORD" | passwd "$VNC_USER" --stdin
}

# Define a function to install packages
install_packages() {
  # Use an array to store package names
  local packages=(epel-release vim net-tools tigervnc-server tigervnc-server-module)
  # Loop through the array and install each package
  for package in "${packages[@]}"; do
    echo "Installing $package..."
    yum -y install "$package"
  done
}

# Define a function to create a VNC user and set its password
create_vnc_user() {
  echo "Creating VNC user $VNC_USER..."
  useradd "$VNC_USER"
  su - "$VNC_USER" -c "vncpasswd <<EOF
$VNC_PASSWORD
$VNC_PASSWORD
n
EOF"
}

# Define a function to copy the VNC template file and modify it
configure_vnc_service() {
  echo "Configuring VNC service..."
  # Use a variable to store the VNC service name
  local vnc_service=vncserver@:$[$VNC_PORT-5900]
  # Copy the VNC template file and modify it
  cp /lib/systemd/system/vncserver@.service /etc/systemd/system/"$vnc_service".service
  sed -i "s/<USER>/$VNC_USER/g" /etc/systemd/system/"$vnc_service".service
  # Modify the VNC resolution to 1920x1080
  su - "$VNC_USER" -c "echo 'geometry=1920x1080' >> ~/.vnc/config"
  # Reload the systemd daemon and start the VNC service
  systemctl daemon-reload
  systemctl start "$vnc_service"
  systemctl enable "$vnc_service"
}

# Define a function to configure firewall
configure_firewall() {
  # Use a variable to store the firewall service name
  local firewall_service=firewalld
  # Check if the firewall service is active
  if systemctl is-active --quiet "$firewall_service"; then
    systemctl stop "$firewall_service"
  else
    echo "Stoping firewall service..."
  fi

  # Reload the firewall
  echo "disable the firewall..."
  systemctl disable firewalld
}

# Define a function to print a success message
print_success() {
  # Use printf command to format the output
  printf "VNC server is installed and configured on port %d with password %s for user %s\n" "$VNC_PORT" "$VNC_PASSWORD" "$VNC_USER"
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
install_packages
create_vnc_user
configure_vnc_service
configure_firewall
print_success