FROM forsrc/ubuntu:docker

RUN curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
RUN echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y bash-completion iptables lvm2 ipvsadm ipset conntrack iputils-ping vim wget kubelet kubeadm kubectl systemd
#RUN apt-get install -y bash-completion vim kubelet kubeadm kubectl

VOLUME /var/lib/docker
VOLUME /var/lib/kubelet
VOLUME /etc/kubernetes

RUN systemctl enable kubelet

ENTRYPOINT ["wrapdocker"]

CMD ["/sbin/init"]
