```
docker network create --subnet=172.10.0.0/24 --gateway=172.10.0.1 net-ubuntu-k8s

docker run -d -it --privileged=true  -d -it --network net-ubuntu-k8s --hostname k8s-on-docker --ip 172.10.0.100  -v /temp:/temp/ -v /k8s-on-docker/var/lib/:/var/lib/ -v /k8s-on-docker/etc/kubernetes/:/etc/kubernetes/ -v /k8s-on-docker/etc/docker/:/etc/docker/ -v /k8s-on-docker/k8s/:/k8s-on-docker/ --name k8s-on-docker forsrc/ubuntu:k8s /sbin/init




docker exec -it k8s-on-docker bash
mkdir -p /var/lib/dpkg/{alternatives,info,parts,triggers,updates} && cd /var/lib/dpkg && touch status

kubeadm init --kubernetes-version=v1.16.3 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=172.7.0.10 --ignore-preflight-errors=all


kubeadm join 172.7.0.10:6443 --token aj0oz5.9dc5hh6o5tf6f7vg \
    --discovery-token-ca-cert-hash sha256:c0fb5053cbf782501272d12168e638da1f8538e64d5b0230e9cc718acd8a54d9 --ignore-preflight-errors=all
```
