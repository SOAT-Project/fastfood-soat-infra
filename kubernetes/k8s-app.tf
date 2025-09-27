# ConfigMap
resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.fastfood.metadata[0].name
  }

  data = {
    # Database
    DATABASE_HOST = var.rds_endpoint
    DATABASE_PORT = "5432"
    DATABASE_NAME = "postgres"
    DATABASE_USER = var.db_username
    
    # Application
    APPLICATION_PORT      = "8080"
    AUTH_TOKEN_EXPIRATION = "43200"
    
    # Mercado Pago
    MP_TOKEN      = "APP_USR-2512049377508546-052123-386869c4214628b0e44f44f638bc2ebe-2448858150"
    COLLECTOR_ID  = "2448858150"
    POS_ID        = "SUC001POS001"
    MP_BASE_URL   = "https://api.mercadopago.com"
  }
}

# Secret
resource "kubernetes_secret" "db_secret" {
  metadata {
    name      = "db-secret"
    namespace = kubernetes_namespace.fastfood.metadata[0].name
  }

  data = {
    DATABASE_PASS     = var.db_password
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "fastfood_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-deployment.yaml"))

  depends_on = [
    kubernetes_namespace.fastfood
  ]
}

resource "kubernetes_manifest" "fastfood_service" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-service.yaml"))

  depends_on = [
    kubernetes_namespace.fastfood
  ]
}

resource "kubernetes_manifest" "fastfood_hpa" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-hpa.yaml"))

  depends_on = [
    kubernetes_namespace.fastfood
  ]
}

