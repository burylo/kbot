variable "GITHUB_OWNER" {
  description = "Github username"
  type = string
}

variable "GITHUB_TOKEN" {
  description = "GitHub API token"
  type = string
}

variable "FLUX_GITHUB_REPO" {
  description = "Repo to use with Flux"
  type = string
}

variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}