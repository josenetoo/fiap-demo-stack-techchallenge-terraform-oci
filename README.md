# 🚀 Criando Stack Completa com Terraform na OCI

Projeto demonstrativo de Infrastructure as Code usando Terraform para provisionar uma stack completa na Oracle Cloud Infrastructure.

**Curso:** Pós-Tech FIAP - DevOps e Arquitetura Cloud  
**Professor:** José Neto  
**Tema:** Infrastructure as Code com Terraform

## 📋 Pré-requisitos

- Conta Oracle Cloud (Free Tier disponível)
- Terraform >= 1.14.0 (para backend OCI)
- Git instalado

## 🏗️ Arquitetura

### Recursos Provisionados

**Demo Simples (main.tf):**
- VCN + Subnet pública + Security List
- Instâncias Compute configuráveis

**Networking OKE (networking.tf):**
- VCN dedicada para OKE (10.10.0.0/16)
- Subnets: API Endpoint, Workers, Load Balancer, Pods, Databases
- Internet Gateway, NAT Gateway, Service Gateway
- Route Tables e Security Lists específicas

**OKE - Oracle Kubernetes Engine (oke.tf):**
- Cluster Kubernetes gerenciado
- Node Pool com VCN Native Pod Networking
- Versão: v1.34.1

**Serviços Adicionais:**
- **NoSQL** (nosql.tf): Tabela equivalente ao DynamoDB (FREE)
- **Queue** (messaging.tf): Filas equivalente ao SQS (FREE)
- **Registry** (registry.tf): 5 repositórios OCIR (FREE)

### Diagrama

```
┌─────────────────────────────────────────────────────────────┐
│                      OCI Tenancy                            │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              VCN OKE (10.10.0.0/16)                   │  │
│  │                                                       │  │
│  │  ┌─────────────┐  ┌─────────────┐                    │  │
│  │  │ API Subnet  │  │  LB Subnet  │  ← Públicas        │  │
│  │  │ 10.10.0.0/28│  │10.10.20.0/24│                    │  │
│  │  └─────────────┘  └─────────────┘                    │  │
│  │                                                       │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌──────────────┐  │  │
│  │  │Workers Sub  │  │  Pods Sub   │  │   DB Sub     │  │  │
│  │  │10.10.10.0/24│  │10.10.128/18 │  │10.10.30.0/24 │  │  │
│  │  └─────────────┘  └─────────────┘  └──────────────┘  │  │
│  │                     ↑ Privadas                        │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │   OKE    │ │  NoSQL   │ │  Queue   │ │ Registry │       │
│  │Kubernetes│ │(DynamoDB)│ │  (SQS)   │ │  (ECR)   │       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Estrutura do Projeto

```
📁 fiap-demo-terraform-stack-oci/
├── 📁 terraform/
│   ├── backend.tf                # Backend local
│   ├── provider.tf               # Provider OCI
│   ├── main.tf                   # Demo simples (VCN, Subnet, Compute)
│   ├── networking.tf             # VCN dedicada para OKE + Subnets (comentado)
│   ├── oke.tf                    # Oracle Kubernetes Engine (comentado)
│   ├── nosql.tf                  # NoSQL Database (comentado)
│   ├── messaging.tf              # Queue Service (comentado)
│   ├── registry.tf               # Container Registry (comentado)
│   ├── variables.tf              # Variáveis com validações
│   ├── outputs.tf                # Outputs
│   ├── terraform.tfvars.example  # Exemplo de configuração
│   └── 📁 envs/
│       └── dev.tfvars            # Configuração do ambiente dev
├── .gitignore
├── README.md                     # Este arquivo
├── HANDS-ON.md                   # Guia passo a passo da aula
├── BACKEND-OCI.md                # Guia de backend remoto (opcional)
├── TECH_CHALLENGE_TEMPLATE.md    # Template para entrega
└── DESAFIO_FINAL.md              # Desafio AWS → OCI
```

## 🔐 Configuração

### 1. Criar API Key na OCI

1. Console OCI → **Perfil** → **User Settings** → **API Keys** → **Add API Key**
2. **Generate API Key Pair** → Download Private + Public Key
3. Copiar valores: user OCID, fingerprint, tenancy OCID, region

### 2. Configurar Credenciais Localmente

```bash
# Criar diretório OCI
mkdir -p ~/.oci

# Mover chave privada
mv ~/Downloads/oci_api_key.pem ~/.oci/
chmod 600 ~/.oci/oci_api_key.pem

