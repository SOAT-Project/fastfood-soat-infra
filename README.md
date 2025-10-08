# Fastfood EKS Infrastructure 🍔

Este repositório provisiona e gerencia toda a infraestrutura Kubernetes (EKS) e seus recursos associados na AWS utilizando **Terraform** e **GitHub Actions**.

---

## 📂 Estrutura do projeto

- **/infra** → Cluster EKS (Terraform)
- **/kubernetes** → Recursos Kubernetes (Deployments, Services, HPA, etc.)


## ⚙️ Pré-requisitos

Antes de aplicar o projeto, é necessário que os seguintes recursos **já existam**:

- 🧩 **Rede (VPC, Subnets, IGW, NAT, Route Tables)** – disponível no repositório do *database*  
- 🗄️ **RDS** configurado e acessível  
- 🪣 **S3 Bucket** para backend do Terraform  
- 📚 **DynamoDB Table** para controle de *lock* do Terraform  

---

## 🧭 Fluxo de Deploy

O processo é dividido em duas etapas principais:

1. **Infraestrutura (EKS)** – aplica o módulo localizado em `/infra`  
2. **Recursos Kubernetes** – aplica os manifests de `/kubernetes` no eks já provisionado  
   - Deploy da aplicação  
   - LoadBalancer  
   - ConfigMap e Secret  
   - HPA  
   - Metrics Server  

---

## ⚡ CI/CD via GitHub Actions

Os pipelines automatizados executam **deploy** ou **destroy** separados por ambiente (`prod` ou `release`).

### 🔁 Fluxo de Deploy

1. Lê as **secrets** do ambiente  
2. Verifica o tipo de execução via `destroy_config.json`  
3. Se for **deploy**:
   - Aplica o módulo `/infra`  
   - Aplica os recursos `/kubernetes`  
   - Executa um *job* final para listar todos os recursos do cluster via `kubectl`

### 💣 Fluxo de Destroy

1. Destroi todos os recursos do diretório `/kubernetes`  
2. Destroi o módulo `/infra`

---

## 🧠 Observações

- As actions separam o fluxo por **ambiente (prod/release)**  
- Toda a configuração é automatizada via Terraform e GitHub Actions  
- É necessário garantir que o backend (S3 + DynamoDB) esteja configurado antes de qualquer execução

---

## 🌐 API Gateway - Integração e Fluxo

A infraestrutura utiliza o **API Gateway** para expor os endpoints da aplicação Fastfood, roteando requisições para o EKS (via ALB) e para Lambdas (autorização e middleware).

### Ordem de Provisionamento

1. **EKS e ALB**  
   O cluster EKS e o Application Load Balancer (ALB) precisam estar provisionados antes do API Gateway, pois o Gateway faz proxy para o ALB.

2. **Lambdas**  
   As funções Lambda de autenticação e middleware devem ser criadas antes do deploy do API Gateway, pois são referenciadas como authorizer e integração.

3. **API Gateway**  
   Após EKS, ALB e Lambdas prontos, o módulo `api.gateway` pode ser aplicado normalmente.

### Como funciona o roteamento

- **/auths/client (POST) e /auths/staff (POST)**  
  Roteiam para a Lambda de autenticação, responsável por gerar o JWT.

- **/clients (POST)**  
  Rota aberta, encaminha diretamente para o EKS via ALB (`/api/clients`).

- **/{proxy+} (ANY)**  
  Rota protegida por authorizer Lambda, faz proxy para o EKS via ALB (`/api/{proxy}`).

### Deploy

O deploy do API Gateway é feito via GitHub Actions, nos merges para os branches `main` ou `release`. O workflow executa:

- Leitura de variáveis e secrets (ARNs do ALB, Lambdas, etc)
- Provisionamento do API Gateway com Terraform
- Notificação de status no Discord