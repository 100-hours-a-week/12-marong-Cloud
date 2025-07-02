# master node 생성
resource "aws_instance" "marong-master" {
    count = var.master_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group_ids
    key_name = var.key_name
    
    root_block_device {
      volume_type = "gp3"
      volume_size = 20
      encrypted = true
    }

    tags = {
      Name = "marong-master"
      Role = "master"
    }
}