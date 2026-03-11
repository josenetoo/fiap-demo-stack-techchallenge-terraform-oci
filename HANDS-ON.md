# 🎓 HANDS-ON: Criando Stack Completa com Terraform na OCI

**Guia prático - Execução Local**

---

## 📋 Pré-requisitos

- [ ] Conta Oracle Cloud (Free Tier) - https://www.oracle.com/cloud/free/
- [ ] Terraform >= 1.10.0 instalado - https://www.terraform.io/downloads
- [ ] Git instalado localmente

---

## 🚀 PARTE 1: Configurar Credenciais OCI (10 min)

### Passo 1: Criar API Key na OCI

1. Acesse: https://cloud.oracle.com
2. **Perfil** (canto superior direito) → **User Settings**
3. Menu lateral: **API Keys** → **Add API Key**
4. **Generate API Key Pair**
5. **Download Private Key** → salvar como `oci_api_key.pem`
6. **Add** → **NÃO FECHE A TELA!**

### Passo 2: Copiar Credenciais

Na tela que apareceu, copie para um bloco de notas:

```ini
user=ocid1.user.oc1..aaaaaaaa...
fingerprint=aa:bb:cc:dd:ee:ff:...
tenancy=ocid1.tenancy.oc1..aaaaaaaa...
region=sa-vinhedo-1
```

### Passo 3: Obter Compartment ID

Menu OCI: ☰ → **Identity & Security** → **Compartments** → Copiar OCID

### Passo 4: Mover Chave Privada para ~/.oci

**Mac/Linux:**
```bash
mkdir -p ~/.oci
mv ~/Downloads/oci_api_key.pem ~/.oci/
chmod 600 ~/.oci/oci_api_key.pem
```

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path $HOME\.oci
Move-Item $HOME\Downloads\oci_api_key.pem $HOME\.oci\
```

### Passo 5: Gerar Chave SSH

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/oci_demo_key -N ""
cat ~/.ssh/oci_demo_key.pub
```

### ✅ Checklist - Você deve ter:

```
✓ user OCID         → ocid1.user.oc1..aaaaaaaa...
✓ fingerprint       → aa:bb:cc:dd:ee:ff:...
✓ tenancy OCID      → ocid1.tenancy.oc1..aaaaaaaa...
✓ region            → sa-vinhedo-1
✓ compartment OCID  → ocid1.compartment.oc1..aaaaaaaa...
✓ private key       → ~/.oci/oci_api_key.pem
✓ ssh public key    → ssh-rsa AAAAB3NzaC1yc2EAAAA...
```

---

## 🔧 PARTE 2: Clonar Projeto e Configurar (10 min)

### Passo 1: Clonar Repositório

```bash
git clone https://github.com/SEU-USUARIO/fiap-demo-terraform-stack-oci.git
cd fiap-demo-terraform-stack-oci
```

### Passo 2: Criar arquivo terraform.tfvars

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

### Passo 3: Editar terraform.tfvars com suas credenciais

```bash
# Editar com seu editor preferido
vim terraform.tfvars
# ou
code terraform.tfvars
# ou
nano terraform.tfvars
```

**Preencher com os valores copiados:**
```hcl
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaa..."
user_ocid        = "ocid1.user.oc1..aaaaaaaa..."
fingerprint      = "aa:bb:cc:dd:ee:ff:..."
region           = "sa-vinhedo-1"
compartment_id   = "ocid1.compartment.oc1..aaaaaaaa..."
ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAA..."
```

⚠️ **IMPORTANTE:** Não commite este arquivo! Ele está no .gitignore

---

## �️ PARTE 3: Instalar Ferramentas DevSecOps (10 min)

Vamos instalar ferramentas profissionais para análise de segurança, custos e documentação.

### Passo 1: Instalar Checkov (Security Scanner)

**Mac/Linux:**
```bash
# Usando pip
pip3 install checkov

# Ou usando brew (Mac)
brew install checkov

# Verificar instalação
checkov --version
```

**Windows:**
```powershell
# Usando pip
pip install checkov

# Verificar instalação
checkov --version
```

### Passo 2: Instalar Infracost (Cost Estimator)

⚠️ **Nota:** Infracost ainda não suporta OCI, mas é útil conhecer para AWS/Azure/GCP.

