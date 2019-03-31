module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.NAME}"
  cidr = "${var.CIDR_VPC}"

  azs             = "${var.AZS}"
  private_subnets = "${var.PRIVATE_SUBNETS}"
  public_subnets  = "${var.PUBLIC_SUBNETS}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_route53_zone" "public" {
  name          = "${var.NAME}"
  force_destroy = true

  tags {
    Name        = "${var.NAME}-${var.ENVIRONMENT}-zone-public"
    Infra       = "${var.NAME}"
    Environment = "${var.ENVIRONMENT}"
    Terraformed = "true"
  }
}

resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.NAME}-state"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.NAME}-${var.ENVIRONMENT}-state-store"
    Infra       = "${var.NAME}"
    Environment = "${var.ENVIRONMENT}"
    Terraformed = "true"
  }
}