module "my_awesome_bucket" {
  source    = "../"
  name      = "bucket"
  stage     = "production"
  namespace = "sweetops"
}

module "my_awesome_bucket_1" {
  source    = "../"
  name      = "bucket"
  stage     = "production"
  namespace = "sweetops"
  enabled   = false
}
