terraform {
  backend s3 {}
}

module "sak_kubeflow" {
  source = "../.."

  cluster_name = "german"

  owner      = "provectus"
  repository = "sak-kubeflow"
  branch     = "temp-4-german"

  #Main route53 zone id if exist (Change It)
  mainzoneid = "Z02149423PVQ0YMP19F13"

  # Name of domains (create route53 zone and ingress). Set as array, first main ingress fqdn ["example.com", "example.io"]
  domains = ["german.edu.provectus.io"]

  # ARNs of users which would have admin permissions. (Change It)
  admin_arns = [
    {
      userarn  = "arn:aws:iam::245582572290:user/rgimadiev"
      username = "rgimadiev"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::245582572290:user/gosin"
      username = "gosin"
      groups   = ["system:masters"]
    }
  ]

  # Email that would be used for LetsEncrypt notifications
  cert_manager_email = "rgimadiev@provectus.com"

  cognito_users = [
    {
      email    = "rgimadiev@provectus.com"
      username = "rgimadiev"
      group    = "administrators"
    },
    {
      email    = "gosin@provectus.com"
      username = "gosin"
      group    = "administrators"
    }
  ]

  argo_path_prefix = "examples/simple/"
  argo_apps_dir    = "argocd-applications"
}
