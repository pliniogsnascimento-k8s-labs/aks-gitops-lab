resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  values           = ["${file("${path.module}/charts/argocd/values.yaml")}"]
}

resource "helm_release" "argo_rollouts" {
  name             = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argo-rollouts"
  create_namespace = true
  version          = "2.37.2"

  values = ["${file("${path.module}/charts/argocd/values-rollouts.yaml")}"]
}

resource "helm_release" "argo-apps" {
  name             = "argo-apps"
  chart            = "./charts/argocd-apps"
  namespace        = "argocd"
  version          = "5.51.6"
  create_namespace = true

  depends_on = [
    helm_release.argocd
  ]
}
