# resource "kubernetes_namespace" "istio-system" {
#   metadata {
#     name = "istio-system"

#     labels = {
#       "app" = "istio-system"
#     }
#   }
# }

# resource "helm_release" "istio_base" {
#   name      = "istio-base"
#   namespace = kubernetes_namespace.istio-system.metadata[0].name

#   chart = "charts/istio/base"
# }

# resource "helm_release" "istio_discovery" {
#   name      = "istiod"
#   namespace = kubernetes_namespace.istio-system.metadata[0].name

#   chart = "charts/istio/istio-control/istio-discovery"

#   depends_on = [
#     helm_release.istio_base
#   ]
# }

# resource "helm_release" "istio_ingress" {
#   name      = "istio-ingress"
#   namespace = kubernetes_namespace.istio-system.metadata[0].name

#   chart = "charts/istio/gateways/istio-ingress"

#   depends_on = [
#     helm_release.istio_base,
#     helm_release.istio_discovery
#   ]
# }
