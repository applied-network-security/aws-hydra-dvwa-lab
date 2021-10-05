#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
#!/bin/bash
sudo yum update -y
sudo yum install -y amazon-linux-extras docker
sudo docker run -t -i kalilinux/kali-rolling
sudo service docker start

sudo systemctl start docker
sudo systemctl enable docker
#Install nmap
sudo yum install nmap -y


#Install masscan
sudo yum install git make gcc -y
git clone https://github.com/robertdavidgraham/masscan
cd masscan
sudo make
sudo make install


#Install hydra

git clone https://github.com/vanhauser-thc/thc-hydra
cd thc-hydra
 ./configure
make
sudo make install 


wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
