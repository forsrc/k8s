```
docker network create --subnet=172.10.0.0/24 --gateway=172.10.0.1 net-ubuntu-k8s

docker run -d -it --privileged=true  -d -it --network net-ubuntu-k8s --ip 172.10.0.100  -v /temp:/temp/ -v /k8s-on-docker/var/lib/:/var/lib/ -v /k8s-on-docker/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/etc/docker/:/etc/docker/ --name k8s-on-docker forsrc/ubuntu:k8s /sbin/init


```
