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
    default     = "asset-roks-gen2"
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
}

variable resource_group {
    description = "Name of resource group to create VPC"
    type        = string
    default     = "asset-development"
}

variable generation {
  description = "generation for VPC. Can be 1 or 2"
  #type        = number
  default     = 2
}

variable enable_public_gateway {
  description = "Enable public gateways for subnets, true or false"
  #type        = bool
  default     = true
}

variable acl_rules {
  description = "Access control list rule set"
  default     = [
    {
      name        = "egress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    },
    {
      name        = "ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    }
  ]
}  

##############################################################################


##############################################################################
# Cluster Variables
##############################################################################

variable machine_type {
    description = "The flavor of VPC worker node to use for your cluster"
    type        = string
    default     = "bx2.4x16"
}

variable workers_per_zone {
    description = "Number of workers to provision in each subnet. Openshift worker pool size must be 2 or greater."
    type        = number
    default     = 2
}

variable disable_public_service_endpoint {
    description = "Disable public service endpoint for cluster"
    type        = bool
    default     = false
}

variable entitlement {
    description = "If you purchased an IBM Cloud Cloud Pak that includes an entitlement to run worker nodes that are installed with OpenShift Container Platform, enter entitlement to create your cluster with that entitlement so that you are not charged twice for the OpenShift license. Note that this option can be set only when you create the cluster. After the cluster is created, the cost for the OpenShift license occurred and you cannot disable this charge."
    type        = string
    default     = "cloud_pak"
}

variable kube_version {
    description = "Specify the Kubernetes version, including the major.minor version. To see available versions, run ibmcloud ks versions. To use the default, leave string empty"
    type        = string
    default     = "4.3.23_openshift"
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
    description = "List of maps describing worker pools. Worker pools must have at least 2 workers per zone"
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
    #        resource_group   = "default"
    #    },
    #    {
    #        pool_name        = "prod"
    #        machine_type     = "c2.2x4"
    #        workers_per_zone = 2
    #    }
    #]
}

##############################################################################