**Mac:**
```bash
brew install infracost

# Configurar API key (gratuita)
infracost auth login
```

**Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# Configurar API key (gratuita)
infracost auth login
```

**Windows:**
```powershell
# Usando Chocolatey
choco install infracost

# Ou baixar manualmente de: https://www.infracost.io/docs/
```

Após instalar, registre-se (gratuito):
```bash
infracost auth login
# Abrirá navegador para criar conta gratuita
```

**Para OCI:** Usaremos o **OCI Cost Estimator** nativo (Parte 6).

### Passo 3: Instalar terraform-docs (Documentation Generator)

**Mac:**
```bash
brew install terraform-docs
```

**Linux:**
```bash
curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
sudo mv terraform-docs /usr/local/bin/
```

**Windows:**
```powershell
# Usando Chocolatey
choco install terraform-docs

# Ou baixar de: https://github.com/terraform-docs/terraform-docs/releases
```

### ✅ Checklist - Ferramentas Instaladas:

```bash
# Verificar todas as instalações
terraform --version      # >= 1.14.0 (para backend OCI)
checkov --version        # >= 3.0
infracost --version      # >= 0.10 (opcional - não suporta OCI ainda)
terraform-docs --version # >= 0.16

# Deve retornar versões sem erros
```

**Nota:** Infracost não suporta OCI ainda, mas é bom ter instalado para projetos AWS/Azure/GCP.

---

## � PARTE 4: Configurar Variáveis do Ambiente (5 min)

### Passo 1: Obter Image OCID

Menu OCI: ☰ → **Compute** → **Images** → Filtrar Oracle Linux → Copiar OCID

### Passo 2: Editar `terraform/envs/dev.tfvars`

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
oke_node_image_id      = "ocid1.image.oc1..."  # ← OCID da imagem OKE

# --- NoSQL, Queue (FREE) ---
nosql_read_units  = 50
nosql_write_units = 50
nosql_storage_gb  = 25
```

**Este arquivo é commitado no repo** (não é sensível).
## 🔒 PARTE 5: Security Scan com Checkov (10 min)

Antes de provisionar, execute as ferramentas que vimos na live:

```bash
cd terraform/

# 1. Security Scan com Checkov
checkov -d . --framework terraform --compact

# Ou scan completo (mais detalhado)
checkov -d . --framework terraform

# Gerar relatório JSON (opcional)
checkov -d . --framework terraform -o json > checkov-report.json
```

**Resultado esperado:**
```
Passed checks: 3, Failed checks: 2, Skipped checks: 0

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: vcn
        File: /main.tf:7-21
```

**Explicação dos erros:**
- ❌ **CKV_TF_1**: Módulos devem usar commit hash (boa prática avançada)
- ✅ **CKV_OCI_1**: Sem chaves privadas hardcoded (passou!)
- ✅ **CKV_TF_2**: Módulos usam versão com tag (passou!)

### Passo 2: Analisar Resultados

**Exemplo de output:**
```
Passed checks: 42, Failed checks: 6, Skipped checks: 0

Check: CKV_OCI_1: "Ensure security list has no unrestricted ingress on port 22"
	FAILED for resource: oci_core_default_security_list.default
	File: /main.tf:37-57
	Guide: https://docs.bridgecrew.io/docs/oci_networking_1

Check: CKV_OCI_5: "Ensure MySQL Database has backup enabled"
	PASSED for resource: oci_mysql_mysql_db_system.auth
```

### Passo 3: Corrigir Issues Críticos (Opcional)

**Exemplo:** Se Checkov reclamar de SSH aberto para 0.0.0.0/0:

```hcl
# Antes (inseguro)
ingress_ports = [22, 80]

# Depois (mais seguro - apenas seu IP)
ingress_ports = [80]  # Remover SSH ou restringir ao seu IP
```


---

## 💰 PARTE 6: Cost Estimation - OCI Cost Estimator (5 min)

⚠️ **Nota:** Infracost ainda não suporta OCI. Veja abaixo!

### Passo 1: Tentar Infracost (Demonstração)

```bash
cd terraform/

# Tentar executar Infracost
infracost breakdown --path .
```

**Resultado esperado:**
```
No cloud resources were detected
OVERALL TOTAL: $0.00
```

