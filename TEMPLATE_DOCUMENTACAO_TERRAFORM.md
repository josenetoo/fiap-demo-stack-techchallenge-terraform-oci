# 📝 Template de Documentação Terraform - Tech Challenge Fase 3

**Use este template para documentar seu projeto Terraform no Tech Challenge**

---

## 📋 Informações do Projeto

**Projeto:** [Nome do Projeto] - Infraestrutura como Código  
**Grupo:** [Nome do Grupo]  
**Integrantes:**
- [Nome 1] - RM [xxxxx]
- [Nome 2] - RM [xxxxx]
- [Nome 3] - RM [xxxxx]

**Curso:** Pós-Tech FIAP - DevOps e Arquitetura Cloud  
**Fase:** 3  
**Data:** [DD/MM/AAAA]

---

## 🎯 Objetivo

Provisionar toda a infraestrutura na **Oracle Cloud Infrastructure (OCI)** utilizando Terraform, demonstrando domínio em Infrastructure as Code, provisionamento multi-cloud e boas práticas de automação.

---

## 🏗️ Arquitetura da Infraestrutura

### Diagrama de Arquitetura


```
┌─────────────────────────────────────────────────────────────────────┐
│                    Oracle Cloud Infrastructure                      │
│                         Tenancy / Compartment                       │
│                                                                     │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │  VCN Principal: 10.0.0.0/16                                   │  │
│  │                                                               │  │
│  │  ┌──────────────────────────────────────────────────────┐    │  │
│  │  │ Subnet Pública: 10.0.1.0/24                          │    │  │
│  │  │                                                      │    │  │
│  │  │  ┌──────────┐  ┌──────────┐                         │    │  │
│  │  │  │Instance 1│  │Instance 2│  (Compute)              │    │  │
│  │  │  └──────────┘  └──────────┘                         │    │  │
│  │  └──────────────────────────────────────────────────────┘    │  │
│  │                                                               │  │
│  │  ┌──────────────────────────────────────────────────────┐    │  │
│  │  │ Internet Gateway                                     │    │  │
│  │  └──────────────────────────────────────────────────────┘    │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │  VCN OKE: 10.10.0.0/16 (Kubernetes)                          │  │
│  │                                                               │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │ API Subnet  │  │  LB Subnet  │  │Workers Sub  │          │  │
│  │  │10.10.0.0/28 │  │10.10.20.0/24│  │10.10.10.0/24│          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │                                                               │  │
│  │  ┌─────────────┐  ┌─────────────┐                            │  │
│  │  │  Pods Sub   │  │   DB Sub    │                            │  │
│  │  │10.10.128/18 │  │10.10.30.0/24│                            │  │
│  │  └─────────────┘  └─────────────┘                            │  │
│  │                                                               │  │
│  │  ┌──────────────────────────────────────────────────────┐    │  │
│  │  │ OKE Cluster + Node Pool                              │    │  │
│  │  └──────────────────────────────────────────────────────┘    │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌────────────────────────────────────────────────────────────┐     │
│  │  Serviços Gerenciados                                      │     │
│  │                                                            │     │
│  │  ┌──────────────────────────────────────────────────────┐  │     │
│  │  │  NoSQL Database                                      │  │     │
│  │  │  - Tabela: Analytics                                 │  │     │
│  │  │  - Índices: feature_name, user_id                    │  │     │
│  │  └──────────────────────────────────────────────────────┘  │     │
│  │                                                            │     │
│  │  ┌──────────────────────────────────────────────────────┐  │     │
│  │  │  Queue Service                                       │  │     │
│  │  │  - Fila Principal                                    │  │     │
│  │  │  - Dead Letter Queue (DLQ)                           │  │     │
│  │  └──────────────────────────────────────────────────────┘  │     │
│  │                                                            │     │
│  │  ┌──────────────────────────────────────────────────────┐  │     │
│  │  │  Container Registry (OCIR)                           │  │     │
│  │  │  - 5 repositórios:                                   │  │     │
│  │  │    • api-gateway                                     │  │     │
│  │  │    • user-service                                    │  │     │
│  │  │    • order-service                                   │  │     │
│  │  │    • payment-service                                 │  │     │
│  │  │    • notification-service                            │  │     │
│  │  └──────────────────────────────────────────────────────┘  │     │
│  └────────────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 📁 Estrutura do Projeto Terraform

```
seu-projeto-terraform/
├── terraform/
│   ├── provider.tf              # Provider OCI
│   ├── backend.tf               # Backend local ou remoto
│   ├── variables.tf             # Variáveis globais
│   ├── outputs.tf               # Outputs importantes
│   ├── main.tf                  # VCN + Compute (demo simples)
│   ├── networking.tf            # VCN dedicada OKE + Subnets
│   ├── oke.tf                   # Oracle Kubernetes Engine
│   ├── nosql.tf                 # NoSQL Database + Índices
│   ├── messaging.tf             # Queue Service + DLQ
│   ├── registry.tf              # Container Registry (5 repos)
│   ├── terraform.tfvars.example # Exemplo de credenciais
│   └── envs/
│       ├── dev.tfvars           # Configurações dev
│       └── prod.tfvars          # Configurações prod
├── .gitignore
└── README.md                     # Este arquivo
```

---

## 📊 Recursos Provisionados

### Resumo Quantitativo

| Categoria | Recurso | Quantidade | Descrição |
|-----------|---------|------------|-----------|
| **Networking** | VCN Principal | 1 | Rede virtual (10.0.0.0/16) |
| | Subnet Pública | 1 | Para instâncias Compute |
| | Internet Gateway | 1 | Acesso à internet |
| | Security List | 1 | Regras de firewall |
| **Networking OKE** | VCN OKE | 1 | Rede dedicada Kubernetes (10.10.0.0/16) |
| | Subnets | 5 | API, Workers, LB, Pods, DB |
| | NAT Gateway | 1 | Saída para subnets privadas |
| | Service Gateway | 1 | Acesso a serviços OCI |
| **Compute** | Instances | 2 | VM.Standard.E2.1.Micro (Free Tier) |
| **Kubernetes** | OKE Cluster | 1 | Kubernetes gerenciado v1.34.1 |
| | Node Pool | 1 | Workers para pods |
| **Database** | NoSQL Table | 1 | Tabela Analytics |
| | NoSQL Indexes | 2 | Índices para queries |
| **Messaging** | Queue | 1 | Fila principal |
| | Dead Letter Queue | 1 | DLQ para mensagens com erro |
| **Registry** | OCIR Repositories | 5 | Repositórios de containers |

### Detalhamento por Arquivo

#### 1. Networking Principal (`main.tf`)

**Recursos criados:**
- `module.vcn` - VCN usando módulo oficial Oracle (3.6.0)
  - VCN: 10.0.0.0/16
  - Internet Gateway
  - Route Tables
- `oci_core_subnet.public` - Subnet pública (10.0.1.0/24)
- `oci_core_default_security_list.default` - Security List com regras SSH/HTTP
- `module.compute` - Instâncias usando módulo oficial Oracle (2.4.0)
  - 2 instâncias VM.Standard.E2.1.Micro
  - IPs públicos

**Outputs importantes:**
- `vcn_id` - OCID da VCN
- `subnet_id` - OCID da subnet pública
- `instance_public_ips` - IPs públicos das instâncias

#### 2. Networking OKE (`networking.tf`)

**Recursos criados:**
- `oci_core_vcn.oke` - VCN dedicada para OKE (10.10.0.0/16)
- `oci_core_subnet.oke_api` - Subnet para API Endpoint (10.10.0.0/28)
- `oci_core_subnet.oke_workers` - Subnet para Workers (10.10.10.0/24)
- `oci_core_subnet.oke_lb` - Subnet para Load Balancers (10.10.20.0/24)
- `oci_core_subnet.oke_pods` - Subnet para Pods (10.10.128.0/18)
- `oci_core_subnet.oke_db` - Subnet para Databases (10.10.30.0/24)
- `oci_core_internet_gateway.oke` - Internet Gateway
- `oci_core_nat_gateway.oke` - NAT Gateway
- `oci_core_service_gateway.oke` - Service Gateway
- Route Tables e Security Lists específicas

**Outputs importantes:**
- `oke_vcn_id` - OCID da VCN OKE
- `oke_subnet_ids` - Map com OCIDs das subnets

#### 3. OKE - Oracle Kubernetes Engine (`oke.tf`)

**Recursos criados:**
- `oci_containerengine_cluster.main` - Cluster OKE
  - Tipo: ENHANCED_CLUSTER
  - VCN Native Pod Networking
  - Kubernetes version: v1.34.1
- `oci_containerengine_node_pool.main` - Node Pool
  - Shape: VM.Standard.E4.Flex
  - Node count: 2
  - Subnet: Workers (privada)

**Configurações:**
- API Endpoint: Público
- CNI Type: OCI_VCN_IP_NATIVE
- Services CIDR: 10.96.0.0/16

**Outputs importantes:**
- `oke_cluster_id` - OCID do cluster
- `oke_cluster_endpoint` - Endpoint da API Kubernetes
- `oke_cluster_name` - Nome do cluster

#### 4. NoSQL Database (`nosql.tf`)

**Recursos criados:**
- `oci_nosql_table.toggle_master_analytics` - Tabela Analytics
- `oci_nosql_index.toggle_by_feature` - Índice por feature_name
- `oci_nosql_index.toggle_by_user` - Índice por user_id

**Configurações:**
- DDL: Tabela com campos id, feature_name, enabled, user_id, timestamp, metadata
- Primary Key: id
- Limites (Free Tier):
  - Max read units: 50
  - Max write units: 50
  - Max storage: 25 GB

**Outputs importantes:**
- `nosql_table_id` - OCID da tabela
- `nosql_table_name` - Nome da tabela

#### 5. Queue Service (`messaging.tf`)

**Recursos criados:**
- `oci_queue_queue.main` - Fila principal
- `oci_queue_queue.dlq` - Dead Letter Queue

**Configurações Fila Principal:**
- Dead letter delivery count: 5
- Retention: 4 dias (345600s)
- Timeout: 30s
- Visibility: 30s

**Configurações DLQ:**
- Retention: 7 dias (604800s)
- Timeout: 30s
- Visibility: 30s

**Outputs importantes:**
- `queue_id` - OCID da fila
- `queue_endpoint` - Endpoint da fila
- `dlq_id` - OCID da DLQ

#### 6. Container Registry (`registry.tf`)

**Recursos criados (5 repositórios):**
- `oci_artifacts_container_repository.api_gateway`
- `oci_artifacts_container_repository.user_service`
- `oci_artifacts_container_repository.order_service`
- `oci_artifacts_container_repository.payment_service`
- `oci_artifacts_container_repository.notification_service`

**Configurações:**
- Visibilidade: Privado
- Imutabilidade: Desabilitada (permite sobrescrever tags)
- README: Descrição de cada serviço

**Outputs importantes:**
- `registry_urls` - Map com URLs dos repositórios

**Formato URL:**
```
<region>.ocir.io/<namespace>/<project-name>/<service-name>
```

---

## 🔧 Variáveis Principais

### Variáveis de Autenticação (Sensíveis)

| Variável | Tipo | Descrição |
|----------|------|-----------|
| `tenancy_ocid` | string | OCID do Tenancy OCI |
| `user_ocid` | string | OCID do Usuário OCI |
| `fingerprint` | string | Fingerprint da API Key |
| `region` | string | Região OCI (ex: sa-vinhedo-1) |
| `compartment_id` | string | OCID do Compartment |
| `ssh_public_key` | string | Chave SSH pública |

⚠️ **Importante:** Estas variáveis devem estar em `terraform.tfvars` (não commitado)

### Variáveis de Projeto

| Variável | Tipo | Default | Descrição |
|----------|------|---------|-----------|
| `project_name` | string | `demo` | Nome do projeto |
| `environment` | string | `dev` | Ambiente (dev/staging/prod) |
| `vcn_cidr` | string | `10.0.0.0/16` | CIDR da VCN principal |
| `subnet_cidr` | string | `10.0.1.0/24` | CIDR da subnet pública |

### Variáveis de Compute

| Variável | Tipo | Default | Descrição |
|----------|------|---------|-----------|
| `instance_count` | number | `2` | Número de instâncias (1-4) |
| `instance_shape` | string | `VM.Standard.E2.1.Micro` | Shape da instância (Free Tier) |
| `instance_image_id` | string | - | OCID da imagem Oracle Linux |
| `ingress_ports` | list(number) | `[22, 80]` | Portas TCP permitidas |

### Variáveis OKE (Kubernetes)

| Variável | Tipo | Default | Descrição |
|----------|------|---------|-----------|
| `oke_vcn_cidr` | string | `10.10.0.0/16` | CIDR da VCN OKE |
| `oke_kubernetes_version` | string | `v1.34.1` | Versão do Kubernetes |
| `oke_node_shape` | string | `VM.Standard.E4.Flex` | Shape dos nodes |
| `oke_node_count` | number | `2` | Número de nodes |

### Variáveis NoSQL

| Variável | Tipo | Default | Descrição |
|----------|------|---------|-----------|
| `nosql_read_units` | number | `50` | Max read units (Free Tier) |
| `nosql_write_units` | number | `50` | Max write units (Free Tier) |
| `nosql_storage_gb` | number | `25` | Max storage GB (Free Tier) |

### Variáveis Queue

| Variável | Tipo | Default | Descrição |
|----------|------|---------|-----------|
| `queue_retention_seconds` | number | `345600` | Retenção (4 dias) |
| `queue_timeout_seconds` | number | `30` | Timeout de processamento |
| `queue_visibility_seconds` | number | `30` | Visibility timeout |
| `queue_dead_letter_count` | number | `5` | Tentativas antes de DLQ |

---

## 🔐 Backend (State Management)

### Opção 1: Backend Local (Padrão)

```hcl
terraform {
  required_version = ">= 1.10.0"
  
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
    }
  }
}
```

### Opção 2: Backend Remoto (OCI Object Storage)

```hcl
terraform {
  backend "http" {
    address       = "https://objectstorage.sa-vinhedo-1.oraclecloud.com/n/<namespace>/b/<bucket>/o/terraform.tfstate"
    update_method = "PUT"
  }
}
```



---

## 🚀 Como Usar

### Pré-requisitos

- Terraform >= 1.10.0
- Conta OCI (Free Tier disponível)
- API Key OCI configurada
- kubectl (para validar cluster OKE - opcional)

### Passo 1: Clonar Repositório

```bash
git clone https://github.com/seu-grupo/togglemaster-terraform.git
cd togglemaster-terraform
```

### Passo 2: Configurar Credenciais OCI

```bash
# Criar diretório para chaves OCI
mkdir -p ~/.oci

