bucket_name          = "remote-backend"
vpc_name             = "vpc"
vpc_cidr             = "11.0.0.0/16"
cidr_public          = ["11.0.1.0/24", "11.0.2.0/24"]
cidr_private         = ["11.0.3.0/24", "11.0.4.0/24"]
us_availibility_zone = ["us-east-1a", "us-east-1b"]
pub_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDALU6VGpw3aV1Fj/fa2Ev4NcBfGDqIpedCucm3P/Lrfv6tee8IfAOgyDpuF3glvL1jbCuqrWzNPK4tu71u5xItIn4kRCZ+9+vMSKXFZd4lgq/VyZUX0u15BKpgEvMkOiVUPKvnaX6Cb+p2QldU/XsenR1w7SHyuicNgoGvGDmYhO/19qo5yYZGeMbK0yNGHUv7fuGSRvhabLTsT+1DH2UvcAnA7bW8AZBSsL0FWEVMFNY66eWAjEFip0lHclPRhYdmIIO9io/tGRDYf2xhrwM9qzPdPq+xrOnzUaGCLk8+GRlol6ghRnKWZBzcC0T6jYksgOT75twBAr3rGcb4YnwqhzT9EoXG0B53ucRrL+Yd8Hsrt+Hb/QJDsKm2XvLo2HKgrYVap/gmzKQpKJUHs8eHgTbuPxsTqnHU826MVIbCYz7o74siUQW/NNU6pH0EVoSLxZWXTFtKNfuYmXCkae8QeW72wLqaKf/1A/MJl5/67m+L49hjwR3X7tLATzXG4YE= abdul-sami@abdul-sami-098C110000404100000610180"
ec2_ami              = "ami-0694d931cee176e7d"