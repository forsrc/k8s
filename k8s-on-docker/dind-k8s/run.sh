docker network create --subnet=172.77.0.0/24 --gateway=172.77.0.1 net-centos-k8s

docker run -d -it --network net-centos-k8s --ip 172.77.0.100 --hostname dind-k8s  --privileged -v /k8s-on-docker/var/lib/docker:/var/lib/docker -v /k8s-on-docker/var/lib/kub/kubelet:/var/lib/kubelet -v /k8s-on-docker/etc/kubernetes:/etc/kubernetes -v /k8s-on-docker/root:/root -v /k8s-on-docker/temp:/temp --name dind-k8s forsrc/centos:dind-k8s /usr/sbin/init
