# Use centos:7.9.2009 as the base image
FROM centos:7.9.2009

# Set the working directory
WORKDIR /opt/init

# Copy all the scripts to the working directory
COPY init.sh change_password.sh user_add.sh basic_packages_install.sh ssh_install.sh gnome_install.sh vnc_install.sh vnc_user_add.sh entrypoint.sh /opt/init/

# Make the scripts executable and install software
RUN chmod +x *.sh && ./init.sh

# Expose the VNC port for connection
EXPOSE 22 5901 5902

# Use the custom entrypoint script
ENTRYPOINT ["/opt/init/entrypoint.sh"]

# Use a dummy command to keep the container running
CMD ["usr/sbin/init"]