**Por quê?** Infracost não reconhece recursos OCI (apenas AWS, Azure, GCP).

### Passo 2: Usar OCI Cost Estimator (Alternativa)

1. Abra: https://www.oracle.com/cloud/costestimator.html
2. Ou no Console OCI: ☰ → **Governance** → **Cost Analysis** → **Cost Estimator**

### Passo 3: Adicionar Recursos Manualmente

**Recursos da nossa stack básica:**

| Recurso | Tipo | Quantidade | Free Tier? | Custo/mês |
|---------|------|------------|------------|-----------|
| **VCN** | Networking | 1 | ✅ Sim | $0.00 |
| **Subnet** | Networking | 1 | ✅ Sim | $0.00 |
| **Internet Gateway** | Networking | 1 | ✅ Sim | $0.00 |
| **Compute Instance** | VM.Standard.E2.1.Micro | 2 | ✅ Sim (até 2) | $0.00 |
| **Block Volume** | Boot (50GB cada) | 2 | ✅ Sim (até 200GB) | $0.00 |

**Total Stack Básica:** **$0.00/mês** (100% Free Tier)

### Passo 3: Recursos Pagos (Opcional - Opção B/C)

Se descomentar MySQL e Redis:

| Recurso | Tipo | Custo/mês (estimado) |
|---------|------|----------------------|
| **MySQL Database** | 1 OCPU, 50GB | ~$45-60 |
| **Redis Cache** | Standard | ~$30-50 |
| **OKE Cluster** | Control Plane | $0.00 (Free) |
| **OKE Worker Nodes** | 2x VM.Standard.E2.1.Micro | $0.00 (Free Tier) |
| **NoSQL Database** | 50 RU, 25GB | $0.00 (Free Tier) |
| **Queue Service** | 1M requests | ~$0.40 |
| **Container Registry** | 500GB storage | $0.00 (Free Tier) |

**Total com MySQL+Redis:** **~$75-110/mês**

### Passo 4: Monitorar Custos Reais

```bash
# Após provisionar, monitore no Console OCI
# ☰ → Governance → Cost Analysis → Cost and Usage Reports
```

**💡 Dica:** Sempre use `terraform destroy` após testes para evitar custos!

---

## 📚 PARTE 7: Auto-Documentação com terraform-docs (3 min)

Vamos gerar documentação automaticamente do nosso código!

### Passo 1: Gerar Documentação

```bash
cd terraform/

# Gerar README.md
terraform-docs markdown table . > TERRAFORM_README.md

# Ou atualizar README existente
terraform-docs markdown table . --output-file README.md

# Formato alternativo (mais detalhado)
terraform-docs markdown document . > TERRAFORM_DOCS.md
```

### Passo 2: Ver Resultado

```bash
cat TERRAFORM_README.md
```

**Output gerado:**
```markdown
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.10.0 |
| oci | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| oci | 6.18.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment_id | OCID do compartment | `string` | n/a | yes |
| region | Região OCI | `string` | `"sa-vinhedo-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vcn_id | OCID da VCN criada |
| instance_public_ips | IPs públicos das instâncias |
```

**💡 Dica:** Mostre como isso economiza tempo de documentação!

---

## 🚀 PARTE 8: Executar Terraform Localmente (20 min)

### Passo 1: Inicializar Terraform

```bash
# Certifique-se de estar no diretório terraform/
cd terraform

# Inicializar (baixa providers e módulos)
terraform init
```

**O que acontece:**
- Download do provider OCI
- Download dos módulos oficiais Oracle
- Inicialização do backend local

### Passo 2: Validar Configuração

```bash
# Validar sintaxe
terraform validate

# Formatar código
terraform fmt
```

### Passo 3: Planejar Infraestrutura (Demo Simples)

```bash
# Plan com arquivo de variáveis
terraform plan -var-file=envs/dev.tfvars
```

**Analisar o output:**
- Quantos recursos serão criados?
- Quais são os recursos?
- Há algum erro?

### Passo 4: Aplicar Infraestrutura

```bash
# Apply (vai pedir confirmação)
terraform apply -var-file=envs/dev.tfvars

