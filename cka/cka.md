```
source <(kubectl completion bash)
```



1. Set configuration context ```$ kubectl config use-context k8s```
Monitor the logs of Pod ```foobar``` and

*    Extract log lines corresponding to error ```file-not-found```
*    Write them to ```/opt/KULM00201/foobar```

Question weight 5%

```
kubectl logs foobar | grep file-not-found > /opt/KULM00201/foobar

```
------------------

2. Set configuration context ```$ kubectl config use-context k8s```

List all PVs sorted by name saving the full ```kubectl``` output to ```/opt/KUCC0010/my_volumes``` . 
Use ```kubectl```’s own functionally for sorting the output, and do not manipulate it any further.

Question weight 3%

```
kubectl get pv --sort-by=.metadata.name > /opt/KUCC0010/my_volumes
```
* https://kubernetes.io/docs/reference/kubectl/cheatsheet/
------------------

3. Set configuration context ```$ kubectl config use-context k8s```

Ensure a single instance of Pod nginx is running on each node of the kubernetes cluster where nginx also represents the image name which has to be used. Do no override any taints currently in place.

Use Daemonsets to complete this task and use ```ds.kusc00201``` as Daemonset name. 

Question weight 3%

```
kubectl run ds.kusc00201 --image=nginx --dry-run -o yaml > 3.yaml
vi 3.yaml
---
#apiVersion: extensions/v1beta1
#kind: Deployment
apiVersion:apps/v1
kind: DaemonSet
metadata:
  creationTimestamp: null
  labels:
    run: ds.kusc00201
  name: ds.kusc00201
spec:
  #replicas: 1
  selector:
    matchLabels:
      run: ds.kusc00201
   #strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: ds.kusc00201
    spec:
      containers:
      - image: nginx
        name: ds.kusc00201
        resources: {}
#status: {}
```
* https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/ 
------------------


4. Set configuration context ```$ kubectl config use-context k8s```
Perform the following tasks

*    Add an init container to ```lumpy--koala``` (Which has been defined in spec file ```/opt/kucc00100/pod-spec-KUCC00100.yaml```)
*    The init container should create an empty file named ```/workdir/calm.txt```
*    If ```/workdir/calm.txt``` is not detected, the Pod should exit
*    Once the spec file has been updated with the init container definition, the Pod should be created.

Question weight 7%

```
vi /opt/kucc00100/pod-sepc-KUCC00100.yaml

---
apiVersion: v1
kind: Pod
metadata:
  name: lumpy-koala
spec:
  containers:
  - name: checker
    image: nginx
    livenessProbe:
      exec:
        command: ["test", "-e", "/workdir/calm.txt"]
    volumeMounts:
    - name: workdir
      mountPath: /workdir
  initContainers:
  - name: init-busybox
    image: busybox
    command: ["/bin/sh", "-c", "touch /workdir/calm.txt"]
    volumeMounts:
    - name: workdir
      mountPath: /workdir
  volumes:
  - name: workdir
    emptyDir: {}
```
* https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
------------------


5. Set configuration context ```$ kubectl config use-context k8s```

Create a pod named ```kucc4``` with a single container for each of the following images running inside (there may be between 1 and 4 images specified): ```nginx``` + ```redis``` + ```memcached``` + ```consul```

Question weight: 4%

```
kubectl run kucc4 --image=nginx --restart=Never --dry-run -o yaml > 5.yaml
vi 5.yaml

---
apiVersion: v1
kind: Pod
metadata:
 #creationTimestamp: null
  labels:
    run: kucc4
  name: kucc4
spec:
  containers:
  - image: nginx
    name: kucc4
  - image: redis
    name: redis
  - image: memcached
    name: memcached
  - image: consul
    name: consul
   #resources: {}
 #dnsPolicy: ClusterFirst
 #restartPolicy: Never
 #status: {}
 
kubectl apply -f 5.yaml
```
* https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/
-------------------

6. Set configuration context ```$ kubectl config use-context k8s```
Schedule a Pod as follows:

