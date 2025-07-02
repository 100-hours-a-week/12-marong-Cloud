# worker node 생성
resource "aws_instance" "marong-worker" {
    count = var.worker_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_ids[count.index % length(var.subnet_ids)]
    security_groups = var.security_group_ids
    key_name = var.key_name
    
    root_block_device {
      volume_type = "gp3"
      volume_size = 20
      encrypted = true
    }

    ebs_block_device {
      device_name = "/dev/xvda"
      volume_type = "gp3"
      volume_size = 20
      encrypted = true
    }

    # user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    #   master_public_ip = aws_instance.marong-master[0].public_ip
    #   region = var.region
    #   s3_bucket = var.s3_bucket
    # }))

    tags = {
      Name = "marong-worker"
      Role = "worker"
    }
}