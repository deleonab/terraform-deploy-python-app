data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "existing_key_pair" {
  key_name = "my-ec2-keypair"  # Replace with the name of your existing key pair
}

resource "aws_instance" "website" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [ aws_security_group.my_instance_SG.id ]
  key_name = data.aws_key_pair.existing_key_pair.key_name  # Use the existing key pair name
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install docker.io -y
              git clone https://github.com/deleonab/terraform-deploy-python-app.git 
              sudo docker build -t myflaskappv1 .
              sudo docker run -p 5000:5000 myflaskappv1
              EOF

            

  tags = {
    Name = "my-python-app"
  }
}