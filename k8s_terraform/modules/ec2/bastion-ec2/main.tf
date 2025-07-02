# Bastion host 생성
resource "aws_instance" "marong-bastion" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group_ids
    key_name = var.key_name

    root_block_device {
      volume_type = "gp3"
      volume_size = 8
      encrypted = true
    }

    # user_data = base64encode(templatefile("${path.module}/bastion-init.sh", {
    #   region = var.region
    # }))

    tags = {
      Name = "marong-bastion"
    }
}