docker network create --subnet=172.7.0.0/24 --gateway=172.7.0.1 net-ubuntu-k8s

mkdir -p /k8s-on-docker/etc/
echo 'nameserver 8.8.8.8' > /k8s-on-docker/etc/resolv.conf

NODE_NETWORK=net-ubuntu-k8s
NODE_DATA_DIR=/k8s-on-docker
NODE_IMAGE=forsrc/ubuntu:k8s

NODE_NAME=master
NODE_IP=172.7.0.10
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v /temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubernetes/:/var/lib/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"

docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE /sbin/init


#apt-get install bash-completion -y
echo 'source /usr/share/bash-completion/bash_completion' >>/k8s-on-docker/$NODE_NAME/root/.bashrc
echo 'source <(kubectl completion bash)' >>/k8s-on-docker/$NODE_NAME/root/.bashrc


NODE_NAME=node1
NODE_IP=172.7.0.11
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v /temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubernetes/:/var/lib/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"
docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE /sbin/init

NODE_NAME=node2
NODE_IP=172.7.0.12
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v /temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubernetes/:/var/lib/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"
docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE /sbin/init
