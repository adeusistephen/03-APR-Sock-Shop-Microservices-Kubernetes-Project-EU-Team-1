#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "${file(keypair)}" >> /home/ubuntu/PACUJPEU1-key
sudo chmod 400 /home/ubuntu/PACUJPEU1-key
sudo chown ubuntu:ubuntu /home/ubuntu/PACUJPEU1-key
sudo hostnamectl set-hostname Bastion