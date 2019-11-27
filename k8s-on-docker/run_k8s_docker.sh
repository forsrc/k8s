sudo swapoff -a

sudo mkdir ~/docker
sudo cp -rf data ~/docker

docker network create --subnet=172.77.0.0/24 --gateway=172.77.0.1 net-centos-k8s

docker run -d --privileged \
--name nfs-server \
--network net-centos-k8s --ip 172.77.0.100 \
-v ~/docker/nfs:/nfs \
-e NFS_EXPORT_DIR_1=/nfs \
-e NFS_EXPORT_DOMAIN_1=\* \
-e NFS_EXPORT_OPTIONS_1=ro,insecure,no_subtree_check,no_root_squash,fsid=1 \
-p 111:111 -p 111:111/udp \
-p 2049:2049 -p 2049:2049/udp \
-p 32765:32765 -p 32765:32765/udp \
-p 32766:32766 -p 32766:32766/udp \
-p 32767:32767 -p 32767:32767/udp \
fuzzle/docker-nfs-server:latest


sudo docker run -d -it --network net-centos-k8s --ip 172.77.0.2 --hostname centos-k8s-master --name centos-k8s-master --privileged --device=~/docker/net/bridge:/proc/sys/net/bridge -v ~/docker/resolv.conf:/etc/resolv.conf -v ~/docker/centos-k8s-master/var/lib/docker:/var/lib/docker -v ~/docker/centos-k8s-master/var/lib/kubelet:/var/lib/kubelet -v ~/docker/centos-k8s-master/etc/kubernetes:/etc/kubernetes -v ~/docker/centos-k8s-master/root:/root -v ~/docker/temp:/temp -p 8001:8001 -p 8080:8080 -p 6443:6443 forsrc/centos:k8s /usr/sbin/init

sudo docker run -d -it --network net-centos-k8s --ip 172.77.0.3 --hostname centos-k8s-node1  --name centos-k8s-node1  --privileged --device=~/docker/net/bridge:/proc/sys/net/bridge -v ~/docker/resolv.conf:/etc/resolv.conf -v ~/docker/centos-k8s-node1/var/lib/docker:/var/lib/docker  -v ~/docker/centos-k8s-node1/var/lib/kubelet:/var/lib/kubelet  -v ~/docker/centos-k8s-node1/etc/kubernetes:/etc/kubernetes  -v ~/docker/centos-k8s-node1/root:/root  -v ~/docker/temp:/temp forsrc/centos:k8s /usr/sbin/init

sudo docker run -d -it --network net-centos-k8s --ip 172.77.0.4 --hostname centos-k8s-node2  --name centos-k8s-node2  --privileged --device=~/docker/net/bridge:/proc/sys/net/bridge -v ~/docker/resolv.conf:/etc/resolv.conf -v ~/docker/centos-k8s-node2/var/lib/docker:/var/lib/docker  -v ~/docker/centos-k8s-node2/var/lib/kubelet:/var/lib/kubelet  -v ~/docker/centos-k8s-node2/etc/kubernetes:/etc/kubernetes  -v ~/docker/centos-k8s-node2/root:/root  -v ~/docker/temp:/temp forsrc/centos:k8s /usr/sbin/init

