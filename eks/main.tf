module "network" {
  source = "./network"
  tags   = var.tags
}

module "iam" {
  source = "./iam"
  tags   = var.tags
}
module "eks" {
  source             = "./eks"
  cluster_name       = var.cluster_name
  cluster_subnets    = module.network.subnets_ids
  cluster_role       = module.iam.cluster_role
  cluster_nodes_role = module.iam.cluster_nodes_role
  tags               = var.tags
}