# API 로드밸런서 생성
resource "aws_lb" "marong-api-nlb" {
    name = "marong-api-nlb"
    internal = false
    load_balancer_type = "network"
    security_groups = [var.security_group_id]
    subnets = var.subnet_ids

    enable_deletion_protection = false

    tags = {
      Name = "marong-api-nlb"
    }
}

# API 로드밸런서 타겟 그룹 생성
resource "aws_lb_target_group" "marong-api-nlb-target-group" {
    name = "marong-api-nlb-target-group"
    port = 6443
    protocol = "TCP"
    vpc_id = var.vpc_id

    health_check {
        port = "traffic-port"
        protocol = "TCP"
        interval = 30
        timeout = 10
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

    tags = {
      Name = "marong-api-nlb-target-group"
    }
}

# API 로드밸런서 타겟 그룹 추가
resource "aws_lb_target_group_attachment" "marong-api-nlb-target-group-attachment" {
    count            = length(var.target_instance_ids)
    target_group_arn = aws_lb_target_group.marong-api-nlb-target-group.arn
    target_id        = var.target_instance_ids[count.index]
    port             = 6443    
}

# API 로드밸런서 리스너 생성
resource "aws_lb_listener" "marong-api-nlb-listener" {
    load_balancer_arn = aws_lb.marong-api-nlb.arn
    port = 6443
    protocol = "TCP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.marong-api-nlb-target-group.arn
    }
}