*    Name:  ```nginx-kusc00101```
*    Image: ```nginx```
*    Node   ```selector: disk=ssd``` 

Question weight: 2%

```
kubectl run nginx-kusc00101 --image=nginx --restart=Never --dry-run > 6.yaml
vi 6.yaml

---
apiVersion: v1
kind: Pod
metadata:
  name: nginx-kusc00101
  labels:
    run: nginx-kusc00101
spec:
  containers:
  - name: nginx-kusc00101
    image: nginx
  nodeSelector:
    disk: ssd

```
* https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ 
-------------------

7. Set configuration context ```$ kubectl config use-context k8s```
Create a deployment as follows

*    Name: ```nginx-app```
*    Using container ```nginx``` with version ```1.10.2-alpine```
*    The deployment should contain ```3``` replicas

Next, deploy the app with new version ```1.13.0-alpine``` by performing a rolling update and record that update.

Finally, rollback that update to the previous version ```1.10.2-alpine``` 

Question weight: 4%

```
kubectl run nginx-app --image=nginx:1.10.2-alpine --replicas=3
 
kubectl set image deployment/nginx-app nginx-app=nginx:1.13.0-alpine --record=true

# rollback
kubectl rollout undo deployment/nginx-app
 
kubectl rollout status -w deployment nginx-app
 
kubectl rollout history deployment/nginx-app       
```
-------------------

8. Set configuration context ```$ kubectl config use-context k8s```

Create and configure the service ```front-end-service``` so it’s accessible through ```NodePort``` and routes to the existing pod named ```front-end```

Question weight: 4%

```
kubectl expose pod front-end --name=front-end-service --type='NodePort' --port=80
```
* https://kubernetes.io/docs/reference/kubectl/cheatsheet/
-------------------

9. Set configuration context ```$ kubectl config use-context k8s```
Create a Pod as follows:

*    Name: ```jenkins```
*    Using image: ```jenkins```
*    In a new Kubenetes namespace named ```website-frontend```
    
Question weight 3%

```
kubectl create namespace website-frontend
kubectl run jenkins --image=jenkins --generator=run-pod/v1 --dry-run -o yaml > 9.yml
kubectl apply -f 9.yml -n website-frontend
```
* https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/
------------------

10. Set configuration context ```$ kubectl config use-context k8s```
Create a deployment spec file that will:

*    Launch ```7``` replicas of the ```redis``` image with the label: ```app_env_stage=dev```
*    Deployment name: ```kual00201```

Save a copy of this spec file to ```/opt/KUAL00201/deploy_spec.yaml``` (or .json)

When you are done, clean up (delete) any new k8s API objects that you produced during this task

Question weight: 3%

```
kubectl run kua100201 --image=redis --replicas=7 --labels=app_env_stage=dev --dry-run -o yaml > /opt/KUAL002001/deploy_spec.yaml
kubectl apply  -f /opt/KUAL002001/deploy_spec.yaml 
kubectl delete -f /opt/KUAL002001/deploy_spec.yaml 
```
-------------------

11. Set configuration context ```$ kubectl config use-context k8s```

Create a file ```/opt/KUCC00302/kucc00302.txt``` that lists all pods that implement Service ```foo``` in Namespace ```production```.

The format of the file should be one ```pod``` name per line.

Question weight: 3%

```
SVC_LABELS=$(kubectl describe svc foo -n production | grep -i selector | awk '{print $2}')
kubectl get pods --show-labels --all-namespaces | grep $SVC_LABELS | awk '{print $2}' > /opt/KUCC00302/kucc00302.txt 
```
-------------------

12. Set configuration context ```$ kubectl config use-context k8s```
Create a Kubernetes Secret as follows:

*    Name: ```super-secret```
*    Credential: ```alice```  or ```username:bob``` 

Create a Pod named ```pod-secrets-via-file``` using the ```redis``` image which mounts a secret named super-secret at ```/secrets```

