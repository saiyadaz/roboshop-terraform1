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

resource "aws_docdb_cluster_parameter_group" "main" {
  name = "${var.component}-${var.env}-subnet-group"
  family = var.family



}

resource "aws_docdb_subnet_group" "main" {
  name          = "${var.component}-${var.env}-subnet-group"
  subnet_ids    = var.subnet_ids

  tags = {
    Name = "${var.component}-${var.env}-subnet-group"
  }
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = "${var.env}-cluster"
  engine                          = "docdb"
  engine_version                  = var.engine_version
  master_username                 = jsondecode(data.vault_generic_secret.docdb.data_json).docdb_username
  master_password                 = jsondecode(data.vault_generic_secret.docdb.data_json).docdb_password
  backup_retention_period         = 5
  preferred_backup_window         = "14:12-12:14"
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.main.name
  db_subnet_group_name            = aws_docdb_subnet_group.main.name
  kms_key_id                      = var.kms_key_id
  storage_encrypted               = true
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count                        = var.instance_count
  identifier                   = "${var.env}-cluster${count.index}"
  cluster_identifier           = aws_docdb_cluster.main.id
  instance_class               = var.instance_class
}
