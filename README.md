Terraform Kubernetes SRE Lab

This is a hands-on lab project for practicing Terraform, Kubernetes, Docker, GitHub Actions, and SRE-style operational documentation.

The goal is to deploy and operate a simple containerized web application in a local Kubernetes cluster using Terraform.

This lab is intended to strengthen Infrastructure-as-Code and Kubernetes fundamentals. It is not meant to represent professional Terraform or Kubernetes administration experience. My professional background is focused on OpenShift-based production application support and SRE operations.

What This Lab Builds

This project creates a local Kubernetes environment using kind and Docker Desktop, then uses Terraform to manage Kubernetes resources.

Current resources include:

Kubernetes namespace
ConfigMap
Secret
Deployment
Service
Readiness probe
Liveness probe
Two running application replicas
Basic verification and troubleshooting runbooks
Architecture
Local Windows Machine
↓
Docker Desktop
↓
kind Kubernetes Cluster
↓
Terraform Kubernetes Provider
↓
Kubernetes Resources
↓
nginx demo application

Local browser access uses kubectl port-forward:

Browser: localhost:8080
↓
kubectl port-forward
↓
Kubernetes Service
↓
Application Pods
↓
nginx demo container
Tools Used
Docker Desktop
kind
Kubernetes
kubectl
Terraform
Git
GitHub
VS Code
Terraform Resources

The Terraform configuration currently manages:

kubernetes_namespace_v1
kubernetes_config_map_v1
kubernetes_secret_v1
kubernetes_deployment_v1
kubernetes_service_v1
Basic Commands

From the terraform/ directory:

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

To inspect the Kubernetes resources:

kubectl get deployment sre-lab-app -n sre-lab
kubectl get pods -n sre-lab
kubectl get services -n sre-lab

To access the app locally:

kubectl port-forward service/sre-lab-app-service 8080:80 -n sre-lab

Then open:

http://localhost:8080

## Runbooks

Operational runbooks are included under the `runbooks/` directory:

- `app-verification.md` - verifies the Deployment, Pods, Service, logs, and browser access.
- `image-pull-failure.md` - documents an `ImagePullBackOff` troubleshooting scenario and recovery steps.
- `destroy-and-rebuild.md` - documents how to safely destroy and recreate the lab from Terraform code.

Troubleshooting Scenario Practiced

One scenario intentionally changed the container image from a valid tag to an invalid tag:

image = "nginxdemos/hello:badtag"

This caused a new Pod to fail with:

ImagePullBackOff

The issue was diagnosed using:

kubectl get pods -n sre-lab
kubectl describe pod <pod-name> -n sre-lab

The fix was applied by restoring the valid image tag in Terraform and running:

terraform plan
terraform apply
What I Learned

This lab helped reinforce:

Terraform workflow: init, fmt, validate, plan, and apply
Kubernetes Deployments, Pods, Services, ConfigMaps, and Secrets
The difference between Docker containers and Kubernetes-managed workloads
How a Service provides a stable endpoint for changing Pods
How readiness and liveness probes support application health
How scaling replicas changes the desired state of a Deployment
How to inspect and troubleshoot failed Kubernetes rollouts with kubectl
How to document operational checks in lightweight runbooks
