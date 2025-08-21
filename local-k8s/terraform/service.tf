resource "kubernetes_service" "pips_api" {
  metadata {
    name = "pips-api"
    namespace = "test"
  }

  spec {
    selector = {
      app = "pips-api"
    }

    port {
      port        = 5000
      target_port = 5000
      node_port   = 30080
    }

    type = "NodePort"
  }
}
