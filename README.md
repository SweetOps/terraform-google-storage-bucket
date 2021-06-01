# terraform-google-storage-bucket
Terraform module to create and manage the storage bucket.


## Usage

```hcl
module "awesome_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "awesome"
  stage       = "production"
  namespace   = "sweetops"
  location    = "europe-west1"
}
```

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->

## License
The Apache-2.0 license
