# resource "aws_key-pair" "ssh-key"
#   key_name = "ssh-key"
#   public_key = file("/Users/dionisiecaprosu/.ssh/id_25519.pub")



resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.ssh-key
}

