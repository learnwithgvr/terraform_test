# Terrraform Test with EC2 Instnace

## Project tree

```bash
.
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
├── variables.tf
└── z_mytests.tftest.hcl
```

### Test file

unittests.tftest.hcl

#### Commands to Run

```bash
terraform test -var-file=env_tfvars/dev.tfvars
```
