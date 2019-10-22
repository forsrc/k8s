FROM forsrc/centos:docker

#RUN mkdir /work

#ADD ./centos_install_docker.sh /work

ADD ./centos_install_k8s.sh /work
ADD ./k8s_docker_pull.sh /work


RUN ls /work

RUN chmod +x /work/*.sh

#RUN /work/centos_install_docker.sh

RUN /work/centos_install_k8s.sh

#RUN /work/k8s_docker_pull.sh

RUN echo "swapoff -a" > /root/.bash

RUN systemctl enable docker && systemctl enable kubelet

CMD [ "/usr/sbin/init"]
