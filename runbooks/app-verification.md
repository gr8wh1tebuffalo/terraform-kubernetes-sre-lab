kubectl get deployments -n sre-lab
kubectl get pods -n sre-lab
kubectl describe pod <pod-name> -n sre-lab
kubectl get services -n sre-lab
kubectl port-forward service/sre-lab-app-service 8080:80 -n sre-lab
kubectl logs <pod-name> -n sre-lab

## Scaling Check

The deployment can be scaled by changing the 'replicas' value in Terraform.

Example:

```hcl
replicas = 2
```

Verify the deployment:
kubectl get deployment sre-lab-app -n sre-lab

Expected healthy output:
NAME READY UP-TO-DATE AVAILABLE AGE
sre-lab-app 2/2 2 2 4d1h

Verify the Pods:
kubectl get pods -n sre-lab