# Mover chave privada baixada do Console OCI
mv ~/Downloads/oci_api_key.pem ~/.oci/
chmod 600 ~/.oci/oci_api_key.pem
```

**Obter credenciais no Console OCI:**
1. Perfil → User Settings → API Keys → Add API Key
2. Copiar: user OCID, fingerprint, tenancy OCID, region

### Passo 3: Configurar Variáveis

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars

# Editar com suas credenciais OCI
vim terraform.tfvars
```

**Preencher `terraform.tfvars`:**
```hcl
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaa..."
user_ocid        = "ocid1.user.oc1..aaaaaaaa..."
fingerprint      = "aa:bb:cc:dd:ee:ff:..."
region           = "sa-vinhedo-1"
compartment_id   = "ocid1.compartment.oc1..aaaaaaaa..."
ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAA..."
instance_image_id = "ocid1.image.oc1..aaaaaaaa..."
```

⚠️ **Importante:** Não commite `terraform.tfvars`!

### Passo 4: Inicializar Terraform

```bash
terraform init
```

### Passo 5: Validar e Formatar

```bash
terraform validate
terraform fmt
```

### Passo 6: Planejar Infraestrutura

```bash
terraform plan -var-file=envs/dev.tfvars
```

### Passo 7: Aplicar Infraestrutura

