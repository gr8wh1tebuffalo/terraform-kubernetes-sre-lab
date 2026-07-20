# Terraform vs Helm/OpenShift Deployment Workflow

## Purpose

This note explains how this Terraform/Kubernetes lab relates to prior production support experience with OpenShift, Helm charts, environment-specific values files, Bitbucket pull requests, and Jenkins deployment jobs.

The goal is to clarify where Terraform fits compared to the Helm-based deployment workflow used in prior application support work.

## Prior OpenShift/Helm Workflow

In the prior production environment, application changes were typically promoted through a Git-based release process.

A common workflow looked like this:
    Bitbucket repository
    ↓
    Create feature branch
    ↓
    Update Helm chart version or environment-specific values.yaml
    ↓
    Commit and push changes
    ↓
    Create pull request
    ↓
    Receive approvals
    ↓
    Merge pull request
    ↓
    Run Jenkins deployment job
    ↓
    Helm deploys updated resources into OpenShift
    ↓
    Validate deployment in OpenShift

This workflow was primarily focused on application release and environment-specific configuration management.

Typical changes included:
    Helm chart version updates
    Environment-specific values.yaml updates
    ConfigMap-related application settings
    Deployment configuration values
    Release validation and troubleshooting after Jenkins deployments

## How Helm Fit Into That Workflow

Helm acted as the Kubernetes/OpenShift application packaging and deployment layer.

The development teams maintained base charts. Environment-specific repositories supplied values files that customized those charts for each environment.

A simplified model:
    Base Helm chart
    ↓
    Umbrella chart
    ↓
    Environment-specific values.yaml
    ↓
    Jenkins runs Helm
    ↓
    OpenShift resources are created or updated

The values file did not usually represent the full application by itself. It supplied environment-specific inputs into a chart that generated Kubernetes/OpenShift resources such as Deployments, Services, ConfigMaps, Secrets, and Routes.

## What This Terraform Lab Does Differently

This lab uses Terraform to define and manage Kubernetes resources directly.

Current Terraform-managed resources include:
    Namespace
    ConfigMap
    Secret
    Deployment
    Service

The workflow looks like this:
    Terraform configuration
    ↓
    terraform plan
    ↓
    terraform apply
    ↓
    Terraform talks to the Kubernetes API
    ↓
    Kubernetes resources are created or updated
    ↓
    Application Pods run in the cluster

Instead of changing a Helm values.yaml file and triggering a Jenkins job, this lab defines the Kubernetes resources directly in Terraform.

## Main Conceptual Difference

Helm is commonly used to package and deploy applications into Kubernetes or OpenShift.

Terraform is commonly used to define, provision, and track infrastructure or platform resources across systems.

A simple distinction:
Helm:
Deploy this application using this chart and these values.

Terraform:
Manage this desired set of resources and track their lifecycle in state.

## Terraform State

One of the biggest differences in this lab is Terraform state.

Terraform keeps track of the resources it manages. This allows Terraform to compare the desired configuration in code against the real resources that exist.

That is why Terraform can show plans such as:
    Plan: 5 to add, 0 to change, 0 to destroy
or:
    Plan: 0 to add, 0 to change, 5 to destroy

This plan/apply/destroy lifecycle is one of the key Infrastructure-as-Code concepts this lab demonstrates.

## Where Terraform May Fit in a Real OpenShift Environment

In a larger environment, Terraform may be used by platform, cloud, infrastructure, or DevOps teams to create and manage foundational resources.

Examples include:

    Cloud infrastructure
    Kubernetes or OpenShift clusters
    OpenShift projects/namespaces
    RBAC permissions
    Service accounts
    External databases
    DNS records
    Load balancers
    Storage resources
    Monitoring resources
    Secrets management integrations

Then tools such as Helm, Jenkins, or Argo CD may deploy the actual application into that environment.

A common layered model:
    Terraform:
    Prepare and manage the environment

    Helm:
    Package and deploy the application

    Jenkins or GitHub Actions:
    Automate validation and deployment steps

    Kubernetes/OpenShift:
    Run and manage the application workloads

## How This Lab Connects to Prior Experience
Prior production experience involved supporting application releases, reviewing environment-specific configuration changes, using Git-based pull request workflows, validating OpenShift deployments, and troubleshooting failed rollouts.

This Terraform lab builds on that foundation by practicing the lower-level resource lifecycle directly:
    Define Kubernetes resources as code
    Preview changes with terraform plan
    Apply changes with terraform apply
    Destroy resources with terraform destroy
    Rebuild the environment from code
    Validate changes through GitHub Actions
    Document operational checks in runbooks

## Summary
At FIS, my hands-on deployment work was mainly through Bitbucket, Jenkins, Helm chart versions, and environment-specific values files for OpenShift deployments. I supported the release process, reviewed configuration changes, validated deployments, and helped troubleshoot issues after deployments.

This Terraform lab helped me work one layer deeper. Instead of only updating Helm values and relying on an existing Jenkins deployment process, I defined Kubernetes resources myself, reviewed the Terraform plan, applied the changes, destroyed the environment, and rebuilt it from code. That helped me better understand Infrastructure-as-Code concepts like desired state, state tracking, plan/apply workflow, and resource lifecycle management.