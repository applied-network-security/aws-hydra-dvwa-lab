locals {
  vpc_cidr = "10.200.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }

      }
    }
    bastion = {
      name        = "bastion_sg"
      description = "Security group for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip, var.cloud9_ip, local.vpc_cidr]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = [var.access_ip, var.cloud9_ip, local.vpc_cidr]
        }

      }
    }
    dvwa = {
      name        = "dvwa_sg"
      description = "Security group for public access"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip, var.cloud9_ip, local.vpc_cidr]
        }
        icmp = {
          from        = 0
          to          = 0
          protocol    = "-1"
          cidr_blocks = [var.access_ip, var.cloud9_ip, local.vpc_cidr]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = [var.access_ip, var.cloud9_ip, local.vpc_cidr]
        }
      }
    }
  }
}