variable "tags" {
  type = map(string)
}

variable "enable_node_autoscaling" {
  type        = bool
  description = "Habilitar recursos IAM para node-autoscaling (Karpenter)"
  default     = false
}
