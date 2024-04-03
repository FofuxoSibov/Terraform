#Chamada da Extensão Terraform - Precisa estar instalado anteriormente
terraform {
  required_version = ">= 1.7.0" # Obrigatorio estar com a versão 1.6.0 ou superior

  #Escolher o provedor - AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

#Definir padrões de uso do meu ambiente na AWS
provider "aws" {
  region                   = "us-east-1" #Definir Região
  shared_config_files      = ["C:/Users/danilo.sibov/.aws/config"]
  shared_credentials_files = ["C:/Users/danilo.sibov/.aws/credentials"] #Definir ID conta e Key

  default_tags {
    tags = {
      owner      = "Fofuxo"
      managed-by = "Terraform134"
    }
  }
}

