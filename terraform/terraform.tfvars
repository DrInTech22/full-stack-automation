aws_region     = "us-east-1"
ami_id         = "ami-005fc0f236362e99f" # Replace with a valid AMI ID
instance_type  = "t3.medium"
key_pair_name  = "hello"
private_key_path = "../../hello.pem" # relative path to terraform folder

frontend_domain = "cv1.drintech.online"
db_domain       = "db.cv1.drintech.online"
traefik_domain  = "traefik.cv1.drintech.online"
cert_email      = "admin@example.com" # replace with a valid email