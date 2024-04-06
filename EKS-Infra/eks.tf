resource "aws_iam_role" "EKS_IAM_Role" {
  name = "eks-cluster-role"

  assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy_attachment" "EKS_IAM_Role-Policy-Attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.EKS_IAM_Role.name
}

resource "aws_eks_cluster" "EKS-Cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.EKS_IAM_Role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnet-1.id,
      aws_subnet.private-subnet-2.id,
      aws_subnet.public-subnet-1.id,
      aws_subnet.public-subnet-2.id
    ]
  }

  provisioner "local-exec" {
    command = <<EOF
      aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}
    EOF
  }

  depends_on = [aws_iam_role_policy_attachment.EKS_IAM_Role-Policy-Attachment]
}