```bash
terraform apply -var-file=envs/dev.tfvars
# Digite 'yes' quando perguntar
```

⏱️ **Tempo estimado:** 
- VCN + Compute: ~2-3 minutos
- OKE (se habilitado): ~10-15 minutos

### Passo 8: Ver Outputs

```bash
terraform output
terraform output -json > outputs.json
```

### Passo 9: Configurar kubectl (se OKE habilitado)

```bash
# Obter kubeconfig do OKE
oci ce cluster create-kubeconfig \
  --cluster-id $(terraform output -raw oke_cluster_id) \
  --file ~/.kube/config \
  --region sa-vinhedo-1

# Verificar nodes
kubectl get nodes
```

### Passo 10: Destruir Infraestrutura (quando necessário)

```bash
terraform destroy -var-file=envs/dev.tfvars
# Digite 'yes' quando perguntar
```

⚠️ **IMPORTANTE:** Sempre destrua recursos após testes para evitar custos!

---

## 📤 Outputs Importantes

### Networking

```hcl
output "vcn_id" {
  description = "OCID da VCN principal"
  value       = module.vcn.vcn_id
}

output "subnet_id" {
  description = "OCID da subnet pública"
  value       = oci_core_subnet.public.id
}

output "oke_vcn_id" {
  description = "OCID da VCN OKE"
  value       = oci_core_vcn.oke.id
}
```

