resource "aws_efs_file_system" "efs" {
  #creation_token = "web-efs"
  tags = {
    Name = "${local.prefix}-web-efs"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.this.id
  security_groups = [aws_security_group.sg-web.id]
  ip_address      = "10.0.1.254"
}

resource "aws_efs_access_point" "access-point" {
  file_system_id = aws_efs_file_system.efs.id

  root_directory {
    path = "/"
  }
}
