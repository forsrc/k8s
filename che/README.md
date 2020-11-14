```
bash <(curl -sL  https://www.eclipse.org/che/chectl/)

kubectl apply -f  https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/nfs-client/deploy/rbac.yaml

kubectl get svc -n ingress-nginx

LB=$(kubectl get svc -n ingress-nginx ingress-nginx-controller | grep LoadBalancer | awk -F " " '{print $3}')

chectl server:deploy --platform k8s --domain ${LB}.nip.io


```
