resource "kubernetes_namespace" "nginx-ingress" {
  metadata {
    name = "nginx-ingress"

    labels = {
      "app" = "nginx-ingress"
    }
  }
}

resource "helm_release" "ingress-nginx" {
  name       = "nginx-ingress"
  namespace  = kubernetes_namespace.nginx-ingress.metadata[0].name
  chart      = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
}