Create a second Pod named ```pod-secrets-via-env``` using the ```redis``` image, which exports credential as ```TOPSECRET```

Question weight: 9%

```
kubectl create secret generic super-secret --from-literal=credential=alice --from-literal=username=bob

kubectl run pod-secrets-via-file --image=redis --generator=run-pod/v1 --dry-run -o yaml >  12.yml
echo "---" >> 12.yml
kubectl run pod-secrets-via-env  --image=redis --generator=run-pod/v1 --dry-run -o yaml >> 12.yml

vi 12.yml

---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: pod-secrets-via-file
  name: pod-secrets-via-file
spec:
  volumes:
  - name: super-secret
    secret:
      secretName: super-secret
  containers:
  - image: redis
    name: pod-secrets-via-file
    resources: {}
    volumeMounts:
    - name: super-secret
      mountPath: /secrets
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
 
---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: pod-secrets-via-env
  name: pod-secrets-via-env
spec:
  volumes:
  - name: super-secret
    secret:
      secretName: super-secret
  containers:
  - image: redis
    name: pod-secrets-via-env
    resources: {}
    env:
    - name: TOPSECRET
      valueFrom:
        secretKeyRef:
          name: super-secret
          key: username
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```
* https://kubernetes.io/docs/concepts/configuration/secret/
-------------------

13. Set configuration context ```$ kubectl config use-context k8s```
Create a pad as follows:

*    Name: ```non-persistent-redis```
*    Container image: ```redis```
*    Named-volume with name: ```cache-control```
*    Mount path: ```/data/redis```

It should launch in the ```pre-prod``` namespace and the volume MUST NOT be persistent.

Question weight: 4%

```
kubectl run non-persistent-redis --image=redis --generator=run-pod/v1 --dry-run -o yaml > 13.yaml
vi 13.yml

---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: non-persistent-redis
  name: non-persistent-redis
spec:
  containers:
  - image: redis
    imagePullPolicy: IfNotPresent
    name: non-persistent-redis
    resources: {}
    volumeMounts:
    - mountPath: /data/redis
      name: cache-control
  volumes:
  - name: cache-control
    emptyDir: {}
   #hostPath:
     #path: /data/redis
     #type: DirectoryOrCreate
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

kubectl create ns pre-prod
kubectl apply -f 13.yml -n pre-prod
```
* https://kubernetes.io/docs/concepts/storage/volumes/
-------------------

14. Set configuration context ```$ kubectl config use-context k8s```
Scale the deployment ```webserver``` to ```6``` pods

Question weight: 1%

```
kubectl scale deployment webserver --replicas=6
```
-------------------

15. Set configuration context ```$ kubectl config use-context k8s```

Check to see how many nodes are ready (not including nodes tainted ```NoSchedule```) and write the number to ```/opt/nodenum```

Question weight: 2%

```
READY=$(kubectl get node | grep -w  Ready | wc -l)
NO_SCHEDULE=$(kubectl describe nodes | grep Taints | grep NoSchedule | wc -l)
expr $READY - $NO_SCHEDULE > /opt/nodenum
```
-------------------

16. Set configuration context ```$ kubectl config use-context k8s```

From the Pod label ```name=cpu-utilizer```, find pods running high CPU workloads and write the name of the Pod consuming most CPU to the file ```/opt/cpu.txt``` (which already exists)

Question weight: 2%

```
kubectl top pods -l name=cpu-utilizer --all-namespaces | sort -k3 -n | tail -1 | awk '{print $2}' > /opt/cpu.txt
```
-------------------

17. Set configuration context ```$ kubectl config use-context k8s```
Create a deployment as follows

*    Name: ```nginx-dns```
*    Exposed via a service: ```nginx-dns```
*    Ensure that the service & pod are accessible via their respective DNS records
*    The container(s) within any Pod(s) running as a part of this deployment should use the ```nginx``` image

Next, use the utility ```nslookup``` to look up the DNS records of the service & pod and write the output to ```/opt/service.dns``` and ```/opt/pod.dns``` respectively.

