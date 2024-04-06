resource "aws_ecr_repository" "prod-ecr" {
  name = var.ecr_name

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_caller_identity" "current" {}

resource "null_resource" "docker_packaging" {

  provisioner "local-exec" {
    command = <<EOF
aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com && docker pull nginx && docker tag nginx:latest ${aws_ecr_repository.prod-ecr.repository_url}:nginx && docker push ${aws_ecr_repository.prod-ecr.repository_url}:nginx
EOF
  }


  triggers = {
    "run_at" = timestamp()
  }


  depends_on = [
    aws_ecr_repository.prod-ecr
  ]
}