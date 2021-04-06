# :recycle: Make, Docker and Docker-Compose

![image](docs/triforce.png)

A skeleton repo that makes use of `Make`, `Docker` and `docker-compose` to deploy an S3 Bucket in AWS using Terraform. This repo can be extended to include extra steps to build/pack application code. This pattern is used to minimise the dependency / reliance on `cicd` tools/agents/systems so that build and deploy steps used in `cicd` environments can be replicated exactly the same way locally.

---

## :heavy_check_mark: Prerequisites

_Make is native to MacOS and all the different flavours of linux so no installation is required._

**MacOS/Linux:**
* [Docker + docker-compose](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)

**Windows:**
* [GNU Make](http://gnuwin32.sourceforge.net/packages/make.htm)
* [Docker + docker-compose](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)

---
## :computer: Setup

1. Before running `Make` commands, you will first need to **authenticate** to the cloud provider you're using when running commands locally. `AWS` is being used in this example skeleton repo to build an S3 bucket. There are a few open source tools such as [awsume](https://awsu.me/) that can perform this task quite well, especially if having to switch to multiple accounts.

2. As `*.tfvars` and `.backend` files are gitignored for sensitivity, these will need to be created before any **terraform** step can be called as backend configs are required for each environment. Below is an example of creating a `dev.tfvars` and `dev.backend` files in the `/infra/config/dev` folder:

`./infra/config/dev/dev.backend:`
```hcl
bucket = "my-terraform-state-bucket"
region = "ap-southeast-2"
```
`./infra/config/dev/dev.tfvars:`
```hcl
environment = "dev"
region = "ap-southeast-2"
bucket_name = "my-dev-bucket"
```
---

## :mega: Usage

_All `terraform` commands can be found within the `Makeile`, but only the following are required to deploy to your environment._

Run `terraform plan` :
```makefile
make plan
```
Run `terraform comply` step which runs terraform-compliance tests against the `terraform plan` :
```makefile
make comply
```
Run `terraform apply` :
```makefile
make apply
```
---

## :bookmark_tabs: References:

* [3 Musketeers](https://3musketeers.io/)
* [Make](https://opensource.com/article/18/8/what-how-makefile/)
* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)
* [Terraform Compliance](https://terraform-compliance.com/)
