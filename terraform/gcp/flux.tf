module "flux_bootstrap" {
  source            = "github.com/burylo/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = ".terraform/modules/gke_cluster/kubeconfig"# module.gke_cluster.kubeconfig
  github_token      = var.GITHUB_TOKEN
}