##############################################################################
# Resource Group where VPC will be created
##############################################################################

data ibm_resource_group resource_group {
  name = var.resource_group
}

##############################################################################


##############################################################################
# Create Multizone VPC
##############################################################################

module vpc {
  source                = "./multizone_vpc"

  # Account Variables
  unique_id             = var.unique_id
  ibm_region            = var.ibm_region
  resource_group_id     = data.ibm_resource_group.resource_group.id

  # Network Variables
  classic_access        = var.classic_access
  enable_public_gateway = var.enable_public_gateway
  cidr_blocks           = var.cidr_blocks
  acl_rules             = var.acl_rules
  security_group_rules  = var.security_group_rules
  
}

##############################################################################


##############################################################################
# Cluster
##############################################################################

module cluster {
  source              = "./vpc_cluster"

  # Account Variables
  ibm_region          = var.ibm_region
  resource_group_id   = data.ibm_resource_group.resource_group.id

  # VPC Variables
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.subnets

  # Cluster Variables
  cluster_name        = "${var.unique_id}-cluster"
  machine_type        = var.machine_type
  workers_per_zone    = var.workers_per_zone
  kube_version        = var.kube_version
  wait_till           = var.wait_till
  worker_pools        = var.worker_pools
  
}

##############################################################################