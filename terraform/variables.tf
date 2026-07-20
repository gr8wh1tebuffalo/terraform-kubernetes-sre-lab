variable "namespace_name" {
  description = "Kubernetes namespace used for the lab resources."
  type        = string
  default     = "sre-lab"
}

variable "app_name" {
  description = "Name used for the Kubernetes application resources."
  type        = string
  default     = "sre-lab-app"
}

variable "app_image" {
  description = "Container image used by the demo application."
  type        = string
  default     = "nginxdemos/hello:latest"
}

variable "app_replicas" {
  description = "Number of application pod replicas."
  type        = number
  default     = 2
}

variable "app_port" {
  description = "Container and service port for the demo application."
  type        = number
  default     = 80
}

variable "app_environment" {
  description = "Application environment label used in the ConfigMap."
  type        = string
  default     = "local-lab"
}