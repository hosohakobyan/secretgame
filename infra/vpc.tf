resource "aws_vpc" "heimlich_stage" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.env
  }
}

resource "aws_internet_gateway" "heimlich_stage_igw" {
  vpc_id = aws_vpc.heimlich_stage.id

  tags = {
    Name = "${var.env}_igw"
  }
}

resource "aws_subnet" "heimlich_stage_public_a" {
  vpc_id                  = aws_vpc.heimlich_stage.id
  cidr_block              = var.public_cidr_a
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_a

  tags = {
    Name = "${var.env}_public_a"
  }
}

resource "aws_subnet" "heimlich_stage_public_b" {
  vpc_id                  = aws_vpc.heimlich_stage.id
  cidr_block              = var.public_cidr_b
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_b

  tags = {
    Name = "${var.env}_public_b"
  }
}


resource "aws_route_table" "rout_table_heimlich_stage" {
  vpc_id = aws_vpc.heimlich_stage.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.heimlich_stage_igw.id
  }


  tags = {
    Name = "${var.env}_route"
  }
}

resource "aws_route_table_association" "route-public_a" {
  subnet_id      = aws_subnet.heimlich_stage_public_a.id
  route_table_id = aws_route_table.rout_table_heimlich_stage.id

}

resource "aws_route_table_association" "route-public_b" {
  subnet_id      = aws_subnet.heimlich_stage_public_b.id
  route_table_id = aws_route_table.rout_table_heimlich_stage.id

}

#============================private subnet=====================
resource "aws_eip" "heimlich_stage-eip" {
  vpc = true

}

resource "aws_nat_gateway" "heimlich_stage_nat" {
  subnet_id     = aws_subnet.heimlich_stage_public_a.id
  allocation_id = aws_eip.heimlich_stage-eip.id

  tags = {
    Name = "${var.env}_gw_nat"
  }

  depends_on = [aws_internet_gateway.heimlich_stage_igw]

}

resource "aws_subnet" "heimlich_stage_private_a" {
  vpc_id            = aws_vpc.heimlich_stage.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.availability_zone_private-a

  tags = {
    Name = "${var.env}_private_a"
  }

}

resource "aws_subnet" "heimlich_stage_private_b" {
  vpc_id            = aws_vpc.heimlich_stage.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.availability_zone_private-b

  tags = {
    Name = "${var.env}_private_b"
  }

}

resource "aws_route_table" "rout_heimlich_stage_private" {
  vpc_id = aws_vpc.heimlich_stage.id

  route {
    cidr_block = var.route_cidr_private
    gateway_id = aws_nat_gateway.heimlich_stage_nat.id

  }


  tags = {
    Name = "${var.env}_route_private"
  }
}

resource "aws_route_table_association" "route_heimlich_stage_private_a" {
  subnet_id      = aws_subnet.heimlich_stage_private_a.id
  route_table_id = aws_route_table.rout_heimlich_stage_private.id

}

resource "aws_route_table_association" "route_heimlich_stage_private_b" {
  subnet_id      = aws_subnet.heimlich_stage_private_b.id
  route_table_id = aws_route_table.rout_heimlich_stage_private.id

}


resource "aws_db_subnet_group" "heimlich_stage_db_subnet" {
  name = "${var.env}-db-subnet-group"

  subnet_ids = [
    "${aws_subnet.heimlich_stage_private_a.id}",
    "${aws_subnet.heimlich_stage_private_b.id}"
  ]

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}