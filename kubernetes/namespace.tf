resource "kubernetes_namespace" "fastfood" {
  metadata {
    name = "fastfood"
  }
}