provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-007020fd9c84e18c7"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name      = "jobApplicationDockerized_StableBuild"  # Key pair name
  tags = {
    Name = "jobApplicationDockerized-StableBuild"
  }

  # Associate the security group with the EC2 instance
  security_groups = [aws_security_group.ec2_sg.name]

  # Provisioner to execute commands on the EC2 instance after creation
  provisioner "remote-exec" {
    inline = [
      "echo 'Starting provisioning'",
      "sudo apt-get update",
      "echo 'Finished apt-get update'",
      "sudo apt-get install -y ca-certificates curl",
      "echo 'Finished installing ca-certificates and curl'",
      "sudo apt-get install -y apt-transport-https software-properties-common",
      "echo 'Finished installing apt-transport-https and software-properties-common'",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "echo 'Finished adding Docker GPG key'",
      "sudo add-apt-repository -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable'",
      "echo 'Finished adding Docker repository'",
      "sudo apt-get update",
      "echo 'Finished apt-get update after adding Docker repository'",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "echo 'Finished installing Docker'",
      "sudo apt-get install -y docker-compose",
      "echo 'Finished installing Docker Compose'",
      "sudo apt-get install -y git",
      "echo 'Finished installing Git'",
      "git clone https://github.com/puneetjoshi58/Job-Portal.git",
      "echo 'Finished cloning repository'",
      "cd Job-Portal",
      "echo 'Navigated into Job-Portal directory'",
      "sudo docker build -t joblisting-application:1.0 .",
      "echo 'Image sucessfully built'",
      "sudo docker-compose up -d",  
      "echo 'Started docker-compose services'"
    ]
  
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/Admin/Desktop/Projects/SpringBoot/joblisting/jobApplicationDockerized_StableBuild.pem")  # Path to your private key
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Security group for EC2 instance"
  
  # Allow SSH traffic from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTPS traffic from the internet
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTP traffic from the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming and outgoing traffic on port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming and outgoing traffic on port 27017
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "execution_logs" {
  value = aws_instance.ec2_instance.public_dns
}
