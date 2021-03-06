docker network create --subnet=172.7.0.0/24 --gateway=172.7.0.1 net-ubuntu-k8s

mkdir -p /k8s-on-docker/etc/
echo 'nameserver 8.8.8.8' > /k8s-on-docker/etc/resolv.conf

NODE_NETWORK=net-ubuntu-k8s
NODE_DATA_DIR=/k8s-on-docker
NODE_IMAGE=forsrc/ubuntu:k8s
NODE_CDM=/sbin/init

NODE_NAME=master
NODE_IP=172.7.0.10
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubelet/:/var/lib/kubelet/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/containerd/:/etc/containerd/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"
NODE_PORT="-p 30000:30000 -p 30080:30080 -p 30443:30443 -p 8080:8080 -p 30001:30001 -p 30002:30002 -p 30003:30003 -p 30004:30004 -p 30005:30005"


docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME $NODE_PORT --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE $NODE_CMD

#apt-get install bash-completion -y
echo 'source /usr/share/bash-completion/bash_completion' >>/k8s-on-docker/$NODE_NAME/root/.bashrc
echo 'source <(kubectl completion bash)' >>/k8s-on-docker/$NODE_NAME/root/.bashrc


NODE_NAME=node1
NODE_IP=172.7.0.11
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubelet/:/var/lib/kubelet/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/containerd/:/etc/containerd/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"
docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE $NODE_CMD

NODE_NAME=node2
NODE_IP=172.7.0.12
NODE_VOLUME=
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR//temp:/temp/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/docker/:/var/lib/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/var/lib/kubelet/:/var/lib/kubelet/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/kubernetes/:/etc/kubernetes/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/docker/:/etc/docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/containerd/:/etc/containerd/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/etc/cni/:/etc/cni/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/k8s/:/k8s-on-docker/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/$NODE_NAME/root/:/root/"
NODE_VOLUME="$NODE_VOLUME -v $NODE_DATA_DIR/etc/resolv.conf:/etc/resolv.conf"
docker run -d -it --privileged=true -d -it --network $NODE_NETWORK --ip $NODE_IP $NODE_VOLUME --hostname $NODE_NAME --name $NODE_NAME $NODE_IMAGE $NODE_CMD
