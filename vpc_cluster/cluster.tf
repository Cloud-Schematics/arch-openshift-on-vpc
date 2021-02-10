##############################################################################
# COS Instance
##############################################################################

resource ibm_resource_instance cos {
  name              = "${var.cluster_name}-cos"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = var.resource_group_id != "" ? var.resource_group_id : null

  parameters = {
    service-endpoints = "private"
  }

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }

}

##############################################################################

##############################################################################


##############################################################################
# Create IKS on VPC Cluster
##############################################################################

resource ibm_container_vpc_cluster cluster {

  name              = var.cluster_name
  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  flavor            = var.machine_type
  entitlement       = var.entitlement
  worker_count      = var.workers_per_zone
  kube_version      = var.kube_version != "" ? var.kube_version : null
  tags              = var.tags
  wait_till         = "IngressReady" #var.wait_till

  dynamic zones {
    for_each = var.subnets
    content {
      subnet_id = zones.value.id
      name      = zones.value.zone
    }
  }
  cos_instance_crn                = ibm_resource_instance.cos.id
  disable_public_service_endpoint = var.disable_public_service_endpoint
}

##############################################################################


##############################################################################
# Worker Pools
##############################################################################

module worker_pools {
  source            = "./worker_pools"
  ibm_region        = var.ibm_region
  pool_list         = var.worker_pools
  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  subnets           = var.subnets
}

##############################################################################