Ensure you use the ```busybox:1.28``` image(or earlier) for any testing, an the latest release has an unpstream bug which impacts thd use of ```nslookup```.

Question weight: 7%

```
kubectl run nginx-dns --image=nginx 
kubectl expose deployment nginx-dns --port=80
IP=$(kubectl get pod -o wide | grep nginx-dns | awk '{print $6}')
kubectl run busybox --image=busybox:1.28 --restart=Never --command sleep 3600
kubectl exec -ti busybox -- nslookup nginx-dns > /opt/service.dns
kubectl exec -ti busybox -- nslookup $IP > /opt/pod.dns
```
-------------------

18. No configuration context change required for this item

Create a snapshot of the etcd instance running at ```https://127.0.0.1:2379``` saving the snapshot to the file path ```/data/backup/etcd-snapshot.db```

The etcd instance is running etcd version ```3.1.10```

The following TLS ```certificates/key``` are supplied for connecting to the server with ```etcdctl```

*    CA certificate: ```/opt/KUCM00302/ca.crt```
*    Client certificate: ```/opt/KUCM00302/etcd-client.crt```
*    Clientkey:```/opt/KUCM00302/etcd-client.key```

Question weight: 7%

```
ETCDCTL_API=3
etcdctl --endpoints=http://127.0.0.1:2379 \
        --ca-file=/opt/KUCM00302/ca.crt \
        --cert-file=/opt/KUCM00302/etcd-client.crt \
        --key=/opt/KUCM00302/etcd-client.key \
        snapshot save /data/backup/etcd-snapshot.db

ETCDCTL_API=3 etcdctl --write-out=table snapshot status /data/backup/etcd-snapshot.db
```
* https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster
-------------------

19. Set configuration context ```$ kubectl config use-context ek8s```

Set the node labelled with ```name=ek8s-node-1``` as unavailable and reschedule all the pods running on it.

Question weight: 4%

```
NODE=$(kubectl get nodes -l name=ek8s-node-1 | awk '{print $1}')
kubectl drain    $NODE --ignore-daemonsets=true --delete-local-data=true --force=true
kubectl uncordon $NODE
```
 * https://kubernetes.io/docs/concepts/architecture/nodes/
 * https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts
-------------------

20. Set configuration context ```$ kubectl config use-context wk8s```

A Kubernetes worker node, labelled with ```name=wk8s-node-0``` is in state ```NotReady```. Investigate why this is the case, and perform any appropriate steps to bring the node to a ```Ready``` state, ensuring that any changes are made permanent.

Hints:

*    You can ssh to the failed node using ```$ ssh wk8s-node-0```
*    You can assume elevated privileges on the node with the following command ```$ sudo -i```

Question weight: 4%

```
kubectl get nodes
ssh wk8s-node-0
sudo -i
systemctl status kubelet
systemctl enable kubelet
systemctl start  kubelet
```
-------------------

21. Set configuration context ```$ kubectl config use-context wk8s```

Configure the kubelet systemd managed service, on the node labelled with ```name=wk8s-node-1```, to launch a Pod containing a single container of image ```nginx``` named ```myservice``` automatically. Any spec files required should be placed in the ```/etc/kubernetes/manifests``` directory on the node.

Hints:

*    You can ssh to the failed node using ```$ ssh wk8s-node-1```
*    You can assume elevated privileges on the node with the following command ```$ sudo -i``` 

Question weight: 4%

```
ssh wk8s-node-1
sudo -i
kubectl run myservice --image=nginx --generator=run-pod/v1 --dry-run -o yaml >/etc/kubernetes/manifests/21.yml
cat /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf | grep --config
cat /var/lib/kubelet/config.yaml | grep staticPodPath
systemctl daemon-reload
systemctl restart kubelet
systemctl enable  kubelet
```
* https://kubernetes.io/docs/tasks/administer-cluster/static-pod/
-------------------

22. Set configuration context ```$ kubectl config use-context ik8s```

