# Image Pull Failure Runbook

##Scenario

A deployment update used an invalid container image tag:

```hcl
image = "nginxdemos/hello:badtag"
```

--Showed the old pods still available, but new rollout was unhealthy
kubectl get deployment sre-lab-app -n sre-lab

--Showed pod status
kubectl get pods -n sre-lab
--Example failure
STATUS: ImagePullBackOff
Ready: 0/1

--Describe the failed pod
kubectl describe pod <pod-name> -n sre-lab
--Example error
failed to resolve reference "docker.io/nginxdemos/hello:badtag": not found

--Resolution - Update the Terraform deployment image back to a valid tag
image = "nginxdemos/hello:latest"

--Apply the fix
terraform valid
terraform plan
terraform apply

--Confirm healthy deployment
kubectl get deployment sre-lab-app -n sre-lab
--Expected output:
READY: 2/2
UP-TO-DATE: 2
AVAILABLE: 2

--Confirm pods are running
kubectl get pods -n sre-lab
--Expected output:
READY: 1/1
STATUS: Running
