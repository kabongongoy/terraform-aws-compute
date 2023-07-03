# .--------------------- Compute\main .------------------------------

resource "random_id" "kab_ec2-random-id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}


data "aws_ami" "ec2-ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


#______________________________Keypair_________________________________

resource "aws_key_pair" "kab-ec2-key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}
 


resource "aws_instance" "kab-node" {
  count                  = var.instance_count # 1
  ami                    = data.aws_ami.ec2-ami.id
  instance_type          = var.instance_type # "t3.micro"
  key_name               = aws_key_pair.kab-ec2-key.id

  root_block_device {
    volume_size = var.volume_size # 10
  }
  tags = {
    Name = "kab-node-${random_id.kab_ec2-random-id[count.index].dec}"
  }

}