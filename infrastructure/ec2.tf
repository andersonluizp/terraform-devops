
resource "aws_key_pair" "this" {
  key_name   = "${local.prefix}-key"
  public_key = var.aws_public_key
}

resource "aws_instance" "this" {
  ami                         = var.aws_ami
  instance_type               = var.aws_instance_type
  count                       = 1
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.sg-web.id]
  subnet_id              = aws_subnet.this.id
  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-site"
    }
  )

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo apt update",
  #      "sudo apt install nginx -y",
  #    ]
  #
  #    connection {
  #      type        = "ssh"
  #      user        = "ubuntu"
  #      private_key = file("~/.ssh/id_rsa")
  #      host        = self.public_ip
  #    }
  #
  #  }

  user_data_base64 = "IyEvYmluL2Jhc2gKc3VkbyBhcHQgdXBkYXRlCnN1ZG8gYXB0IGluc3RhbGwgbmdpbnggLXk="

}
