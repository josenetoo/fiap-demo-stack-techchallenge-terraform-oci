output "vcn_id" {
  description = "OCID da VCN criada"
  value       = module.vcn.vcn_id
}

output "subnet_id" {
  description = "OCID da subnet pública"
  value       = oci_core_subnet.public.id
}

output "instance_ids" {
  description = "OCIDs das instâncias criadas"
  value       = module.compute.instance_id
}

output "instance_public_ips" {
  description = "IPs públicos das instâncias"
  value       = module.compute.public_ip
}

# -----------------------------------------------------
# DATABASE - MySQL Database Service
# -----------------------------------------------------
# Descomentar quando descomentar database.tf
# output "mysql_auth_id" {
#   description = "OCID do MySQL Database - Auth"
#   value       = oci_mysql_mysql_db_system.auth.id
# }

# output "mysql_auth_endpoint" {
#   description = "Endpoint do MySQL Database - Auth"
#   value       = oci_mysql_mysql_db_system.auth.endpoints[0].hostname
#   sensitive   = true
# }

# output "mysql_flag_id" {
#   description = "OCID do MySQL Database - Flag"
#   value       = oci_mysql_mysql_db_system.flag.id
# }

# output "mysql_flag_endpoint" {
#   description = "Endpoint do MySQL Database - Flag"
#   value       = oci_mysql_mysql_db_system.flag.endpoints[0].hostname
#   sensitive   = true
# }

# output "mysql_targeting_id" {
#   description = "OCID do MySQL Database - Targeting"
#   value       = oci_mysql_mysql_db_system.targeting.id
# }

# output "mysql_targeting_endpoint" {
#   description = "Endpoint do MySQL Database - Targeting"
#   value       = oci_mysql_mysql_db_system.targeting.endpoints[0].hostname
#   sensitive   = true
# }

# output "mysql_databases" {
#   description = "Mapa com todos os endpoints MySQL"
#   value = {
#     auth      = oci_mysql_mysql_db_system.auth.endpoints[0].hostname
#     flag      = oci_mysql_mysql_db_system.flag.endpoints[0].hostname
#     targeting = oci_mysql_mysql_db_system.targeting.endpoints[0].hostname
#   }
#   sensitive = true
# }

# -----------------------------------------------------
# CACHE - Redis
# -----------------------------------------------------
# Descomentar quando descomentar cache.tf
# output "redis_cluster_id" {
#   description = "OCID do Redis Cluster"
#   value       = oci_redis_redis_cluster.main.id
# }

# output "redis_endpoint" {
#   description = "Endpoint do Redis Cluster"
#   value       = oci_redis_redis_cluster.main.primary_endpoint_ip_address
#   sensitive   = true
# }

# output "redis_port" {
#   description = "Porta do Redis"
#   value       = 6379
# }



# # -----------------------------------------------------
# # NETWORKING
# # -----------------------------------------------------
# output "vcn_id_new" {
#   description = "OCID da VCN"
#   value       = oci_core_vcn.oke.id
# }

# output "subnet_api_id" {
#   description = "OCID da subnet pública - API Endpoint"
#   value       = oci_core_subnet.oke_api.id
# }

# output "subnet_lb_id" {
#   description = "OCID da subnet pública - Load Balancer"
#   value       = oci_core_subnet.oke_lb.id
# }

# output "subnet_workers_id" {
#   description = "OCID da subnet privada - Workers"
#   value       = oci_core_subnet.oke_workers.id
# }

# output "subnet_pods_id" {
#   description = "OCID da subnet privada - Pods"
#   value       = oci_core_subnet.oke_pods.id
# }

# output "subnet_db_id" {
#   description = "OCID da subnet privada - Databases"
#   value       = oci_core_subnet.oke_db.id
# }

# -----------------------------------------------------
# OKE - Oracle Kubernetes Engine
# -----------------------------------------------------
# output "oke_cluster_id" {
#   description = "OCID do cluster OKE"
#   value       = oci_containerengine_cluster.main.id
# }

# output "oke_cluster_endpoint" {
#   description = "Endpoint do cluster OKE"
#   value       = oci_containerengine_cluster.main.endpoints[0].kubernetes
# }

# output "oke_kubeconfig_command" {
#   description = "Comando para obter kubeconfig"
#   value       = "oci ce cluster create-kubeconfig --cluster-id ${oci_containerengine_cluster.main.id} --file $HOME/.kube/config --region ${var.region} --token-version 2.0.0"
# }

# # -----------------------------------------------------
# # REDIS
# # -----------------------------------------------------
# output "redis_endpoint" {
#   description = "Endpoint do Redis cluster"
#   value       = oci_redis_redis_cluster.main.primary_endpoint
# }

# output "redis_port" {
#   description = "Porta do Redis"
#   value       = oci_redis_redis_cluster.main.primary_endpoint_port
# }

# # -----------------------------------------------------
# # NOSQL (DynamoDB equivalent)
# # -----------------------------------------------------
# output "nosql_table_id" {
#   description = "OCID da tabela NoSQL"
#   value       = oci_nosql_table.toggle_master_analytics.id
# }

# output "nosql_table_name" {
#   description = "Nome da tabela NoSQL"
#   value       = oci_nosql_table.toggle_master_analytics.name
# }

# # -----------------------------------------------------
# # QUEUE (SQS equivalent)
# # -----------------------------------------------------
# output "queue_id" {
#   description = "OCID da fila principal"
#   value       = oci_queue_queue.main.id
# }

# output "queue_endpoint" {
#   description = "Endpoint da fila"
#   value       = oci_queue_queue.main.messages_endpoint
# }

# output "queue_dlq_id" {
#   description = "OCID da Dead Letter Queue"
#   value       = oci_queue_queue.dlq.id
# }

# # -----------------------------------------------------
# # REGISTRY (ECR equivalent)
# # -----------------------------------------------------
# output "ocir_repositories" {
#   description = "URLs dos repositórios OCIR"
#   value = {
#     api_gateway          = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${oci_artifacts_container_repository.api_gateway.display_name}"
#     user_service         = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${oci_artifacts_container_repository.user_service.display_name}"
#     order_service        = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${oci_artifacts_container_repository.order_service.display_name}"
#     payment_service      = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${oci_artifacts_container_repository.payment_service.display_name}"
#     notification_service = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${oci_artifacts_container_repository.notification_service.display_name}"
#   }
# }

# # -----------------------------------------------------
# # Data Source para namespace do Object Storage
# # -----------------------------------------------------
# data "oci_objectstorage_namespace" "ns" {
#   compartment_id = var.compartment_id
# }
