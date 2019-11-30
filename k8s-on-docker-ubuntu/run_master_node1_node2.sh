docker network create --subnet=172.7.0.0/24 --gateway=172.7.0.1 net-ubuntu-k8s

NODE_NAME=master
NODE_IP=172.7.0.10
docker run -d -it --privileged=true  -d -it --network net-ubuntu-k8s --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname $NODE_NAME --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init

NODE_NAME=node1
NODE_IP=172.7.0.11
docker run -d -it --privileged=true  -d -it --network net-ubuntu-k8s --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname $NODE_NAME --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init

NODE_NAME=node2
NODE_IP=172.7.0.12
docker run -d -it --privileged=true  -d -it --network net-ubuntu-k8s --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname $NODE_NAME --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init
