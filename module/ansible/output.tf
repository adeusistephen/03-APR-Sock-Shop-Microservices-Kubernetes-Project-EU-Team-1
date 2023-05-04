output "ansible_IP" {
  value       = aws_instance.PACUJPEU1_ansible.private_ip
  description = "Ansible Private IP"
}

