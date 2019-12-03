```
docker network create --subnet=172.10.0.0/24 --gateway=172.10.0.1 net-ubuntu-k8s

#docker run -d -it --privileged=true --network net-ubuntu-k8s --hostname k8s-on-docker --ip 172.10.0.100  -v /k8s-on-docker/temp:/temp/ -v /k8s-on-docker/var/lib/docker/:/var/lib/docker/ -v /k8s-on-docker/var/lib/kubelet/:/var/lib/kubelet/ -v /k8s-on-docker/var/lib/kubernetes/:/var/lib/kubernetes/ -v /k8s-on-docker/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/etc/docker/:/etc/docker/ -v /k8s-on-docker/k8s/:/k8s-on-docker/ -v /k8s-on-docker/root/:/root/ --name k8s-on-docker forsrc/ubuntu:k8s /sbin/init

docker run --privileged -itd -p 22375:2375 -p 22376:2376 -p 8888 -v /k8s-on-docker:/k8s-on-docker/ --name docker-dind docker:dind 

iptables -t nat -I PREROUTING -p tcp --dport 30010 -j DNAT --to-destination 172.7.0.10:30010

apt-get install ipvsadm -y
apt-get install --reinstall linux-image-`uname -r`

apt-get install rinetd -y
rm -f /etc/rinetd.conf
cat >> /etc/rinetd.conf <<EOF
# allow 192.168.0.*
# deny 192.168.1.*
# logfile /var/log/rinetd.log
0.0.0.0 8080  172.7.0.10 8080
0.0.0.0 30080 172.7.0.10 30080
0.0.0.0 30443 172.7.0.10 30443
0.0.0.0 30000 172.7.0.10 30000
0.0.0.0 30001 172.7.0.10 30001
0.0.0.0 30002 172.7.0.10 30002
0.0.0.0 30003 172.7.0.10 30003
0.0.0.0 30004 172.7.0.10 30004
0.0.0.0 30005 172.7.0.10 30005
0.0.0.0 30006 172.7.0.10 30006
0.0.0.0 30007 172.7.0.10 30007
0.0.0.0 30008 172.7.0.10 30008
0.0.0.0 30009 172.7.0.10 30009
EOF
rinetd -c /etc/rinetd.conf

// if swap on --> kubelet --fail-swap-on=false

docker exec -it k8s-on-docker bash
mkdir -p /var/lib/dpkg/{alternatives,info,parts,triggers,updates} && touch /var/lib/dpkg/status && touch /var/lib/dpkg/available

kubeadm init --kubernetes-version=v1.16.3 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=172.7.0.10 --ignore-preflight-errors=all


kubeadm join 172.7.0.10:6443 --token pfw6mf.x1er39lb9lylvq94 \
    --discovery-token-ca-cert-hash sha256:440ff9ee1e39b2fabf319a76360000beb841835d739102c01e8d7b98f66bae6c --ignore-preflight-errors=all

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

```
