# # ============================================================
# # CACHE - OCI Cache with Redis
# # ============================================================
# # Equivalente AWS: ElastiCache Redis
# # OCI oferece Redis gerenciado através do OCI Cache

# # -----------------------------------------------------
# # Redis Cluster - Cache Principal
# # -----------------------------------------------------
# resource "oci_redis_redis_cluster" "main" {
#   compartment_id = var.compartment_id
#   display_name   = "${var.project_name}-redis-cache"

#   # Node Configuration
#   node_count            = var.redis_node_count
#   software_version      = var.redis_version
#   node_memory_in_gbs    = var.redis_memory_gb

#   # Subnet (pública para facilitar acesso - em prod usar privada)
#   subnet_id = oci_core_subnet.public.id

#   # Cluster Mode
#   #cluster_mode = "DISABLED" # Modo standalone (equivalente ao ElastiCache single node)

#   freeform_tags = {
#     "Environment" = var.environment
#     "Project"     = var.project_name
#     "Service"     = "cache"
#     "Type"        = "redis"
#   }
# }

# # -----------------------------------------------------
# # Outputs do Redis
# # -----------------------------------------------------
# # Nota: Os endpoints são exportados em outputs.tf
