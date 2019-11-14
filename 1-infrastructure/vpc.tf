provider "aws" {
    region = "${var.region}"
}

terraform {
    backend "s3" {}
}

### VPC

resource "aws_vpc" "production-vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {Name="Production-VPC"}
}

### PUBLIC SUBNETS

resource "aws_subnet" "public-subnet-1" {
  cidr_block = "${var.public_subnet_1_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1a"
  tags = {Name="Public-Subnet-1"}
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block = "${var.public_subnet_2_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1b"
  tags = {Name="Public-Subnet-2"}
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block = "${var.public_subnet_3_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1c"
  tags = {Name="Public-Subnet-3"}
}

### PRIVATE SUBNETS

resource "aws_subnet" "private-subnet-1" {
  cidr_block = "${var.private_subnet_1_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1a"
  tags = {Name="Private-Subnet-1"}
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block = "${var.private_subnet_2_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1b"
  tags = {Name="Private-Subnet-2"}
}

resource "aws_subnet" "private-subnet-3" {
  cidr_block = "${var.private_subnet_3_cidr}"
  vpc_id = "${aws_vpc.production-vpc.id}"
  availability_zone = "us-east-1c"
  tags = {Name="Private-Subnet-3"}
}

### ROUTE TABLES

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  tags = {Name="Public Route Table"}
}

resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  tags = {Name="Private Route Table"}
}

### ROUTE TABLE ASSOCIATIONS - PUBLIC

resource "aws_route_table_association" "public-route-table-subnet-1-association" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
}

resource "aws_route_table_association" "public-route-table-subnet-2-association" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
}

resource "aws_route_table_association" "public-route-table-subnet-3-association" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id      = "${aws_subnet.public-subnet-3.id}"
}

### ROUTE TABLE ASSOCIATIONS - PRIVATE
resource "aws_route_table_association" "private-route-table-subnet-1-association" {
  route_table_id = "${aws_route_table.private-route-table-route-table.id}"
  subnet_id      = "${aws_subnet.private-subnet-1}"
}

resource "aws_route_table_association" "private-route-table-subnet-2-association" {
  route_table_id = "${aws_route_table.private-route-table-route-table.id}"
  subnet_id      = "${aws_subnet.private-subnet-2}"
}

resource "aws_route_table_association" "private-route-table-subnet-3-association" {
  route_table_id = "${aws_route_table.private-route-table-route-table.id}"
  subnet_id      = "${aws_subnet.private-subnet-3}"
}