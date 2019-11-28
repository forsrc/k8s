################ namespace

kubectl create namespace cka

# or
cat <<EOF > namespace-cka.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: cka
EOF

################ kubectl completion bash

yum install bash-completion -y
source /usr/share/bash-completion/bash_completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source <(kubectl completion bash)

################ static pod

cat /var/lib/kubelet/config.yaml  # staticPodPath: /etc/kubernetes/manifests

mkdir /etc/kubelet.d
cat <<EOF > /etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  namespace: cka
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF

find / -name kubelet.service.d

# vi /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
# --pod-manifest-path=/etc/kubernetes/manifests"
# or
# --manifest-ur=...

find / -name kubelet
# echo 'KUBELET_EXTRA_ARGS="--cluster-dns=10.96.0.10 --cluster-domain=cluster.local --pod-manifest-path=/etc/kubernetes/manifests"' >/etc/sysconfig/kubelet
echo 'KUBELET_EXTRA_ARGS="--pod-manifest-path=/etc/kubernetes/manifests"' >/etc/sysconfig/kubelet

systemctl daemon-reload
systemctl restart kubelet
systemctl status kubelet -l

ps -ef | grep kubelet

################## --sort-by

kubectl get pod --all-namespaces --sort-by=.metadata.name

################## daemonset

kubectl run daemonset-test -n cka --image=nginx -o yaml  --dry-run > daemonset-test.yaml

apiVersion: apps/v1
#kind: Deployment
kind: DaemonSet  ######################
metadata:
  #creationTimestamp: null
  labels:
    run: daemonset-test
  name: daemonset-test
  namespace: cka
spec:
  #replicas: 1      ##########################
  selector:
    matchLabels:
      run: daemonset-test
  #strategy: {}
  template:
    metadata:
      #creationTimestamp: null
      labels:
        run: daemonset-test
    spec:
      containers:
      - image: nginx
        name: daemonset-test
        #resources: {}
#status: {} ##################

################## nginx busybox

kubectl run nginx-busybox --image=nginx -o yaml --dry-run --restart=Never > nginx-busybox.yaml

vi nginx_busybox.yaml
#####
apiVersion: v1
kind: Pod
metadata:
  #creationTimestamp: null
  labels:
    run: nginx-busybox
  name: nginx-busybox
  namespace: cka
spec:
  containers:
  - image: nginx
    name: nginx
    #resources: {}
  - image: busybox
    name: busybox
  #dnsPolicy: ClusterFirst
  restartPolicy: Never
#status: {}


###############


