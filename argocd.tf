resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"

    labels = {
      "app" = "argocd"
    }
  }
}

resource "helm_release" "argocd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

}

resource "helm_release" "argo-apps" {
    name  = "argo-apps"
    chart = "./charts/argocd-apps"
}