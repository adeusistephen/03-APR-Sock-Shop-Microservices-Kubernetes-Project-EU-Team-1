#create vpc
resource "aws_vpc" "PACUJPEU1-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    name = "${var.project_name}-vpc"
  }
}
#create Public subnets 01
resource "aws_subnet" "PACUJPEU1-PubSub01" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  cidr_block =var.PubSub01_cidr
  availability_zone =var.az1
 tags = {
    Name =  "${var.project_name}-PubSub01"
  }
}
#create Public subnets 02
resource "aws_subnet" "PACUJPEU1-PubSub02" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  cidr_block = var.PubSub02_cidr
  availability_zone = var.az2
 tags = {
    Name =  "${var.project_name}-PubSub02"
  }
}

#create Private subnet 01
resource "aws_subnet" "PACUJPEU1-PrvtSub01" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  cidr_block =var.PrvtSub01_cidr
  availability_zone = var.az1
 tags = {
    Name =  "${var.project_name}-PrvtSub01"
  }
}

#create Private subnet 02
resource "aws_subnet" "PACUJPEU1-PrvtSub02" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  cidr_block =var.PrvtSub02_cidr
  availability_zone = var.az2
 tags = {
    Name = "${var.project_name}-PrvtSub02"
  }
}

#Create the Internet Gateway
resource "aws_internet_gateway" "PACUJPEU1-IGW" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  tags = {
    Name = "${var.project_name}-IGW"
  }
}

# create the NAT Gateway
resource "aws_nat_gateway" "PACUJPEU1-NAT" {
  allocation_id = aws_eip.PACUJPEU1-Eip.id
  subnet_id = aws_subnet.PACUJPEU1-PubSub02.id
  tags = {
    Name = "${var.project_name}-NAT"
  }
}

#Create Elastic IP
resource "aws_eip" "PACUJPEU1-Eip" {
  vpc = true
  depends_on = [aws_internet_gateway.PACUJPEU1-IGW]
  tags = {
    Name = "${var.project_name}-eip_name"
  }
}

#create public route table
resource "aws_route_table" "PACUJPEU1-PubRT" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id
  route {
    cidr_block = var.all-cidr
    gateway_id = aws_internet_gateway.PACUJPEU1-IGW.id
  }
  tags = {
    Name ="${var.project_name}-PubRT"
  }
}

#create private route table
resource "aws_route_table" "PACUJPEU1-PrvtRT" {
  vpc_id = aws_vpc.PACUJPEU1-vpc.id

  route {
    cidr_block = var.all-cidr
    gateway_id = aws_nat_gateway.PACUJPEU1-NAT.id
  }

  tags = {
    Name = "${var.project_name}-PrvtRT"
  }
}

#create route table public_subnet_1_association
resource "aws_route_table_association" "PACUJPEU1-PubSub01-asst" {
  route_table_id = aws_route_table.PACUJPEU1-PubRT.id
  subnet_id = aws_subnet.PACUJPEU1-PubSub01.id
}

#create route table public_subnet_2_association
resource "aws_route_table_association" "PACUJPEU1-PubSub02-asst" {
  route_table_id = aws_route_table.PACUJPEU1-PubRT.id
  subnet_id = aws_subnet.PACUJPEU1-PubSub02.id
}

#create private_subnet_1_association
resource "aws_route_table_association" "PACUJPEU1-PrvtSub01-asst" {
  route_table_id = aws_route_table.PACUJPEU1-PrvtRT.id
  subnet_id = aws_subnet.PACUJPEU1-PrvtSub01.id
}

#create private_subnet_2_association
resource "aws_route_table_association" "PACUJPEU1-PrvtSub02-asst" {
  route_table_id = aws_route_table.PACUJPEU1-PrvtRT.id
  subnet_id = aws_subnet.PACUJPEU1-PrvtSub02.id
}
