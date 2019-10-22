FROM centos:7

RUN mkdir /work
ADD ./centos_install_docker.sh /work

RUN ls /work

RUN chmod +x /work/centos_install_docker.sh

RUN /work/centos_install_docker.sh

RUN systemctl enable docker

CMD [ "/usr/sbin/init"]