# Digite 'yes' quando perguntar
```

⏱️ **Aguardar ~2-3 minutos** para criar:
- VCN com gateways
- Subnet pública
- 2 instâncias Compute

### Passo 5: Ver Outputs

```bash
# Ver todos os outputs
terraform output

# Ver output específico
terraform output instance_public_ips

# Outputs em JSON
terraform output -json
```

### Passo 6: Verificar no Console OCI

1. Abrir: https://cloud.oracle.com
2. **Networking** → **Virtual Cloud Networks** → Ver VCN criada
3. **Compute** → **Instances** → Ver instâncias
4. Copiar IPs públicos

### Passo 7: Testar SSH (Opcional)

```bash
ssh -i ~/.ssh/oci_demo_key opc@<IP_PUBLICO>
whoami
hostname
exit
```

---

## 📊 PARTE 9: Adicionar Recursos Incrementalmente (15 min)

### Passo 1: Descomentar Recursos

Editar arquivos:
- `nosql.tf` - Descomentar tabela NoSQL
- `messaging.tf` - Descomentar Queue + DLQ
- `registry.tf` - Descomentar repositórios

Ou descomentar variáveis em `variables.tf`:
```hcl
# Descomentar as variáveis de NoSQL, Queue, etc
```

### Passo 2: Planejar Novamente

```bash
terraform plan -var-file=envs/dev.tfvars
```

**Analisar:**
- Novos recursos a serem criados
- Recursos existentes não mudam

### Passo 3: Aplicar

```bash
terraform apply -var-file=envs/dev.tfvars
# Digite 'yes'
```

### Passo 4: Verificar Novos Recursos

1. **Databases** → **NoSQL** → Ver tabela
2. **Application Integration** → **Queues** → Ver fila
3. **Developer Services** → **Container Registry** → Ver repos

---

## 🔄 PARTE 10: Demonstrar Mudança (5 min)

### Alterar configuração:

```bash
# 1. Editar envs/dev.tfvars
# Exemplo: Alterar instance_count de 2 para 3

# 2. Planejar
terraform plan -var-file=envs/dev.tfvars

# 3. Aplicar
terraform apply -var-file=envs/dev.tfvars

# 4. Verificar mudança na OCI
```

---

## 🧹 PARTE 7: Destruir Recursos (IMPORTANTE!)

### Destruir via Terraform:

```bash
# Destroy (vai pedir confirmação)
terraform destroy -var-file=envs/dev.tfvars

# Digite 'yes' quando perguntar
```

⏱️ **Aguardar ~2-3 minutos** para destruir todos os recursos.

### Verificar na OCI:

- Compute → Instances → Vazio ✅
- Networking → VCN → Vazio ✅
- Databases → NoSQL → Vazio ✅

---

## 🐛 Troubleshooting

| Erro | Solução |
|------|---------|
| `NotAuthenticated` | Verificar credenciais em `terraform.tfvars` |
| `Error loading credentials` | Verificar se `~/.oci/oci_api_key.pem` existe |
| `out of host capacity` | Trocar `ad_number` no main.tf |
| `shape not available` | Alterar `instance_shape` no dev.tfvars |
| `Invalid compartment_id` | Aceita `ocid1.tenancy...` ou `ocid1.compartment...` |
| `terraform: command not found` | Instalar Terraform: https://www.terraform.io/downloads |

### Verificar Credenciais OCI

```bash
# Testar autenticação (se tiver OCI CLI instalado)
oci iam region list

# Verificar fingerprint da chave
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c
```

---

## 🎓 Fluxo Resumido

```
1. Configurar credenciais OCI
2. Clonar projeto
3. Criar terraform.tfvars
4. terraform init
5. terraform plan
6. terraform apply
7. Verificar recursos no Console OCI
8. terraform destroy (IMPORTANTE!)
```

---

## 📚 Comandos Úteis

```bash
# Ver recursos criados
terraform state list

# Ver detalhes de um recurso
terraform state show module.vcn.oci_core_vcn.vcn

# Atualizar state com estado real
terraform refresh -var-file=envs/dev.tfvars

# Ver plan salvo
terraform show plan.tfplan
```

---

**Professor:** José Neto  
**Curso:** Pós-Tech FIAP - DevOps e Arquitetura Cloud  
**Tema:** Criando Stack Completa com Terraform na OCI

---

**🚀 Happy Terraforming!**
