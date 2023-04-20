resource "aws_vpc" "secretgame" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.env
  }
}

resource "aws_internet_gateway" "secretgame_igw" {
  vpc_id = aws_vpc.secretgame.id

  tags = {
    Name = "${var.env}_igw"
  }
}

resource "aws_subnet" "secretgame_public_a" {
  vpc_id                  = aws_vpc.secretgame.id
  cidr_block              = var.public_cidr_a
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_a

  tags = {
    Name = "${var.env}_public_a"
  }
}

resource "aws_subnet" "secretgame_public_b" {
  vpc_id                  = aws_vpc.secretgame.id
  cidr_block              = var.public_cidr_b
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_public_b

  tags = {
    Name = "${var.env}_public_b"
  }
}


resource "aws_route_table" "rout_table_secretgame" {
  vpc_id = aws_vpc.secretgame.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.secretgame_igw.id
  }


  tags = {
    Name = "${var.env}_route"
  }
}

resource "aws_route_table_association" "route-public_a" {
  subnet_id      = aws_subnet.secretgame_public_a.id
  route_table_id = aws_route_table.rout_table_secretgame.id

}

resource "aws_route_table_association" "route-public_b" {
  subnet_id      = aws_subnet.secretgame_public_b.id
  route_table_id = aws_route_table.rout_table_secretgame.id

}

#============================private subnet=====================
resource "aws_eip" "secretgame-eip" {
  vpc = true

}

resource "aws_nat_gateway" "secretgame_nat" {
  subnet_id     = aws_subnet.secretgame_public_a.id
  allocation_id = aws_eip.secretgame-eip.id

  tags = {
    Name = "${var.env}_gw_nat"
  }

  depends_on = [aws_internet_gateway.secretgame_igw]

}

resource "aws_subnet" "secretgame_private_a" {
  vpc_id            = aws_vpc.secretgame.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.availability_zone_private-a

  tags = {
    Name = "${var.env}_private_a"
  }

}

resource "aws_subnet" "secretgame_private_b" {
  vpc_id            = aws_vpc.secretgame.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.availability_zone_private-b

  tags = {
    Name = "${var.env}_private_b"
  }

}

resource "aws_route_table" "rout_secretgame_private" {
  vpc_id = aws_vpc.secretgame.id

  route {
    cidr_block = var.route_cidr_private
    gateway_id = aws_nat_gateway.secretgame_nat.id

  }


  tags = {
    Name = "${var.env}_route_private"
  }
}

resource "aws_route_table_association" "route_secretgame_private_a" {
  subnet_id      = aws_subnet.secretgame_private_a.id
  route_table_id = aws_route_table.rout_secretgame_private.id

}

resource "aws_route_table_association" "route_secretgame_private_b" {
  subnet_id      = aws_subnet.secretgame_private_b.id
  route_table_id = aws_route_table.rout_secretgame_private.id

}


resource "aws_db_subnet_group" "secretgame_db_subnet" {
  name = "${var.env}-db-subnet-group"

  subnet_ids = [
    "${aws_subnet.secretgame_private_a.id}",
    "${aws_subnet.secretgame_private_b.id}"
  ]

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}