output "cluster_role" {
  value = aws_iam_role.my_cluster_role.arn
}

output "cluster_nodes_role" {
  value = aws_iam_role.my_cluster_nodes_role.arn
}