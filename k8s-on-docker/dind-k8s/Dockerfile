FROM forsrc/centos:dind

RUN sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

RUN yum install -y yum-utils device-mapper-persistent-data lvm2 ipvsadm ipset conntrack ntp

RUN cat <<EOF > /etc/yum.repos.d/kubernetes.repo \
[kubernetes] \
name=Kubernetes \
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64 \
enabled=1 \
gpgcheck=1 \
repo_gpgcheck=1 \
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg \
EOF

RUN yum install -y kubelet-1.15.3 kubeadm-1.15.3 kubectl-1.15.3 nfs-utils

RUN systemctl enable docker
RUN systemctl enable kubelet

CMD [ "/usr/sbin/init"]
