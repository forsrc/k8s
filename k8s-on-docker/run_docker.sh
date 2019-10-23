
mkdir -p `pwd`/data/temp
mkdir -p `pwd`/data/centos-k8s-master/var/lib/docker
mkdir -p `pwd`/data/centos-k8s-master/var/lib/kubelet
mkdir -p `pwd`/data/centos-k8s-master/etc/kubernetes
mkdir -p `pwd`/data/centos-k8s-master/root

mkdir -p `pwd`/data/centos-k8s-node1/var/lib/docker
mkdir -p `pwd`/data/centos-k8s-node1/var/lib/kubelet
mkdir -p `pwd`/data/centos-k8s-node1/etc/kubernetes
mkdir -p `pwd`/data/centos-k8s-node1/root

mkdir -p `pwd`/data/centos-k8s-node2/var/lib/docker
mkdir -p `pwd`/data/centos-k8s-node2/var/lib/kubelet
mkdir -p `pwd`/data/centos-k8s-node2/etc/kubernetes
mkdir -p `pwd`/data/centos-k8s-node2/root



sudo docker run --rm -d -it --name centos-k8s-docker --privileged -v `pwd`/data/resolv.conf:/etc/resolv.conf -v `pwd`/data/hosts:/etc/hosts -v `pwd`/data/centos-k8s-master/var/lib/docker/:/var/lib/docker/ -v `pwd`/data/centos-k8s-master/var/lib/kubelet/:/var/lib/kubelet/ -v `pwd`/data/centos-k8s-master/etc/kubernetes/:/etc/kubernetes/ -v `pwd`/data/centos-k8s-master/root/:/root/ -v `pwd`/data/temp/:/temp/  forsrc/centos:docker /usr/sbin/init


sudo cp -rf `pwd`/data/centos-k8s-master/var/lib/docker  `pwd`/data/centos-k8s-node1/var/lib/docker
sudo cp -rf `pwd`/data/centos-k8s-master/var/lib/docker  `pwd`/data/centos-k8s-node2/var/lib/docker
sudo cp -rf `pwd`/data/centos-k8s-master/var/lib/kubelet `pwd`/data/centos-k8s-node1/var/lib/kubelet
sudo cp -rf `pwd`/data/centos-k8s-master/var/lib/kubelet `pwd`/data/centos-k8s-node2/var/lib/kubelet
sudo cp -rf `pwd`/data/centos-k8s-master/etc/kubernetes  `pwd`/data/centos-k8s-node1/etc/kubernetes
sudo cp -rf `pwd`/data/centos-k8s-master/etc/kubernetes  `pwd`/data/centos-k8s-node2/etc/kubernetes
sudo cp -rf `pwd`/data/centos-k8s-master/root            `pwd`/data/centos-k8s-node1/root
sudo cp -rf `pwd`/data/centos-k8s-master/root            `pwd`/data/centos-k8s-node2/root



