output "Bast_Ans_SG" {
  value = aws_security_group.PACUJPEU1-Bastion-Ansible-SG.id
}
output "jenkins_SG" {
  value = aws_security_group.PACUJPEU1-Jenkins-SG.id
}
output "mas_work_sg" {
  value = aws_security_group.PACUJPEU1_mas_work_sg.id
}

