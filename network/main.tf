# --- Networking/main.tf ---

data "aws_availability_zones" "availability" {
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.availability.names
  result_count = var.max_subnets
}

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "myinfra_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "myinfra_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_subnet" "myinfra_public_subnet" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.myinfra_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "myinfra_public_${count.index + 1}"
  }
}

resource "aws_subnet" "myinfra_private_subnet" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.myinfra_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "myinfra_private_${count.index + 1}"
  }
}

resource "aws_route_table_association" "myinfra_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.myinfra_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.myinfra_public_rt.id
}


resource "aws_internet_gateway" "myinfra_internet_gateway" {
  vpc_id = aws_vpc.myinfra_vpc.id

  tags = {
    Name = "myinfra_igw"
  }
}


resource "aws_route_table" "myinfra_public_rt" {
  vpc_id = aws_vpc.myinfra_vpc.id
  tags = {
    Name = "myinfra_public"
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.myinfra_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myinfra_internet_gateway.id

}

resource "aws_default_route_table" "myinfra_private_rt" {
  default_route_table_id = aws_vpc.myinfra_vpc.default_route_table_id
  

  tags = {
    Name = "myinfra_private"
  }
}

resource "aws_security_group" "myinfra_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.myinfra_vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {

      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myinfra-sg"
  }
}

