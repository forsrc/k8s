FROM forsrc/ubuntu:docker

RUN curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
RUN echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y bash-completion iptables lvm2 ipvsadm ipset conntrack iputils-ping vim kubelet kubeadm kubectl

RUN systemctl enable kubelet

CMD [ "/sbin/init"]
