# Fastfood - Infraestrutura 🍔

Este repositório contém a infraestrutura necessária para rodar a aplicação **Fastfood** no **Amazon EKS**.

---

## 📂 Estrutura do projeto

- **/infra** → Provisionamento da infraestrutura base com **Terraform**:
  - VPC com subnets públicas e privadas
  - Internet Gateway (IGW) para acesso externo
  - NAT Gateway e route tables para comunicação das subnets privadas
  - Cluster EKS com addons gerenciados

- **/kubernetes** → Manifests Kubernetes para rodar a aplicação no cluster:
  - Namespace
  - Deployment.
  - Service (LoadBalancer)
  - HPA

> ⚠️ O **RDS PostgreSQL** é provisionado em outro repositório e deve estar disponível antes do deploy da aplicação.

---

## 🚀 Passo a passo

### 1. Subir infraestrutura base

No diretório `/infra`:

```bash
cd infra
terraform init
terraform apply
```

Isso provisiona toda a rede (VPC, subnets, IGW, NAT, rotas) e o cluster EKS.

### 2. Subir banco de dados (RDS)

O RDS está em outro repositório. Certifique-se de:
* Criar o banco no mesmo VPC/subnets privadas.
* Atualizar as variáveis de conexão da aplicação.

* ### 3. Configurar acesso ao EKS

Após a criação do cluster, rode o comando abaixo para configurar o `kubectl`:

```bash
aws eks --region sa-east-1 update-kubeconfig --name fastfood-eks
```


### 4. Deploy no Kubernetes

Após a infraestrutura e o RDS estarem prontos, aplicar os manifests no cluster:

```bash
cd kubernetes
terraform init
terraform apply
```

Isso cria o namespace, deployment, service (LoadBalancer) e o HPA.

---

## ✅ Resultado esperado

* Aplicação **Fastfood** rodando no EKS, exposta via LoadBalancer.
* Escalabilidade automática configurada pelo HPA.
* Banco de dados externo no RDS integrado à aplicação.

---

## 🔍 Como acessar

Obter o endpoint público do LoadBalancer:

```bash
kubectl get svc -n fastfood
```

E acessar o Swagger UI em:

```
http://<EXTERNAL-IP>/api/swagger-ui/index.html
```
