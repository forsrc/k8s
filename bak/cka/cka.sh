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

##################




##################
