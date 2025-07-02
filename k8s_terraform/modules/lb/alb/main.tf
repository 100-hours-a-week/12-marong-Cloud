# 앱 로드밸런서 생성
resource "aws_lb" "marong-alb" {
    name = "marong-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.security_group_id]
    subnets = var.subnet_ids

    enable_deletion_protection = false
    
    tags = {
      Name = "marong-alb"
    }
}

# 앱 로드밸런서 타겟 그룹 생성
resource "aws_lb_target_group" "marong-alb-target-group" {
    name = "marong-alb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200" # 200 응답 코드 반환 시 헬스 체크 통과
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

    tags = {
      Name = "marong-alb-target-group"
    }
}

# 앱 로드밸런서 리스너 생성
resource "aws_lb_listener" "marong-alb-listener" {
    load_balancer_arn = aws_lb.marong-alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.marong-alb-target-group.arn
    }
}

# 앱 로드밸런서 타겟 그룹 추가
resource "aws_lb_target_group_attachment" "marong-alb-target-group-attachment" {
    count = length(var.target_instance_ids)
    target_group_arn = aws_lb_target_group.marong-alb-target-group.arn
    target_id = var.target_instance_ids[count.index]
    port = 80
}