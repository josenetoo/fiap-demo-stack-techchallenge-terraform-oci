variable "tenancy_ocid" {
  description = "OCID do Tenancy OCI (opcional se usar ~/.oci/config)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "user_ocid" {
  description = "OCID do Usuário OCI (opcional se usar ~/.oci/config)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "fingerprint" {
  description = "Fingerprint da API Key (opcional se usar ~/.oci/config)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "region" {
  description = "Região OCI"
  type        = string
  default     = "us-ashburn-1"
}

variable "compartment_id" {
  description = "OCID do Compartment (use seu tenancy_ocid se não tiver compartment específico)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Ambiente (dev/staging/prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "O environment deve ser: dev, staging ou prod."
  }
}

variable "instance_count" {
  description = "Número de instâncias"
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 4
    error_message = "O instance_count deve ser entre 1 e 4 (Free Tier)."
  }
}

variable "vcn_cidr" {
  description = "CIDR block da VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block da subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_shape" {
  description = "Shape da instância (Free Tier: VM.Standard.E2.1.Micro)"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "instance_image_id" {
  description = "OCID da imagem Oracle Linux"
  type        = string
}

variable "ssh_public_key" {
  description = "Chave SSH pública (opcional)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ingress_ports" {
  description = "Portas TCP de ingress permitidas na security list"
  type        = list(number)
  default     = [22, 80, 3306, 6379] # SSH, HTTP, MySQL, Redis
}

# # ============================================================
# # DATABASE - MySQL Database Service (equivalente RDS)
# # ============================================================
# variable "mysql_shape" {
#   description = "Shape do MySQL Database System"
#   type        = string
#   default     = "MySQL.VM.Standard.E4.Flex"
# }

# variable "mysql_admin_username" {
#   description = "Username do admin MySQL"
#   type        = string
#   default     = "admin"
#   sensitive   = true
# }

# variable "mysql_admin_password" {
#   description = "Senha do admin MySQL (mínimo 8 caracteres)"
#   type        = string
#   sensitive   = true

#   validation {
#     condition     = length(var.mysql_admin_password) >= 8
#     error_message = "A senha do MySQL deve ter no mínimo 8 caracteres."
#   }
# }

# variable "mysql_storage_gb" {
#   description = "Storage em GB para cada MySQL Database"
#   type        = number
#   default     = 50

#   validation {
#     condition     = var.mysql_storage_gb >= 50 && var.mysql_storage_gb <= 65536
#     error_message = "O storage do MySQL deve ser entre 50 GB e 65536 GB."
#   }
# }

# ============================================================
# CACHE - Redis (equivalente ElastiCache)
# ============================================================
# variable "redis_node_count" {
#   description = "Número de nodes no cluster Redis"
#   type        = number
#   default     = 1

#   validation {
#     condition     = var.redis_node_count >= 1 && var.redis_node_count <= 5
#     error_message = "O número de nodes Redis deve ser entre 1 e 5."
#   }
# }

# variable "redis_version" {
#   description = "Versão do Redis"
#   type        = string
#   default     = "V7_0_5"
# }

# variable "redis_memory_gb" {
#   description = "Memória em GB por node Redis"
#   type        = number
#   default     = 2

#   validation {
#     condition     = var.redis_memory_gb >= 2 && var.redis_memory_gb <= 500
#     error_message = "A memória Redis deve ser entre 2 GB e 500 GB."
#   }
# }

# # -----------------------------------------------------
# # NETWORKING - VCN para OKE (separada da VCN do main.tf)
# # -----------------------------------------------------
# variable "oke_vcn_cidr" {
#   description = "CIDR da VCN dedicada para OKE"
#   type        = string
#   default     = "10.10.0.0/16"
# }

# # Subnet para API Endpoint do OKE (pública ou privada)
# variable "oke_subnet_api_cidr" {
#   description = "CIDR da subnet para OKE API Endpoint"
#   type        = string
#   default     = "10.10.0.0/28"
# }

# # Subnet para Worker Nodes (privada)
# variable "oke_subnet_workers_cidr" {
#   description = "CIDR da subnet para OKE Worker Nodes"
#   type        = string
#   default     = "10.10.10.0/24"
# }

# # Subnet para Load Balancers (pública)
# variable "oke_subnet_lb_cidr" {
#   description = "CIDR da subnet para Load Balancers"
#   type        = string
#   default     = "10.10.20.0/24"
# }

# # Subnet para Pods - VCN Native Pod Networking (privada, grande)
# variable "oke_subnet_pods_cidr" {
#   description = "CIDR da subnet para Pods (VCN Native IP)"
#   type        = string
#   default     = "10.10.128.0/18"
# }

# # Subnet para Databases e outros recursos (privada)
# variable "oke_subnet_db_cidr" {
#   description = "CIDR da subnet para Databases e outros recursos"
#   type        = string
#   default     = "10.10.30.0/24"
# }

# # -----------------------------------------------------
# # OKE - Oracle Kubernetes Engine
# # -----------------------------------------------------
# variable "oke_kubernetes_version" {
#   description = "Versão do Kubernetes para o OKE"
#   type        = string
#   default     = "v1.34.1"
# }

# variable "oke_node_shape" {
#   description = "Shape dos nodes do OKE"
#   type        = string
#   default     = "VM.Standard.E5.Flex"
# }

# variable "oke_node_ocpus" {
#   description = "Número de OCPUs por node"
#   type        = number
#   default     = 2
# }

# variable "oke_node_memory_gb" {
#   description = "Memória em GB por node"
#   type        = number
#   default     = 16
# }

# variable "oke_node_count" {
#   description = "Número de nodes no pool"
#   type        = number
#   default     = 2
# }

# variable "oke_node_image_id" {
#   description = "OCID da imagem para os nodes OKE"
#   type        = string
# }

# variable "oke_services_cidr" {
#   description = "CIDR para Kubernetes Services (ClusterIP)"
#   type        = string
#   default     = "10.96.0.0/16"
# }
# # Nota: oke_pods_cidr não é necessário com VCN Native Pod Networking
# # Os pods usam IPs da subnet oke_subnet_pods_cidr

# # -----------------------------------------------------
# # NOSQL - OCI NoSQL Database (equivalente DynamoDB)
# # -----------------------------------------------------
# variable "nosql_read_units" {
#   description = "Unidades de leitura máximas"
#   type        = number
#   default     = 50
# }

# variable "nosql_write_units" {
#   description = "Unidades de escrita máximas"
#   type        = number
#   default     = 50
# }

# variable "nosql_storage_gb" {
#   description = "Storage máximo em GB"
#   type        = number
#   default     = 25
# }

# # -----------------------------------------------------
# # QUEUE - OCI Queue Service (equivalente SQS)
# # -----------------------------------------------------
# variable "queue_retention_seconds" {
#   description = "Tempo de retenção das mensagens em segundos"
#   type        = number
#   default     = 345600 # 4 dias
# }

# variable "queue_timeout_seconds" {
#   description = "Timeout para processamento da mensagem"
#   type        = number
#   default     = 30
# }

# variable "queue_visibility_seconds" {
#   description = "Tempo de visibilidade da mensagem"
#   type        = number
#   default     = 30
# }

# variable "queue_dead_letter_count" {
#   description = "Número de tentativas antes de enviar para DLQ"
#   type        = number
#   default     = 5
# }
