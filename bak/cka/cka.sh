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

# https://v1-15.docs.kubernetes.io/docs/tasks/configure-pod-container/static-pod/

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
# https://v1-15.docs.kubernetes.io/docs/concepts/workloads/controllers/daemonset/

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


############### rollout  nginx 1.9.1 -> 1.13.1 -> 1.9.1

kubectl run nginx-rollout --image=nginx:1.9.1
kubectl set image deployment nginx-rollout nginx-rollout=nginx:1.13.1 --record
kubectl rollout history deployment nginx-rollout
kubectl rollout undo deployment nginx-rollout


kubectl rollout res    deployment nginx-rollout
kubectl rollout resume deployment nginx-rollout

############### busybox

---
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    command:
      - sleep
      - "3600"
    imagePullPolicy: IfNotPresent
  restartPolicy: Always

kubectl exec -it busybox -- nslookup kubernetes.default

# sh -c 'if [ -f test.txt ]; then  echo OK; else echo NG; fi'


apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'if [ -f /data/a.txt ]; then sleep 3600; fi']
    volumeMounts:
    - name: data
      mountPath: /data
  initContainers:
  - name: init-myservice
    image: busybox:1.28
    command: ['sh', '-c', 'touch /data/a.txt']
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    emptyDir: {}
    #hostPath:
      #path: /data



############

