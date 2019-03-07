provider "kubernetes" {}
resource "kubernetes_pod" "nginx" {
  metadata {
    name      = "tf-example"
  }
  spec {
    container {
      image   = "nginx:latest"
      name    = "nginx"
      env {
        name  = "aliyun_logs_test"
        value = "stdout"
      }
    }
  }
}
