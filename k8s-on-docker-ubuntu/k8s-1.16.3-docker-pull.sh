#!/bin/bash
images=(
kube-apiserver:v1.16.3
kube-controller-manager:v1.16.3
kube-scheduler:v1.16.3
kube-proxy:v1.16.3
pause:3.1
etcd:3.3.15-0
coredns:1.6.2
)
for imageName in ${images[@]};do
    echo docker pull gcr.azk8s.cn/google-containers/$imageName
         docker pull gcr.azk8s.cn/google-containers/$imageName
    
    echo docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageName
         docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageName
    
    echo docker rmi  gcr.azk8s.cn/google-containers/$imageName
         docker rmi  gcr.azk8s.cn/google-containers/$imageName
done
