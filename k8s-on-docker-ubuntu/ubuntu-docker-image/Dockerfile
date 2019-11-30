FROM ubuntu:18.10

RUN apt-get update

RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common systemd

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce
RUN systemctl enable docker


#RUN curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
#RUN echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
#RUN apt-get update
#RUN apt-get install -y docker-ce kubelet kubeadm kubectl
#RUN systemctl enable kubelet

CMD [ "/sbin/init"]
