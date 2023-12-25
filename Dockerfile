# Use centos:7.9.2009 as the base image
FROM centos:7.9.2009

# Copy the gnome_install.sh and entrypoint.sh scripts to the container
COPY init.sh /opt/init/
COPY change_password.sh /opt/init/
COPY user_add.sh /opt/init/
COPY basic_packages_install.sh /opt/init/
COPY ssh_install.sh /opt/init/
COPY gnome_install.sh /opt/init/
COPY vnc_install.sh /opt/init/
COPY vnc_user_add.sh /opt/init/
COPY entrypoint.sh /opt/init/


# Make the scripts executable
RUN chmod +x /opt/init/change_password.sh /opt/init/user_add.sh /opt/init/basic_packages_install.sh /opt/init/ssh_install.sh /opt/init/gnome_install.sh /opt/init/vnc_install.sh /opt/init/vnc_user_add.sh /opt/init/entrypoint.sh

# Install software
RUN /opt/init/init.sh

# Expose the VNC port for connection
EXPOSE 22
EXPOSE 5901
EXPOSE 5902

# Use the custom entrypoint script
ENTRYPOINT ["/opt/init/entrypoint.sh"]

# Use a dummy command to keep the container running
CMD ["/bin/bash","-c","exec usr/sbin/init",]