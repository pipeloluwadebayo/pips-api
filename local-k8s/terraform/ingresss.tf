resource "kubernetes_ingress_v1" "pips_api" {
  metadata {
    name = "pips-api-ingress"
    namespace = "test"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    rule {
      host = "pips-api.local"

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.pips_api.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
