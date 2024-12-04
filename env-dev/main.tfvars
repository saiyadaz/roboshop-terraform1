env               = "dev"
instance_type     = "t3.small"
ssh_user          = "ec2-user"
ssh_pass          = "DevOps321"
zone_id           = "Z0599937U1I5C34JZJE7"
####

#VPC
vpc_cidr_block         =  "10.10.0.0/24"
default_vpc_cidr       =  "172.31.0.0/16"
default_vpc_id         =  "vpc-08dfc22eeac63dea1"
default_route_table_id =  "rtb-0fed07462201fd7db"

#EXPENSE
frontend_subnets       =  [ "10.10.0.0/27","10.10.0.32/27" ]
backend_subnets        =  [ "10.10.0.64/27","10.10.0.96/27" ]
db_subnets             =  [ "10.10.0.128/27","10.10.0.160/27" ]
public_subnets         =  [ "10.10.0.192/27","10.10.0.224/27" ]
availability_zones     =  ["us-east-1a", "us-east-1b"]
bastion_nodes          =  ["172.31.29.47/32"]
prometheus_nodes       =  ["172.31.25.180/32"]
certificate_arn        =  "arn:aws:acm:us-east-1:058264231458:certificate/9b01328b-ca8e-488b-8a34-b7c094ee7eaa"
kms_key_id             = "arn:aws:kms:us-east-1:058264231458:key/f2b19fa5-3dac-4a66-bc32-3f25a5cf271e"


#ASG
max_capacity = 5
min_capacity = 1

#doc db
docdb={
  main = {
      family         = "docdb4.0"
      instance_class ="db.t3.medium"
      instance_count = 1
      engine_version = 4.0.0
}
}
#rds
rds ={
  main ={
  allocated_storage       = 20
  engine_version          = "5.7.44"
  family                  = "mysql5.7"
  instance_class          = "db.t3.micro"
  skip_final_snapshot     = true
  storage_type            = "gp3"

}
}
rabbitmq = {
  main = {
    component     = "rabbitmq"
    instance_type = "t3.small"
  }
}

elasticache = {
  main = {
    engine_version          = "6.2"
    family                  = "redis6.x"
    node_type               = "cache.t4g.micro"
  }
}