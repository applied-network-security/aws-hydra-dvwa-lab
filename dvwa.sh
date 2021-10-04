#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
#!/bin/bash
sudo yum update -y
sudo yum install -y amazon-linux-extras docker
sudo service docker start
sudo docker pull vulnerables/web-dvwa
sudo docker run -d -p 80:80 vulnerables/web-dvwa


wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt