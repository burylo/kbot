# output "config_host" {
#   value = "https://${data.google_container_cluster.main.endpoint}"
# }

# output "config_token" {
#   value = data.google_client_config.current.access_token
# }

# output "config_ca" {
#   value = base64decode(
#     data.google_container_cluster.main.master_auth[0].cluster_ca_certificate,
#   )
# }

# output "name" {
#   value = data.google_container_cluster.main.name
# }

# output "FLUX_GITHUB_TARGET_PATH" {
#   value = var.FLUX_GITHUB_TARGET_PATH
# }