In this task, you will configure a new Node, ```ik8s-node-0```, to join a Kubernetes cluster as follows:

*    Configure kubelet for automatic certificate rotation and ensure that both server and client CSRs are automatically approved and signed as appropnate via the use of RBAC.
*    Ensure that the appropriate cluster-info ConfigMap is created and configured appropriately in the correct namespace so that future Nodes can easily join the cluster
*    Your bootstrap kubeconfig should be created on the new Node at ```/etc/kubernetes/bootstrap-kubelet.conf``` (do not remove this file once your Node has successfully joined the cluster)
*    The appropriate cluster-wide CA certificate is located on the Node at ```/etc/kubernetes/pki/ca.crt``` . You should ensure that any automatically issued certificates are installed to the node at ```/var/lib/kubelet/pki``` and that the kubeconfig file for kubelet will be rendered at ```/etc/kubernetes/kubelet.conf``` upon successful bootstrapping
*    Use an additional group for bootstrapping Nodes attempting to join the cluster which should be called ```system:bootstrappers:cka:default-node-token```
*    Solution should start automatically on boot, with the systemd service unit file for kubelet available at ```/etc/systemd/system/kubelet.service```

To test your solution, create the appropriate resources from the spec file located at ```/opt/..../kube-flannel.yaml``` This will create the necessary supporting resources as well as the ```kube-flannel -ds DaemonSet``` . You should ensure that this DaemonSet is correctly deployed to the single node in the cluster.

Hints:

*    kubelet is not configured or running on ik8s-master-0 for this task, and you should not attempt to configure it.cak.md
*    You will make use of TLS bootstrapping to complete this task.
*    You can obtain the IP address of the Kubernetes API server via the following command ```$ ssh ik8s-node-0 getent hosts ik8s-master-0```
*    The API server is listening on the usual port, 6443/tcp, and will only server TLS requests
*    The kubelet binary is already installed on ```ik8s-node-0``` at ```/usr/bin/kubelet```. You will not need to deploy kube-proxy to the cluster during this task.
*    You can ssh to the new worker node using ```$ ssh ik8s-node-0```
*    You can ssh to the master node with the following command $ ssh ik8s-master-0
*    No further configuration of control plane services running on ik8s-master-0 is required
*    You can assume elevated privileges on both nodes with the following command ```$ sudo -i```
*    Docker is already installed and running on ```ik8s-node-0```

Question weight: 8%

```
```
* https://unofficial-kubernetes.readthedocs.io/en/latest/admin/kubelet-tls-bootstrapping/
-------------------

23. Set configuration context ```$ kubectl config use-context bk8s```

Given a partially-functioning Kubenetes cluster, identify symptoms of failure on the cluster. Determine the node, the failing service and take actions to bring up the failed service and restore the health of the cluster. Ensure that any changes are made permanently.

The worker node in this cluster is labelled with ```name=bk8s-node-0``` Hints:

*    You can ssh to the relevant nodes using ```$ ssh $(NODE)``` where $(NODE) is one of ```bk8s-master-0``` or ```bk8s-node-0```
*    You can assume elevated privileges on any node in the cluster with the following command ```$ sudo -i```

Question weight: 4%

```
ssh bk8s-master-0
sudo -i
docker ps
systemctl status etcd
systemctl status api-server
systemctl status controllor-manager
systemctl status kubelet | grep  "\-\-config\="
cat /var/lib/kubelet/config.yaml | grep staticPodPath
ls /etc/kubernetes/manifests

ssh bk8s-node-0
sudo -i
systemctl start kube-manager-controller
```
-------------------

24. Set configuration context ```$ kubectl config use-context hk8s```

Creae a persistent volume with name app-config of capacity 1Gi and access mode ReadWriteOnce. The type of volume is hostPath and its location is ```/srv/app-config```

Question weight: 3%
```
https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes
vi 24.yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-config
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /srv/app-config
 
kubectl apply -f 24.yaml

```
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes
-------------------
