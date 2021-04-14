##############################################################################
# Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

variable unique_id {
    description = "A unique identifier need to provision resources. Must begin with a letter"
    type        = string
    default     = "asset-multizone"
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
}

variable resource_group {
    description = "Name of resource group where all infrastructure will be provisioned"
    type        = string
    default     = "asset-development"
}

variable generation {
  description = "generation for VPC. Can be 1 or 2"
  type        = number
  default     = 2
}

variable account_id {
  description = "ID of the account where your resources will be provisioned"
  type        = string
}

##############################################################################


##############################################################################
# Network variables
##############################################################################

variable classic_access {
  description = "Enable VPC Classic Access. Note: only one VPC per region can have classic access"
  type        = bool
  default     = false
}

variable enable_public_gateway {
  description = "Enable public gateways for subnets, true or false"
  type        = bool
  default     = false
}

variable cidr_blocks {
  description = "A list of tier subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.10.10.0/26",
    "10.10.20.0/26",
    "10.10.30.0/26"
  ] 
}

variable acl_rules {
  description = "Access control list rule set"
  default = [
    {
      name        = "egress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    },
    {
      name        = "ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    }
  ]
  
}

variable security_group_rules {
  description = "Map of security group rules to be added to default security group"
  default     = {
    allow_all_inbound = {
      source    = "0.0.0.0/0"
      direction = "inbound"
    }
  }
}

##############################################################################


##############################################################################
# Cluster Variables
##############################################################################

variable machine_type {
    description = "The flavor of IKS worker nodes to use for your cluster"
    type        = string
    default     = "bx2.4x16"
}

variable workers_per_zone {
    description = "Number of workers to provision in each subnet. For load balancing to work, worker pool size must be 2 or greater."
    type        = number
    default     = 2
}

variable disable_public_service_endpoint {
    description = "Disable public service endpoint for cluster"
    type        = bool
    default     = true
}

variable kube_version {
    description = "Specify the Kubernetes version, including the major and minor version. To see available versions, run ibmcloud ks versions. To use the default, leave string empty"
    type        = string
    default     = "4.5.35_openshift"
}

variable entitlement {
    description = "If you purchased an IBM Cloud Cloud Pak that includes an entitlement to run worker nodes that are installed with OpenShift Container Platform, enter entitlement to create your cluster with that entitlement so that you are not charged twice for the OpenShift license. Note that this option can be set only when you create the cluster. After the cluster is created, the cost for the OpenShift license occurred and you cannot disable this charge."
    type        = string
    default     = "cloud_pak"
}

variable wait_till {
    description = "To avoid long wait times when you run your Terraform code, you can specify the stage when you want Terraform to mark the cluster resource creation as completed. Depending on what stage you choose, the cluster creation might not be fully completed and continues to run in the background. However, your Terraform code can continue to run without waiting for the cluster to be fully created. Supported args are `MasterNodeReady`, `OneWorkerNodeReady`, and `IngressReady`"
    type        = string
    default     = "IngressReady"
}

variable tags {
    description = "A list of tags to add to the cluster"
    type        = list(string)
    default     = []
}

variable worker_pools {
    description = "List of maps describing worker pools"
    # type        = list(
    #     object({
    #         pool_name        = string
    #         machine_type     = string
    #         workers_per_zone = number
    #     })
    # )
    default     = []
    #    {
    #        pool_name        = "dev"
    #        machine_type     = "c2.2x4"
    #        workers_per_zone = 2
    #    },
    #    {
    #        pool_name        = "prod"
    #        machine_type     = "c2.2x4"
    #        workers_per_zone = 2
    #    }
    #]
}

##############################################################################


##############################################################################
# Resource Variables
##############################################################################

variable service_endpoints {
  description = "Service endpoints for resource instances. Can be `public`, `private`, or `public-and-private`"
  type        = string
  default     = "private"
}

variable kms_plan {
  description = "Plan for Key Protect"
  type        = string
  default     = "tiered-pricing"  
}

variable kms_root_key_name {
  description = "Name of the root key for Key Protect instance"
  type        = string
  default     = "root-key"
}

variable cos_plan {
  description = "Plan for Cloud Object Storage instance"
  type        = string
  default     = "standard"
}

variable logdna_plan {
  description = "Plan for Databases for PostgreSQL"
  type        = string
  default     = "7-day"
}

variable sysdig_plan {
  description = "Plan for Databases for PostgreSQL"
  type        = string
  default     = "graduated-tier"
}

##############################################################################