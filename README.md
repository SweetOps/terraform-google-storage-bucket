# terraform-google-storage-bucket
Terraform module : GCP : for creation storage buckets


* Simple example

```hcl
module "awesome_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "awesome"
  stage       = "production"
  namespace   = "sweetops"
  location    = "europe-west1"
}
```
* Example with ACL

```hcl
module "awesome_bucket_user" {
  source     = "git::https://github.com/SweetOps/terraform-google-service-account.git?ref=master"
  name       = "awesome"
  stage      = "production"
  namespace  = "sweetops"
}


module "awesome_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "awesome"
  stage       = "production"
  namespace   = "sweetops"
  role_entity = ["READER:user-${module.awesome_bucket_user.email}"]
  location    = "europe-west1"
}
```

## Inputs

| Name                  | Description                                                                                                                                                         |  Type  |       Default       | Required |
|:----------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------:|:-------------------:|:--------:|
| name                  | Solution name, e.g. 'app' or 'jenkins'                                                                                                                              | string |         n/a         |   yes    |
| namespace             | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'                                                                                 | string |         n/a         |   yes    |
| stage                 | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'                                                                             | string |         n/a         |   yes    |
| action_storage_class  | The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE.                        | string |    `"NEARLINE"`     |    no    |
| action_type           | The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass.                                                                | string | `"SetStorageClass"` |    no    |
| age                   | Minimum age of an object in days to satisfy this condition.                                                                                                         | string |       `"60"`        |    no    |
| attributes            | Additional attributes (e.g. `1`)                                                                                                                                    |  list  |        `[]`         |    no    |
| context               | Default context to use for passing state between label invocations                                                                                                  |  map   |        `{}`         |    no    |
| created_before        | Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.                                                                                 | string |        `""`         |    no    |
| default_acl           | Configure this ACL to be the default ACL.                                                                                                                           | string | `"projectPrivate"`  |    no    |
| delimiter             | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`                                                                           | string |        `"-"`        |    no    |
| enabled               | Set to false to prevent the module from creating any resources                                                                                                      | string |      `"true"`       |    no    |
| environment           | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'                                                                                                       | string |        `""`         |    no    |
| force_destroy         | When deleting a bucket, this boolean option will delete all contained objects.                                                                                      | string |      `"false"`      |    no    |
| is_live               | Relevant only for versioned objects. If true, this condition matches live objects, archived objects otherwise.                                                      | string |      `"false"`      |    no    |
| kms_key_name          | A Cloud KMS key that will be used to encrypt objects inserted into this bucket                                                                                      | string |        `""`         |    no    |
| matches_storage_class | Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY. |  list  |  `[ "REGIONAL" ]`   |    no    |
| num_newer_versions    | Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.                                                           | string |       `"10"`        |    no    |
| project               | The project in which the resource belongs. If it is not provided, the provider project is used.                                                                     | string |        `""`         |    no    |
| location              | The GCS region.                                                                                                                                                     | string |        `""`         |    no    |
| role_entity           | List of role/entity pairs in the form ROLE:entity.Must be set if predefined_acl is not.                                                                             |  list  |        `[]`         |    no    |
| storage_class         | The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE.                                                        | string |    `"REGIONAL"`     |    no    |
| tags                  | Additional tags (e.g. `map('BusinessUnit','XYZ')`                                                                                                                   |  map   |        `{}`         |    no    |
| versioning_enabled    | While set to true, versioning is fully enabled for this bucket.                                                                                                     | string |      `"true"`       |    no    |

## Outputs

| Name      | Description                                                   |
|:----------|:--------------------------------------------------------------|
| name      | The name of bucket.                                           |
| self_link | The URI of the created resource.                              |
| url       | The base URL of the bucket, in the format gs://<bucket-name>. |
