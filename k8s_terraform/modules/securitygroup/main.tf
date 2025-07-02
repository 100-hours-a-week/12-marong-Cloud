# master node를 위한 보안 그룹 생성
resource "aws_security_group" "marong-master-sg" {
    name        = "marong-master-sg"
    description = "marong-master-sg"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH access"
    }
    ingress {
        from_port   = 6443
        to_port     = 6443
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        description = "Kubernetes API server"
    }
    ingress {
        from_port   = 2379
        to_port     = 2380
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        description = "etcd server client API"
    }
    ingress {
        from_port   = 10250
        to_port     = 10250
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        description = "Kubelet API"
    }
    ingress {
        from_port   = 10259
        to_port     = 10259
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        description = "kube-scheduler"
    }
    ingress {
        from_port   = 10257
        to_port     = 10257
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        description = "kube-controller-manager"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic"
    }

    tags = {
        Name = "marong-master-sg"
    }
}

# worker node를 위한 보안 그룹 생성
resource "aws_security_group" "marong-worker-sg" {
    name        = "marong-worker-sg"
    description = "marong-worker-sg"
    vpc_id      = var.vpc_id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH access"
    }
    ingress {
        from_port   = 10250
        to_port     = 10250
        protocol    = "tcp"    
        cidr_blocks = ["10.0.0.0/16"]
        description = "Kubelet API"
    }
    ingress {
        from_port   = 30000
        to_port     = 32767
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "NodePort Services"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic"
    }

    tags = {
        Name = "marong-worker-sg"
    }
}

# bastion host를 위한 보안 그룹 생성    
resource "aws_security_group" "marong-bastion-sg" {
    name        = "marong-bastion-sg"
    description = "marong-bastion-sg"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH access"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic"
    }

    tags = {
        Name = "marong-bastion-sg"
    }
}

# ALB를 위한 보안 그룹 생성
resource "aws_security_group" "marong-alb-sg" {
    name        = "marong-alb-sg"
    description = "marong-alb-sg"
    vpc_id      = var.vpc_id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic"
    }
    
    tags = {
        Name = "marong-alb-sg"
    }
}