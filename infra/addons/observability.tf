locals {
  new_relic_namespace    = "newrelic"
  new_relic_release_name = "newrelic-bundle"
}

resource "kubernetes_namespace_v1" "new_relic" {
  metadata {
    name = local.new_relic_namespace
  }
}

resource "kubernetes_secret_v1" "new_relic_license" {
  metadata {
    name      = "newrelic-license"
    namespace = kubernetes_namespace_v1.new_relic.metadata[0].name
  }

  type = "Opaque"

  data = {
    licenseKey = var.new_relic_license_key
  }
}

resource "helm_release" "new_relic" {
  name       = local.new_relic_release_name
  namespace  = kubernetes_namespace_v1.new_relic.metadata[0].name
  repository = "https://helm-charts.newrelic.com"
  chart      = "nri-bundle"
  version    = "8.0.12"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 600
  wait            = true
  wait_for_jobs   = true

  values = [
    yamlencode({
      global = {
        cluster                = data.terraform_remote_state.cluster.outputs.eks_cluster_name
        customSecretName       = kubernetes_secret_v1.new_relic_license.metadata[0].name
        customSecretLicenseKey = "licenseKey"
        lowDataMode            = true
        customAttributes = {
          environment = "aws"
          project     = "oficina-mecanica"
        }
      }

      "newrelic-infrastructure" = {
        enabled = true
      }

      "nri-metadata-injection" = {
        enabled = true
      }

      "kube-state-metrics" = {
        enabled = true
      }

      "nri-prometheus" = {
        enabled = false
      }

      "nri-kube-events" = {
        enabled = false
      }

      "newrelic-logging" = {
        enabled = false
      }

      "newrelic-pixie" = {
        enabled = false
      }

      "k8s-agents-operator" = {
        enabled = false
      }
    })
  ]

  depends_on = [kubernetes_secret_v1.new_relic_license]
}
