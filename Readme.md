# Terrraform Test with EC2 Instnace

## Project tree

```bash
├── Readme.md
├── caller.tf
├── env_tfvars
│   ├── dev.tfvars
│   ├── qa.tfvars
│   └── uat.tfvars
├── modules
│   └── ec2
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tf
│       └── variables.tf
├── provider.tf
├── tests
│   ├── keypair_create
│   │   └── main.tf
│   └── keypair_lookup
│       └── main.tf
├── unittests.tftest.hcl
└── variables.tf
```

### Test file

unittests.tftest.hcl

#### Commands to Run the terraform plan

```bash
terraform plan -var-file=env_tfvars/dev.tfvars
terraform plan -var-file=env_tfvars/qa.tfvars
terraform plan -var-file=env_tfvars/uat.tfvars
```

#### Commands to Run the terraform tests

```bash
terraform test -var-file=env_tfvars/dev.tfvars
```

#### Commands to Run the terraform tests with specific test file

```bash
terraform test -var-file=env_tfvars/dev.tfvars -filter unittest2.tftest.hcl
```
 <hr />
 
### Youtube video tutorial

- [Terraform Test - Terraform v1.6.0 Native Test Framework](https://www.youtube.com/watch?v=o5mtHtfR45Q)
