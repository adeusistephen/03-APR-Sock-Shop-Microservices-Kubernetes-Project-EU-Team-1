output "vpc_id" {
  value = aws_vpc.PACUJPEU1-vpc.id
}
output "PubSub01" {
  value = aws_subnet.PACUJPEU1-PubSub01.id
}
output "PubSub02" {
  value = aws_subnet.PACUJPEU1-PubSub02.id
}
output "PrvtSub01" {
  value = aws_subnet.PACUJPEU1-PrvtSub01.id
}
output "PrvtSub02" {
  value = aws_subnet.PACUJPEU1-PrvtSub02.id
}