resource "aws_security_group" "main" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 27017 #mongodb port number
    to_port     = 27017
    protocol    = "TCP"
    cidr_blocks = var.server_app_port_sg_cidr
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.component}-${var.env}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.component}-${var.env}-subnet-group"
  }
}

resource "aws_elasticache_parameter_group" "main" {
  name   = "${var.component}-${var.env}-pg"
  family = var.family
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "${var.component}-${var.env}"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.main.name
  engine_version       = var.engine_version
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids   = [aws_security_group.main.id]
}
