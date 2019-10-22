#!/bin/bash

yum install -y wget

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo


#yum clean all
#yum makecache

#yum -y update


yum install -y docker-ce-18.09.7-3.el7 docker-ce-cli-18.09.7-3.el7

docker --version

mkdir /etc/docker

cat > /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": [
        "http://f1361db2.m.daocloud.io",	
        "https://registry.docker-cn.com",
        "https://kfwkfulq.mirror.aliyuncs.com",
        "https://registry.docker-cn.com",
        "http://hub-mirror.c.163.com"],
    "dns": ["8.8.8.8", "114.114.114.114"]
}

EOF

cat > /etc/sysctl.conf <<EOF
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-arptables=1
EOF



#systemctl enable docker
