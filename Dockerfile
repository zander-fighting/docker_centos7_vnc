# Use centos:7.9.2009 as the base image
FROM centos:7.9.2009

# Copy the gnome_install.sh and entrypoint.sh scripts to the container
COPY gnome_install.sh /opt/init/
COPY entrypoint.sh /opt/init/
COPY vnc_install.sh /opt/init/

# Make the scripts executable
RUN chmod +x /opt/init/gnome_install.sh /opt/init/entrypoint.sh /opt/init/vnc_install.sh

# Install software
RUN /opt/init/gnome_install.sh &&\
    /opt/init/vnc_install.sh

# Expose the VNC port for connection
EXPOSE 5901

# Use the custom entrypoint script
ENTRYPOINT ["/opt/init/entrypoint.sh"]

# Use a dummy command to keep the container running
CMD ["usr/sbin/init"]