# ============================================================================
# Configuração do Ambiente DEV
# ============================================================================
#
# Variáveis NÃO sensíveis do projeto.
# Credenciais ficam nos GitHub Secrets.
#
# Para outros ambientes, crie: staging.tfvars, prod.tfvars
# ============================================================================

# --- Compartment (OBRIGATÓRIO) ---
# Obtenha no Console OCI: Identity → Compartments
# Ou use seu tenancy_ocid se não tiver compartment específico
# Você pode obter isso de ~/.oci/config também
compartment_id = "ocid1.tenancy.oc1..aaaaaaaamj5wzdxvxecm4ykizj4dvs6zn2hi6lz3nntoqzjkpyv6rqp5wloq"

# --- Projeto ---
project_name = "fiap-demo-oci"
environment  = "dev"

# --- Rede ---
vcn_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

# --- Compute ---
instance_image_id = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaa3isvzt4wyrlth6etis4ekiwaxpqjznsknrk3jbwka5uonkuvbewa"
instance_shape    = "VM.Standard.E5.Flex"
instance_count    = 2

# --- Security ---
ingress_ports = [22, 80]  # SSH, HTTP (adicionar 3306, 6379 quando criar MySQL e Redis)

# # --- Database - MySQL ---
# mysql_shape          = "MySQL.2"
# mysql_admin_username = "admin"
# mysql_admin_password = "FiapDemo2024!"  # Senha forte: min 8 chars, maiúscula, número, especial
# mysql_storage_gb     = 50

# # --- Cache - Redis ---
# redis_node_count  = 1
# redis_version     = "V7_0_5"
# redis_memory_gb   = 2

# # --- Networking - VCN dedicada para OKE ---
# oke_vcn_cidr           = "10.10.0.0/16"
# oke_subnet_api_cidr    = "10.10.0.0/28"      # API Endpoint (pequena, /28 = 16 IPs)
# oke_subnet_workers_cidr = "10.10.10.0/24"    # Worker Nodes (256 IPs)
# oke_subnet_lb_cidr     = "10.10.20.0/24"     # Load Balancers (256 IPs)
# oke_subnet_pods_cidr   = "10.10.128.0/18"    # Pods VCN Native (16k IPs)
# oke_subnet_db_cidr     = "10.10.30.0/24"     # Databases/outros (256 IPs)

# # --- OKE (Oracle Kubernetes Engine) ---
# oke_kubernetes_version = "v1.34.1"
# oke_node_shape         = "VM.Standard.E5.Flex"
# oke_node_ocpus         = 2
# oke_node_memory_gb     = 16
# oke_node_count         = 2
# oke_node_image_id      = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaa3lpk4c7vr3ezrtcfi3d7iqagmax2xxsbtg66vnc4bwiatdslqtuq"
# oke_services_cidr      = "10.96.0.0/16"  # CIDR para Services (ClusterIP)

# # --- NoSQL (equivalente DynamoDB) ---
# nosql_read_units  = 50
# nosql_write_units = 50
# nosql_storage_gb  = 25 

# # --- Queue (equivalente SQS) ---
# queue_retention_seconds  = 345600  # 4 dias
# queue_timeout_seconds    = 30
# queue_visibility_seconds = 30
# queue_dead_letter_count  = 5
