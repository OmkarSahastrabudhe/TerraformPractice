provider "aws" {

    region = "ap-south-1"
  
}
resource "aws_instance" "my-instance" {
  
     ami = "ami-019715e0d74f695be" 
     instance_type = "t3.small"
     vpc_security_group_ids =["sg-0e19d6b3c8971850e"] 
     key_name = "superkey" 
     tags = {
        Name = "my-instance"
        env = "practice"
     }    

     

     connection{
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file("/home/ubuntu/superkey.pem")

     } 

      provisioner "file"{
         source = "/home/ubuntu/my-static-website"
         destination = "/home/ubuntu/my-static-website"
     }

     provisioner "remote-exec"{
         
         inline =["sudo mv /home/ubuntu/my-static-website/  /var/www/html/","sudo apt update -y","sudo apt install apache2 -y",
         "sudo systemctl --now enable apache2"]
              

     }

    
  
}