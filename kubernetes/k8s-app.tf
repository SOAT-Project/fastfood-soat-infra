resource "kubernetes_manifest" "app_config" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-config.yaml"))
}

resource "kubernetes_manifest" "db_secret" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-db-secret.yaml"))
}

resource "kubernetes_manifest" "fastfood_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-deployment.yaml"))
}

resource "kubernetes_manifest" "fastfood_service" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-service.yaml"))
}

resource "kubernetes_manifest" "fastfood_hpa" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-fastfood-hpa.yaml"))
}

resource "kubernetes_manifest" "postgres_pvc" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-postgres-pvc.yaml"))
}

resource "kubernetes_manifest" "postgres_service" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-postgres-service.yaml"))
}

resource "kubernetes_manifest" "postgres_statefulset" {
  manifest = yamldecode(file("${path.module}/k8s/app/app-postgres-statefulset.yaml"))
}