# What is the purpose of this Docker image?
This Docker image is designed to quickly build a Gnome desktop and VNC service based on Centos7, making it convenient for everyone to quickly learn and master Centos7.
# How to use this docker image?
I recommend using docker-compose.yaml to build Docker containers. The following are the specific steps to create this VNC service.

docker-compose.yaml file could be as follows:
```yaml
version: '3'
services:
 centos7_vnc:
    image: lzander/centos7_vnc:v02
    container_name: centos7_vnc
    volumes:
     - ./code:/home/admin1/code
    ports:
     - "23:22"
     - "5902:5901"
    privileged: true
    stdin_open: true
    tty: true
    environment:
      - TZ=Asia/Shanghai
      - LANG=zh_CN.UTF-8
    entrypoint: ["/opt/init/entrypoint.sh"]
    command: ["usr/sbin/init"]
```

use docker command to build the container
```docker
docker compose up -d
```

- Open the terminal and input the commond `docker compose up`.
- Open VNC viewer. Input the `127.0.0.1:5902`.
- SSH service is `127.0.0.1:23`
- user name `admin1`
- user password `admin1`
# How to start the service
- run the command in `docker container`
```powershell
docker exec -it centos7_vnc /bin/bash
```
If there is a problem with the VNC service. We could exec the docker container and check if the VNC service is running. We could use the following command to check and fix the vnc server
```bash
# View port usage status
ps aux | grep vnc
# If no service exists, initialize the environment
/opt/init/init.sh
# If a service exists, delete port 5901 and establish a VNC service for admin1
vncserver -kill :1    # Delete the use of Port 5901
/opt/init/vnc_user_add.sh admin1 admin1 # Add vnc user with the port free
```
# Questions
If you have any questions. You could go to https://github.com/zander-fighting/docker_centos7_vnc

If you need to get the image. You could go to https://hub.docker.com/repository/docker/lzander/centos7_vnc/general
