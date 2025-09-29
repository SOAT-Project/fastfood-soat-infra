resource "kubernetes_namespace" "fastfood" {
  metadata {
    name = "${var.prefix}-fastfood"
  }
}