
```
172.77.0.2	centos-k8s-master
172.77.0.3	centos-k8s-node1
172.77.0.4	centos-k8s-node2
```
 
```

echo 'source <(kubectl completion bash)' >>~/.bashrc
source <(kubectl completion bash)

sudo docker exec -it centos-k8s-master bash

echo 'nameserver 8.8.8.8' > /etc/resolv.conf

kubeadm init --kubernetes-version=v1.15.3 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=172.77.0.2 --ignore-preflight-errors=all


kubeadm join 172.77.0.2:6443 --token uvd3zl.ijbuivhdut3kanxy \
    --discovery-token-ca-cert-hash sha256:387b705c7cb01a95a5d266c71d62b93b1d1be914e1eca26055ef333b39c5ce5b   --ignore-preflight-errors=all

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
docker pull quay.io/coreos/flannel:v0.11.0-amd64


kubectl get nodes
kubectl get pods --all-namespaces


kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

kubectl proxy --port=8001 --address=172.77.0.2

curl http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

```

