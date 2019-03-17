module "my_awesome_bucket" {
  source    = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name      = "bucket"
  stage     = "production"
  namespace = "sweetops"
}
