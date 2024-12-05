variable "tags" {
  type = map(string)
  default = {
    "user" = "juan-battaglino",
    "name"  = "byma-demo"
  }
}

variable "cluster_name" {
  type    = string
  default = "byma-demo"
}