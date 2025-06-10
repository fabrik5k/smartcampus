terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Cria (ou registra) sua chave SSH na AWS
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Security Group liberando SSH e HTTP (ajuste conforme sua aplicação)
resource "aws_security_group" "app_sg" {
  name_prefix = "tf-app-"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Busca a AMI mais recente do Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Instância EC2 que vai rodar seu Docker Compose
resource "aws_instance" "app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  # Script que configura Docker, Clone do repo e `docker-compose up -d`
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user

              # instala Docker Compose v2
              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
                   -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose

              # clona seu projeto e sobe containers
              cd /home/ec2-user
              git clone ${var.git_repo_url} app
              cd app
              docker-compose up -d
              EOF

  tags = {
    Name = "terraform-docker-app"
  }
}

# Saída do IP público para você acessar a aplicação
output "app_public_ip" {
  description = "Endereço público da EC2"
  value       = aws_instance.app.public_ip
}
