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
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| google | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| default\_kms\_key\_name | The `id` of a Cloud KMS key that will be used to encrypt objects inserted into this bucket, if no encryption method is specified. | `string` | `null` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `"-"` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| force\_destroy | When deleting a bucket, this boolean option will delete all contained objects. | `bool` | `false` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| label\_key\_case | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `"lower"` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| lifecycle\_rules | The list of bucket Lifecycle Rules.<br>  action:<br>    type:<br>      The type of the action of this Lifecycle Rule. Allowed values: `Delete` and `SetStorageClass`.<br>    storage\_class:<br>      The target Storage Class of objects affected by this Lifecycle Rule.<br>      Required if action type is `SetStorageClass`.<br>      Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.<br>  condition:<br>    age:<br>      Minimum age of an object in days to satisfy this condition.<br>    created\_before:<br>      Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    with\_state:<br>      Match to live and/or archived objects. Unversioned buckets have only live objects. <br>      Allowed values: `LIVE`, `ARCHIVED`, `ANY`.<br>    matches\_storage\_class:<br>      Storage Class of objects to satisfy this condition.<br>      Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.<br>    num\_newer\_versions:<br>      Relevant only for versioned objects. <br>      The number of newer versions of an object to satisfy this condition.<br>    custom\_time\_before:<br>      Creation date of an object in RFC 3339 (e.g. `2017-06-13`) to satisfy this condition.<br>    days\_since\_custom\_time:<br>      Date in RFC 3339 (e.g. `2017-06-13`) when an object's Custom-Time metadata is earlier than the date specified in this condition.<br>    days\_since\_noncurrent\_time:<br>      Relevant only for versioned objects. <br>      Number of days elapsed since the noncurrent timestamp of an object.<br>    noncurrent\_time\_before:<br>      Relevant only for versioned objects. <br>      The date in RFC 3339 (e.g. `2017-06-13`) when the object became nonconcurrent. | <pre>set(object({<br>    action    = any<br>    condition = any<br>  }))</pre> | `[]` | no |
| location | The GCS region. | `string` | `null` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| project | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| retention\_policy | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained.<br>  is\_locked:<br>    If set to `true`, the bucket will be locked and permanently restrict edits to the bucket's retention policy.<br>  retention\_period:<br>    The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. | <pre>object({<br>    is_locked        = bool<br>    retention_period = number<br>  })</pre> | `null` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| storage\_class | The Storage Class of the new bucket. Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`. | `string` | `"REGIONAL"` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| versioning\_enabled | While set to `true`, versioning is fully enabled for this bucket. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of bucket |
| self\_link | The URI of the created resource |
| url | The base URL of the bucket, in the format gs://<bucket-name> |

<!--- END_TF_DOCS --->

## License
The Apache-2.0 license