### Compute

```hcl
output "instance_public_ips" {
  description = "IPs públicos das instâncias"
  value       = module.compute.public_ip
}

output "instance_ids" {
  description = "OCIDs das instâncias"
  value       = module.compute.instance_id
}
```

### OKE (Kubernetes)

```hcl
output "oke_cluster_id" {
  description = "OCID do cluster OKE"
  value       = oci_containerengine_cluster.main.id
}

output "oke_cluster_endpoint" {
  description = "Endpoint da API Kubernetes"
  value       = oci_containerengine_cluster.main.endpoints[0].kubernetes
  sensitive   = true
}

output "oke_cluster_name" {
  description = "Nome do cluster OKE"
  value       = oci_containerengine_cluster.main.name
}
```

### NoSQL & Queue

```hcl
output "nosql_table_name" {
  description = "Nome da tabela NoSQL"
  value       = oci_nosql_table.toggle_master_analytics.name
}

output "queue_endpoint" {
  description = "Endpoint da fila principal"
  value       = oci_queue_queue.main.messages_endpoint
  sensitive   = true
}
```

### Container Registry

```hcl
output "registry_urls" {
  description = "URLs dos repositórios OCIR"
  value = {
    api_gateway    = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${var.project_name}/api-gateway"
    user_service   = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${var.project_name}/user-service"
    order_service  = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${var.project_name}/order-service"
    payment        = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${var.project_name}/payment-service"
    notification   = "${var.region}.ocir.io/${data.oci_objectstorage_namespace.ns.namespace}/${var.project_name}/notification-service"
  }
}
```

