resource "kubernetes_deployment" "pips_api" {
  metadata {
    name = "pips-api"
    namespace = "test"
    labels = {
      app = "pips-api"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "pips-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "pips-api"
        }
      }

      spec {
        container {
          name  = "flask-api"
          image = "pipeloluwa/pips-api:latest"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}
