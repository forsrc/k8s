

sudo docker run --rm -d -it --name centos-k8s-docker --privileged -v `pwd`/data/resolv.conf:/etc/resolv.conf -v `pwd`/data/hosts:/etc/hosts -v `pwd`/data/centos-k8s-master/var/lib/docker/:/var/lib/docker/ -v `pwd`/data/centos-k8s-master/var/lib/kubelet/:/var/lib/kubelet/ -v `pwd`/data/centos-k8s-master/etc/kubernetes/:/etc/kubernetes/ -v `pwd`/data/centos-k8s-master/root/:/root/ -v `pwd`/data/temp/:/temp/  forsrc/centos:docker /usr/sbin/init