---

## 💰 Estimativa de Custos

### OCI Free Tier (Sempre Grátis)

| Recurso | Quantidade | Limite Free Tier | Custo |
|---------|------------|------------------|-------|
| Compute VM.Standard.E2.1.Micro | 2 | 2 instâncias | **$0** |
| VCN + Subnets | 2 VCNs | Ilimitado | **$0** |
| NoSQL Database | 1 tabela | 50/50/25 GB | **$0** |
| Queue Service | 2 filas | Ilimitado | **$0** |
| Container Registry | 5 repos | 500 GB storage | **$0** |
| Object Storage | - | 20 GB | **$0** |

### Recursos Pagos (se habilitados)

| Recurso | Tipo | Quantidade | Custo/mês (estimado) |
|---------|------|------------|----------------------|
| OKE Cluster | Managed K8s | 1 | **$0** (cluster grátis) |
| OKE Nodes | VM.Standard.E4.Flex | 2 | ~$60-80 |
| NAT Gateway | - | 1 | ~$30 |

**Total com Free Tier:** **$0/mês**  
**Total com OKE habilitado:** **~$90-110/mês**

---

## 🐛 Troubleshooting

### Erro: "NotAuthenticated" ou "401 Unauthorized"

**Causa:** Credenciais OCI incorretas ou chave privada inválida

**Solução:**
```bash
# Verificar fingerprint da chave
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c

# Verificar permissões
chmod 600 ~/.oci/oci_api_key.pem

# Validar credenciais no terraform.tfvars
```

### Erro: "out of host capacity"

**Causa:** Availability Domain sem capacidade para o shape

**Solução:**
```hcl
# Alterar ad_number no main.tf
ad_number = 2  # ou 3
```

### Erro: "shape VM.Standard.E2.1.Micro is not available"

**Causa:** Shape não disponível na região

**Solução:**
```bash
# Verificar shapes disponíveis
oci compute shape list --compartment-id <compartment_id>

# Ou usar shape alternativo
instance_shape = "VM.Standard.A1.Flex"
```

### Erro: "Invalid compartment_id"

**Causa:** OCID inválido ou sem permissões

**Solução:**
- Verificar se OCID começa com `ocid1.compartment.oc1...` ou `ocid1.tenancy.oc1...`
- Confirmar permissões no compartment

---

## 📚 Referências

- [Terraform OCI Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [OCI Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
- [OCI Free Tier](https://www.oracle.com/cloud/free/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [OCI Terraform Modules](https://github.com/oracle-terraform-modules)
- [OKE Best Practices](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengbestpractices.htm)

---

**Grupo:** [Nome do Grupo]  
**Data:** [DD/MM/AAAA]  
**Curso:** Pós-Tech FIAP - DevOps e Arquitetura Cloud  
**Fase:** 3 - Infrastructure as Code

🚀 **Boa sorte no Tech Challenge!**
