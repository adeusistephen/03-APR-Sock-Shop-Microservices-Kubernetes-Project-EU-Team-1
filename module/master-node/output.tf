output "Master_Node_IP" {
    value = aws_instance.PACUJPEU1_master-node.*.private_ip
  
}