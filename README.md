# What is the purpose of this Docker image?
This Docker image is designed to quickly build a Gnome desktop and VNC service based on Centos7, making it convenient for everyone to quickly learn and master Centos7.

# How to creat a docker image?
- make a working directory
- download the files
- use docker command to build a docker image
```docker
docker build -t centos7_vnc:v03 .
```

# How to use this docker image?
I recommend using docker-compose.yaml to build Docker containers. The following are the specific steps to create this VNC service.

use docker command to build the container
```docker
docker compose up
```

- Open the terminal and input the commond `docker compose up`.
- Open VNC viewer. Input the `127.0.0.1:5901`.
- user name `admin1`
- user password `admin1`

# Questions
If you have any questions. You could go to https://github.com/zander-fighting/docker_centos7_vnc

If you need to get the image. You could go to https://hub.docker.com/repository/docker/lzander/centos7_vnc/general