NODE_NAME=master
NODE_IP=172.10.0.10
docker run -d -it --privileged=true  -d -it --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname centos-k8s-master --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init

NODE_NAME=node1
NODE_IP=172.10.0.11
docker run -d -it --privileged=true  -d -it --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname centos-k8s-master --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init

NODE_NAME=node2
NODE_IP=172.10.0.12
docker run -d -it --privileged=true  -d -it --ip $NODE_IP  -v /temp:/temp/ -v /k8s-on-docker/$NODE_NAME/var/lib/:/var/lib/ -v /k8s-on-docker/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/$NODE_NAME/etc/docker/:/etc/docker/ -v /k8s-on-docker/$NODE_NAME/k8s/:/k8s-on-docker/ --hostname centos-k8s-master --name $NODE_NAME forsrc/ubuntu:k8s /sbin/init
