provider "aws" {
  region     = "ap-south-1a"
}

resource "null_resource" "run_docker_compose_up" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu" 
      private_key = file("C:/Users/Admin/Desktop/Projects/SpringBoot/joblisting/jobApplicationDockerized_StableBuild.pem") 
      host        = "ec2-13-233-19-62.ap-south-1.compute.amazonaws.com" 
    }

    inline = [
      "cd /home/ubuntu/Job-Portal",
      "sudo docker-compose down ",
      "sudo docker-compose up "

    ]
  }
}



