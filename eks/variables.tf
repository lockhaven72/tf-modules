variable "tags" {
  type = map(string)
  default = {
    "user" = "mvazquez",
    "name"  = "eks-demo"
  }
}

variable "cluster_name" {
  type    = string
  default = "eks-demo"
}

#####habilitar o deshabilitar modulos#####
variable "enable_argocd" {
  type    = bool
  default = true
}
variable "enable_monitoring" {
  type    = bool
  default = true
}
variable "enable_istio" {
  type    = bool
  default = false    #habilitar luego de crear el cluster
}
##########################  revisar  ##########################
#karpenter
variable "enable_node_autoscaling" {
  type        = bool
  description = "Habilitar el módulo de node autoscaling (Karpenter)"
  default     = false
}

