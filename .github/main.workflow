workflow "Terraform" {
  resolves = "terraform-validate"
  on       = "pull_request"
}

workflow "Release" {
  on = "push"
  resolves = ["goreleaser"]
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "terraform-fmt" {
  uses    = "hashicorp/terraform-github-actions/fmt@v0.3.5"
  needs   = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]

  env = {
    TF_ACTION_WORKING_DIR = "."
  }
}

action "terraform-init" {
  uses    = "hashicorp/terraform-github-actions/init@v0.3.5"
  needs   = "terraform-fmt"
  secrets = ["GITHUB_TOKEN"]

  env = {
    TF_ACTION_WORKING_DIR = "./tests"
  }
}

action "terraform-validate" {
  uses    = "hashicorp/terraform-github-actions/validate@v0.3.5"
  needs   = "terraform-init"
  secrets = ["GITHUB_TOKEN"]

  env = {
    TF_ACTION_WORKING_DIR = "./tests"
  }
}

action "is-tag" {
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "goreleaser" {
  uses = "docker://goreleaser/goreleaser"
  secrets = ["GITHUB_TOKEN"]
  args = "release"
  needs = ["is-tag"]
}
