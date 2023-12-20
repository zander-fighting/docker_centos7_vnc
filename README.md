# What is the purpose of this Docker image?
This Docker image is designed to quickly build a Gnome desktop and VNC service based on Centos7, making it convenient for everyone to quickly learn and master Centos7.

# How to use this docker image?
I recommend using docker-compose.yaml to build Docker containers. The following are the specific steps to create this VNC service.

- Create a working directory.
- In the working directory. Create a `docker-compose.yaml` file. Input the following messages.

```yaml
version: "3"

services:
  centos7_vnc:
    image: lzander/centos7_vnc:v01
    container_name: centos7_vnc
    privileged: true
    ports:
      - "5901:5901"
      - "5902:5902"
    environment:
      - TZ=Asia/Shanghai
      - LANG=zh_CN.UTF-8
```

- Open the terminal and input the commond `docker compose up`.
- Open VNC viewer. Input the `127.0.0.1:5901`.

# Questions
If you have any questions. You could go to https://github.com/zander-fighting/docker_centos7_vnc

If you need to get the image. You could go to https://hub.docker.com/repository/docker/lzander/centos7_vnc/general