FROM ubuntu:18.10

RUN apt-get update

#RUN apt-get install --y linux-image-`uname -r`

RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common systemd bash-completion 

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce


RUN curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
RUN echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y docker-ce kubelet kubeadm kubectl iptables lvm2 ipvsadm ipset conntrack

RUN echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
RUN echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.conf
RUN echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf

RUN echo "modprobe br_netfilter" > /etc/init.d/load_br_netfilter.sh
RUN echo "modprobe -- ip_vs" >> /etc/init.d/load_br_netfilter.sh
RUN echo "modprobe -- ip_vs_rr" >> /etc/init.d/load_br_netfilter.sh
RUN echo "modprobe -- ip_vs_wrr" >> /etc/init.d/load_br_netfilter.sh
RUN echo "modprobe -- ip_vs_sh" >> /etc/init.d/load_br_netfilter.sh
RUN echo "modprobe -- nf_conntrack_ipv4" >> /etc/init.d/load_br_netfilter.sh
RUN chmod +x /etc/init.d/load_br_netfilter.sh
RUN update-rc.d load_br_netfilter.sh defaults 90

#RUN iptables -P FORWARD ACCEPT

RUN systemctl enable docker && systemctl enable kubelet

CMD [ "/sbin/init"]
