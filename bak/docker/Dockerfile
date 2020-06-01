FROM ubuntu:19.10
MAINTAINER forsrc@gmail.com

ENV DEBIAN_FRONTEND=noninteractive
ARG USER
ENV USER=${USER:-forsrc}
ARG PASSWD
ARG PASSWD=${PASSWD:-forsrc}

RUN apt-get update  -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false
RUN apt-get install -y sudo systemd

RUN useradd -m --shell /bin/bash $USER && \
     echo "$USER:$PASSWD" | chpasswd && \
     echo "$USER ALL=(ALL) ALL" >> /etc/sudoers

RUN apt-get clean

COPY entrypoint.sh /
RUN  chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /home/$USER
USER $USER


CMD [ \
    "/sbin/init" \
]
