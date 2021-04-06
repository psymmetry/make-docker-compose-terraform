# Triforce

A skeleton repo that makes use of `Make`, `Docker` and `docker-compose`. A pattern used to minimise the dependency / reliance on `cicd` tools/agents/systems so that build and deploy steps used in `cicd` environments can be replicated exactly the same way locally.

---

## Prerequisites

_Make is native to MacOS and all the different flavours of linux so no installation is required._

**MacOS/Linux:**
* [Docker + docker-compose](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)

**Windows:**
* [GNU Make](http://gnuwin32.sourceforge.net/packages/make.htm)
* [Docker + docker-compose](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)

---
## Usage

_Before running `Make` commands, you will first need to **authenticate** to the cloud provider you're using when running commands locally. `AWS` is being used in this example skeleton repo to build an S3 bucket._

Run `terraform plan` :
```
make plan
```
Run `terraform comply` step which runs terraform-compliance tests against the `terraform plan` :
```
make comply
```
Run `terraform apply` :
```
make apply
```
---

## References:

* https://3musketeers.io/
* https://terraform-compliance.com/