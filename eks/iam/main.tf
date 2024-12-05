# Asignamos al control plane el permiso para asumir otro role con permisos para llamar a servicios externos de AWS
resource "aws_iam_role" "my_cluster_role" {
  name = "cluster_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Creamos rol de iam para los nodos del cluster
resource "aws_iam_role" "my_cluster_nodes_role" {
  name = "node_roles"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Se asocian las policies ya predefinidas a los roles
# AmazonEKSClusterPolicy = describir y attachear volumenes, crear tags, describir instancias, balanceo, etc
resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.my_cluster_role.name
}

# describir instancias, security groups, subnets, describir vpcs, clusters
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my_cluster_nodes_role.name
}

# asignar ips privadas, attachear ENIs, describir subnets, describir instancias
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.my_cluster_nodes_role.name
}

# tomar token, listar imagenes, describir imagenes, 
resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_cluster_nodes_role.name
}