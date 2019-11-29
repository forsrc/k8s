


```
curl 172.77.0.3:32080 -H "HOST:demo.forsrc.com"
```

```
openssl genrsa -out demo.forsrc.com.key 2048
openssl req -new -x509 -key demo.forsrc.com.key -out demo.forsrc.com.crt -subj /C=CN/ST=forsrc/L=forsrc/O=devops/CN=demo.forsrc.com
kubectl create secret tls nginx-demo --cert=demo.forsrc.com.crt --key=demo.forsrc.com.key

spec:
  tls:
  - hosts:
    - demo.forsrc.com
    secretName: nginx-demo
    
 
curl https://demo.forsrc.com:32443/ -k
```
