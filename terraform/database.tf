# ============================================================
# DATABASE - MySQL Database Service
# ============================================================
# Equivalente AWS: RDS (Relational Database Service)
# OCI oferece MySQL Database Service totalmente gerenciado

# 🎯 LIVE: Descomentar conforme for criando os bancos de dados
# ============================================================

# -----------------------------------------------------
# Data Source - MySQL Configurations
# -----------------------------------------------------
# data "oci_mysql_mysql_configurations" "default" {
#   compartment_id = var.compartment_id

#   filter {
#     name   = "shape_name"
#     values = [var.mysql_shape]
#   }
# }

# -----------------------------------------------------
# MySQL Database System 1 - Auth Database
# -----------------------------------------------------
# resource "oci_mysql_mysql_db_system" "auth" {
#   compartment_id = var.compartment_id
#   shape_name     = var.mysql_shape
#   subnet_id      = oci_core_subnet.public.id

#   admin_username = var.mysql_admin_username
#   admin_password = var.mysql_admin_password

#   availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

#   display_name = "${var.project_name}-mysql-auth"
#   description  = "MySQL Database for Authentication Service"

#   data_storage_size_in_gb = var.mysql_storage_gb
#   hostname_label          = "mysql-auth"

#   # Configurações de backup
#   backup_policy {
#     is_enabled        = true
#     retention_in_days = 7
#     window_start_time = "02:00"
#   }

#   # MySQL Configuration
#   configuration_id = data.oci_mysql_mysql_configurations.default.configurations[0].id

#   # Porta padrão MySQL
#   port          = 3306
#   port_x        = 33060

#   freeform_tags = {
#     "Environment" = var.environment
#     "Project"     = var.project_name
#     "Database"    = "auth"
#     "Service"     = "authentication"
#   }
# }

# -----------------------------------------------------
# MySQL Database System 2 - Flag Database
# -----------------------------------------------------
# resource "oci_mysql_mysql_db_system" "flag" {
#   compartment_id = var.compartment_id
#   shape_name     = var.mysql_shape
#   subnet_id      = oci_core_subnet.public.id

#   admin_username = var.mysql_admin_username
#   admin_password = var.mysql_admin_password

#   availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

#   display_name = "${var.project_name}-mysql-flag"
#   description  = "MySQL Database for Feature Flag Service"

#   data_storage_size_in_gb = var.mysql_storage_gb
#   hostname_label          = "mysql-flag"

#   backup_policy {
#     is_enabled        = true
#     retention_in_days = 7
#     window_start_time = "03:00"
#   }

#   configuration_id = data.oci_mysql_mysql_configurations.default.configurations[0].id

#   port   = 3306
#   port_x = 33060

#   freeform_tags = {
#     "Environment" = var.environment
#     "Project"     = var.project_name
#     "Database"    = "flag"
#     "Service"     = "feature-flags"
#   }
# }

# -----------------------------------------------------
# MySQL Database System 3 - Targeting Database
# -----------------------------------------------------
# resource "oci_mysql_mysql_db_system" "targeting" {
#   compartment_id = var.compartment_id
#   shape_name     = var.mysql_shape
#   subnet_id      = oci_core_subnet.public.id

#   admin_username = var.mysql_admin_username
#   admin_password = var.mysql_admin_password

#   availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

#   display_name = "${var.project_name}-mysql-targeting"
#   description  = "MySQL Database for Targeting Service"

#   data_storage_size_in_gb = var.mysql_storage_gb
#   hostname_label          = "mysql-targeting"

#   backup_policy {
#     is_enabled        = true
#     retention_in_days = 7
#     window_start_time = "04:00"
#   }

#   configuration_id = data.oci_mysql_mysql_configurations.default.configurations[0].id

#   port   = 3306
#   port_x = 33060

#   freeform_tags = {
#     "Environment" = var.environment
#     "Project"     = var.project_name
#     "Database"    = "targeting"
#     "Service"     = "user-targeting"
#   }
# }

# -----------------------------------------------------
# Data Source - MySQL Configurations
# -----------------------------------------------------
# data "oci_mysql_mysql_configurations" "default" {
#   compartment_id = var.compartment_id

#   # Filtrar por shape
#   shape_name = var.mysql_shape

#   # Filtrar por tipo (standalone, HA, etc)
#   type = ["DEFAULT"]
# }
