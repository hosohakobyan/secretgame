resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.env
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}_igw"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr_a
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_a

  tags = {
    Name = "${var.env}_public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr_b
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_b

  tags = {
    Name = "${var.env}_public_b"
  }
}


resource "aws_route_table" "rout_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.internet_gateway.id
  }


  tags = {
    Name = "${var.env}_route"
  }
}

resource "aws_route_table_association" "route-public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rout_table.id

}

resource "aws_route_table_association" "route-public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rout_table.id

}

#============================private subnet=====================
resource "aws_eip" "eip" {
  vpc = true

}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "${var.env}_gw_nat"
  }

  depends_on = [aws_internet_gateway.internet_gateway]

}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.availability_zone_private-a

  tags = {
    Name = "${var.env}_private_a"
  }

}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.availability_zone_private-b

  tags = {
    Name = "${var.env}_private_b"
  }

}

resource "aws_route_table" "rout_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_cidr_private
    gateway_id = aws_nat_gateway.nat.id

  }


  tags = {
    Name = "${var.env}_route_private"
  }
}

resource "aws_route_table_association" "route_private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rout_private.id

}

resource "aws_route_table_association" "route_private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rout_private.id

}


resource "aws_db_subnet_group" "db_subnet" {
  name = "${var.env}-db-subnet-group"

  subnet_ids = [
    "${aws_subnet.private_a.id}",
    "${aws_subnet.private_b.id}"
  ]

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}