# syntax=docker/dockerfile:1
FROM ubuntu/nginx:1.18-22.04_beta
RUN apt update
RUN apt install htop openssh-server sudo finger manpages-posix-dev iputils-* sl cowsay fortune fortune-mod figlet ansiweather -y 

RUN service ssh start
RUN update-rc.d ssh defaults

RUN echo 'proc    /proc    proc    defaults,nosuid,nodev,noexec,relatime,hidepid=2     0     0' >> /etc/fstab

RUN yes | unminimize

# Install the pretty header for when users login
COPY ./header /etc/update-motd.d/00-header
RUN chmod +x /etc/update-motd.d/00-header

# Install Docker
RUN sudo apt-get install ca-certificates curl gnupg lsb-release -y
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

COPY ./index.html /var/www/html/index.html

# Add the user
ARG USER
ARG PASS

RUN useradd -m -s /bin/bash $USER
RUN yes $PASS | passwd $USER
RUN usermod -aG sudo $USER

# Give user docker permissions
RUN usermod -aG docker $USER

CMD service ssh start && service nginx start && service docker start && tail -F /var/log/ssh/syslog
