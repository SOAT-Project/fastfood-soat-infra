# fastfood-soat-infra
Repositório para armazenar a estrutura Kubernetes e IaC.

## Inicialização do Backend

O estado do Terraform (`tfstate`) é armazenado remotamente em um bucket S3.

> ⚠️ O bucket **não deve ser criado pelo Terraform**, pois o backend precisa existir antes da inicialização.  
> Portanto, crie manualmente com o comando abaixo:

```bash
aws s3api create-bucket \
  --bucket bucket-for-backend-tf-fastfood-soat \
  --region sa-east-1 \
  --create-bucket-configuration LocationConstraint=sa-east-1

Para limpar e deletar o bucket:

# Apaga todos os objetos do bucket
aws s3 rm s3://bucket-for-backend-tf-fastfood-soat --recursive

# Depois de vazio, apaga o bucket
aws s3api delete-bucket --bucket bucket-for-backend-tf-fastfood-soat --region sa-east-1
