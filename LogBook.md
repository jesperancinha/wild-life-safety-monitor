# WLSM Logbook

#### 2024/07/03

DNS is failing and no idea why.

Commands

```shell
kubectl get events -n kube-system
kubectl logs -l k8s-app=kube-dns -n kube-system
kubectl rollout restart deployment coredns -n kube-system
kubectl edit configmap coredns -n kube-system    
```