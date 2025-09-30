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
      DATABASE_PASSWORD = var.db_password

      # Application
      APPLICATION_PORT      = var.application_port
      AUTH_TOKEN_EXPIRATION = var.auth_token_expiration

      # Mercado Pago
      MP_TOKEN    = var.mp_token
      COLLECTOR_ID = var.collector_id
      POS_ID       = var.pos_id
      MP_BASE_URL  = var.mp_base_url
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

