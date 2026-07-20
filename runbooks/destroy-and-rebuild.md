# Destroy and Rebuild Runbook

## Purpose

This runbook documents how to safely destroy and recreate the local Terraform Kubernetes SRE lab.

This demonstrates a core Infrastructure-as-Code concept: the environment can be removed and recreated from version-controlled Terraform configuration.

## Scope

This runbook applies to the local kind Kubernetes cluster named `sre-lab`.

Terraform manages the following Kubernetes resources:

- Namespace
- ConfigMap
- Secret
- Deployment
- Service

## Prerequisites

Docker Desktop must be running.

The kind cluster must exist and kubectl should be pointed at the correct context:

```bash
kubectl config current-context
```

# Checking terraform state

--From Terraform directory
terraform state list
--Expected output:
kubernetes_config_map_v1.app_config
kubernetes_deployment_v1.app
kubernetes_namespace_v1.sre_lab
kubernetes_secret_v1.app_secret
kubernetes_service_v1.app_service

--Preview Destroy
terraform plan -destroy
--Destroy resources
terraform destroy
--Verify resources are gone
kubectl get namespace sre-lab
terraform state list

# Preview rebuild

terraform plan
--Rebuild resources
terraform apply
--Verify deployment
kubectl get deployments -n sre-lab
--Expected results
sre-lab-app 2/2
-Check pods
kubectl get pods -n sre-lab

# Verify browser access

kubectl port-forward service/sre-lab-app-service 8080:80 -n sre-lab
--open
http://localhost:8080
--Ctrl+C to stop
