```

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

kubectl proxy --port=8001 --address=172.77.0.2

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

kubectl get pods --all-namespaces




kubectl -n kubernetes-dashboard get secret
kubectl -n kubernetes-dashboard describe secrets kubernetes-dashboard-token-kx56p

cat > dashboard-adminuser.yaml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

kubectl apply -f dashboard-adminuser.yaml

cat > dashboard-admin.yaml <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

kubectl apply -f dashboard-admin.yaml 

kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')


eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLTI5ZnFwIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJlY2IxNjhkYi0xNmVjLTQxOWMtYWY3NC0xYTM5MjU3MzZmNTgiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.ZOVz9CjWY0SfM63VyM7yQEx3WkiGRAThmQNry56cmHAfaX64zhzFOAZGJAVRRl6O0L_edxG-1Dm2kNfQqgfvxYsbCl7ckUrecUe-iYZWfATp7bahe4TRPnc_cu9p3dA6gKRf0CiV28fMPW1W7pPEm-64g6qo481Wx2loTHMIU8RNjxeih1EZ3N_adzVj_nntI6xXTX-gYZRi5KmCHCd0yAQ_YY50wc6BbL5kGbiw4GJt7FyMcAKf1nWnPe_k8ECaI3tL2Xp83SU6bxtpc85DufP8Ae1goRNRuWZPlL_mJoVqlg8WAVh7slG3wuLp73efHm78BeDuuAJxPOmL278Y1A

```

