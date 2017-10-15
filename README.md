# terraform-google-storage-bucket
Terraform module : GCP : for creation storage buckets


## Usage

* Simple example

```terraform
module "s3_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name = ["my-bucket"]
}
```
* Example with ACL

```terraform
module "s3_service_account" {
  source     = "git::https://github.com/SweetOps/terraform-google-service-account.git?ref=master"
  account_id = "some-sa"
  role       = "roles/storage.objectViewer"
}


module "s3_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name = ["my-bucket", "my-bucket-1"]
  role_entity = ["READER:user-${module.s3_service_account.email}"]
}
```
## Inputs

| Name                  | Description                                                                                                                                                         |  Type  |      Default      | Required |
|:----------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------:|:-----------------:|:--------:|
| action_storage_class  | The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE.                        | string |    `NEARLINE`     |    no    |
| action_type           | The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass.                                                                | string | `SetStorageClass` |    no    |
| age                   | Minimum age of an object in days to satisfy this condition.                                                                                                         | string |       `60`        |    no    |
| name                  | The name of the bucket.                                                                                                                                             |  list  |         -         |   yes    |
| created_before        | Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.                                                                                 | string |   `2017-06-13`    |    no    |
| default_acl           | Configure this ACL to be the default ACL.                                                                                                                           | string |     `private`     |    no    |
| force_destroy         | When deleting a bucket, this boolean option will delete all contained objects.                                                                                      | string |      `false`      |    no    |
| is_live               | Relevant only for versioned objects. If true, this condition matches live objects, archived objects otherwise.                                                      | string |      `false`      |    no    |
| location              | The GCS location.                                                                                                                                                   | string |        ``         |    no    |
| matches_storage_class | Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY. |  list  |     `<list>`      |    no    |
| num_newer_versions    | Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.                                                           | string |       `10`        |    no    |
| project               | The project in which the resource belongs. If it is not provided, the provider project is used.                                                                     | string |        ``         |    no    |
| role_entity           | List of role/entity pairs in the form ROLE:entity.                                                                                                                  |  list  |     `<list>`      |    no    |
| storage_class         | The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE.                                                        | string |    `REGIONAL`     |    no    |
| versioning_enabled    | While set to true, versioning is fully enabled for this bucket.                                                                                                     | string |      `true`       |    no    |


## Outputs

| Name      | Description                                                   |
|:----------|:--------------------------------------------------------------|
| name      | The name of bucket.                                           |
| self_link | The URI of the created resource.                              |
| url       | The base URL of the bucket, in the format gs://<bucket-name>. |
