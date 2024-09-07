
# Repositório de Infraestrutura como Código (IaC)

Este repositório contém arquvios de Terraform e Terragrunt para criar e gerenciar recusrsos no Google Cloud em infraestrutura como código.
Com ele você é capaz de criar os seguintes grupos de recursos.

Group 1
- Module gcs
- Module network/vpc/vpc-a
- Module network/vpc/vpc-b

Group 2
- Module network/subnets/subnet-1a
- Module network/subnets/subnet-1b

Group 3
- Module network/network_peering

Group 4
- Module gke/clusters/cluster-a
- Module gke/clusters/cluster-b

Group 5
- Module gke/resources/nginx
- Module gke/resources/rabbitmq



## Estrutura de Pastas

- `modules/`: Módulos reutilizáveis do Terraform.
- `terragrunt/`: Configurações do Terragrunt para o Terraform.
- `README,md`

## Pré-requisitos

- Terraform
- Terragrunt
- gcloud cli

## Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/rogerlima95/infra-as-code.git
   ```
2. Navegue até o diretório `terragrunt/` e ajuste as configurações conforme necessário.
3. Aplique as mudanças usando o Terragrunt:
   ```bash
   terragrunt run-all apply
   ```
4. Você tambem pode criar os recursos individualmente, executando `terragrunt apply` dentro de cada diretorio seguindo o grupo de módulos informado acima.

## Contribuições

Sinta-se à vontade para enviar issues ou pull requests para melhorias.
