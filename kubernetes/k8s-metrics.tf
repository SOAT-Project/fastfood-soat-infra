resource "kubernetes_manifest" "ms_clusterroles" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-clusterroles.yaml"))
}

resource "kubernetes_manifest" "ms_clusterroles_reader" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-clusterrolesreader.yaml"))
}

resource "kubernetes_manifest" "ms_clusterrolebindings" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-clusterrolebindings.yaml"))
}

resource "kubernetes_manifest" "ms_rolebindings" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-rolebindings.yaml"))
}

resource "kubernetes_manifest" "ms_serviceaccount" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-serviceaccount.yaml"))
}

resource "kubernetes_manifest" "ms_service" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-service.yaml"))
}

resource "kubernetes_manifest" "ms_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/metrics-server/ms-deployment.yaml"))
}