# Criar terraform.tfvars
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

**Editar `terraform.tfvars` com suas credenciais:**
```hcl
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaa..."
user_ocid        = "ocid1.user.oc1..aaaaaaaa..."
fingerprint      = "aa:bb:cc:dd:ee:ff:..."
region           = "sa-vinhedo-1"
compartment_id   = "ocid1.compartment.oc1..aaaaaaaa..."
ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAA..."
```

⚠️ **IMPORTANTE:** Não commite `terraform.tfvars`! Está no .gitignore

### Variáveis do Ambiente (`terraform/envs/dev.tfvars`)

Valores editáveis do ambiente, commitados no repositório:

```hcl
# --- Projeto ---
project_name = "fiap-demo-oci"
environment  = "dev"

# --- Rede Demo ---
vcn_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

# --- Networking OKE ---
oke_vcn_cidr            = "10.10.0.0/16"
oke_subnet_api_cidr     = "10.10.0.0/28"
oke_subnet_workers_cidr = "10.10.10.0/24"
oke_subnet_lb_cidr      = "10.10.20.0/24"
oke_subnet_pods_cidr    = "10.10.128.0/18"
oke_subnet_db_cidr      = "10.10.30.0/24"

# --- OKE ---
oke_kubernetes_version = "v1.34.1"
oke_node_shape         = "VM.Standard.E4.Flex"
oke_node_count         = 2

# --- NoSQL, Queue (FREE) ---
nosql_read_units  = 50
nosql_write_units = 50
nosql_storage_gb  = 25
```

## 🔑 Como Obter as Credenciais OCI

### 1. Criar API Key

1. Console OCI → **Perfil** → **User Settings** → **API Keys** → **Add API Key**
2. **Generate API Key Pair** → Download Private + Public Key
3. Copiar valores: user, fingerprint, tenancy, region

### 2. Converter Chave Privada para Base64

```bash
cat oci_api_key.pem | base64 | tr -d '\n'
```

### 3. Obter Compartment ID

Menu OCI: ☰ → **Identity & Security** → **Compartments** → Copiar OCID

### 4. Obter Image OCID

Menu OCI: ☰ → **Compute** → **Images** → Filtrar Oracle Linux → Copiar OCID

### 5. Gerar Chave SSH

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/oci_demo_key -N ""
cat ~/.ssh/oci_demo_key.pub
```

## 🚀 Uso (Execução Local)

### Inicializar Terraform

```bash
cd terraform
terraform init
```

### Validar e Formatar

```bash
terraform validate
terraform fmt
```

### Planejar Infraestrutura

```bash
terraform plan -var-file=envs/dev.tfvars
```

### Aplicar Infraestrutura

```bash
terraform apply -var-file=envs/dev.tfvars
# Digite 'yes' quando perguntar
```

### Ver Outputs

```bash
terraform output
terraform output -json
```

### Destruir Infraestrutura

```bash
terraform destroy -var-file=envs/dev.tfvars
# Digite 'yes' quando perguntar
```

⚠️ **IMPORTANTE:** Sempre destrua os recursos após testes para evitar custos!

## �️ Segurança

- ✅ Credenciais isoladas em GitHub Secrets (7 secrets)
- ✅ Variáveis de projeto em `envs/dev.tfvars` (versionado, sem dados sensíveis)
- ✅ Variables com `sensitive = true` e validações
- ✅ Remote state com Backend OCI nativo
- ✅ Aprovação manual via environment protection rules
- ✅ Módulos oficiais Oracle versionados
- ✅ Zero valores hardcoded no código Terraform

## 🔧 Troubleshooting

| Erro | Solução |
|------|---------|
| `NotAuthenticated` | Verificar credenciais OCI e secrets |
| `out of host capacity` | Trocar `ad_number` no main.tf |
| `shape not available` | Alterar `instance_shape` no dev.tfvars |
| `Invalid compartment_id` | Verificar OCID (aceita tenancy ou compartment) |

## 📚 Recursos

- [Terraform OCI Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [Terraform OCI Backend](https://developer.hashicorp.com/terraform/language/backend/oci)
- [Oracle Terraform Modules](https://registry.terraform.io/namespaces/oracle-terraform-modules)
- [OCI Free Tier](https://www.oracle.com/cloud/free/)

## 🎓 Informações da Aula

**Professor:** José Neto

**Curso:** DevOps e Arquitetura Cloud - FIAP

**Tema:** Infrastructure as Code com Terraform

---

**🚀 Happy Terraforming!**
