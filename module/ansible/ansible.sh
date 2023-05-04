#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible python3-pip -y
sudo pip3 install boto3 boto botocore
sudo bash -c ' echo "strictHostKeyChecking No" >> /etc/ssh/ssh_config'
echo "${file(prv_key)}" >> /home/ubuntu/PACUJPEU1-key
sudo chmod 400 /home/ubuntu/PACUJPEU1-key
sudo chown ubuntu:ubuntu /home/ubuntu/PACUJPEU1-key 
sudo touch /etc/ansible/stage_hosts
sudo chown ubuntu:ubuntu /etc/ansible/stage_hosts
sudo chown -R ubuntu:ubuntu /etc/ansible && chmod +x /etc/ansible
sudo chmod 777 /etc/ansible/stage_hosts
sudo chmod 777 /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible
sudo hostnamectl set-hostname Ansible
sudo echo ha_prv_ip: "${HAproxy_IP}" >> /home/ubuntu/ha-ip.yml
sudo echo prod_Bckup_haIP: "${HAproxy_IP2}" >> /home/ubuntu/ha-ip.yml
sudo echo stage_ha_prv_ip: "${stage_HAproxy_IP}" >> /home/ubuntu/ha-ip.yml
sudo echo stage_Bckup_haIP: "${stage_HAproxy_IP2}" >> /home/ubuntu/ha-ip.yml
sudo echo "[HAProxy]" >> /etc/ansible/hosts
sudo echo "${HAproxy1_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts
sudo echo "[Prod-Bckupkeepalived]" >> /etc/ansible/hosts
sudo echo "${HAproxy_IP2} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts 
sudo echo "[main_master]" >> /etc/ansible/hosts
sudo echo "${master1_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts
sudo echo "[member_master]" >> /etc/ansible/hosts
sudo echo "${master2_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts
sudo echo "${master3_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts
sudo echo "[Worker]" >> /etc/ansible/hosts
sudo echo "${worker_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/hosts 
sudo echo "[stage_HAProxy]" >> /etc/ansible/stage_hosts
sudo echo "${stage_HAproxy_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo echo "[Stage-Bckupkeepalived]" >> /etc/ansible/stage_hosts
sudo echo "${stage_HAproxy_IP2} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo echo "[main_master]" >> /etc/ansible/stage_hosts
sudo echo "${stage_master1_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo echo "[member_master]" >> /etc/ansible/stage_hosts
sudo echo "${stage_master2_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo echo "${stage_master3_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo echo "[Worker]" >> /etc/ansible/stage_hosts
sudo echo "${stage_worker_IP} ansible_ssh_private_key_file=/home/ubuntu/PACUJPEU1-key" >> /etc/ansible/stage_hosts
sudo su -c "ansible-playbook /home/ubuntu/playbooks/installation.yml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/prod-keepalivd.yml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/main_master.yml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/member_master.yml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/worker.yml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/haproxy.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/installation.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/stage-keepalived.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/stage_main_master.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/stage_member_master.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/stage_worker.yml" ubuntu
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ubuntu/playbooks/stage_haproxy.yml" ubuntu