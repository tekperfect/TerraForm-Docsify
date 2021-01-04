# ⏱ Agenda

1. 🏆 Learning Objectives
1. Variable & Strucutres
1. Workspaces
1. 📚 Resources & Credits

## 🏆 Learning Objectives

1. Learn how to use workspaces
1. Using data structures
1. Using Vault with Terraform


### Variables & Strucutres

As we know in terraform variables are handle with: `.tfvars` and variable blocks such as these

```json
variable "example" {
    description = "This is an example"
    default     = "This is the default value"
}
```

These alones are great, but what if we had a list of information, we can't create multiple variables othewrwise it will quickly become overwhelming. So instead we have data structure like any other language, we specify these structures with `type`:

```json
variable "string_example" {
    type        =   string
    description =   "This is an example of string type"
    default     =   "This is the default value"
}
```

Just like `string` there are many type constraints and constructor e.g: 

* string
* number
* bool
* list(<type>)
* set(<type>)
* map(<type>)

By specifiying a `type` terraform knows before hand that this is how the variable is handle and can make sure you don't apply any other information. A most common use case is storing regions in a list:

```json
variable "regions" {
    type        = list(string)
    description = "Regions"
    default     =  ["us-west-1","us-west-2","us-east-1"]
}
```

And of course we can get more advance with `variables` with more attributes such as `validation`:

```json
variable "image_id" {
    type        = string
    description = "The id of the machine image (AMI) to use for the server."

    validation {
        # regex(...) fails if it cannot find a match
        condition     = can(regex("^ami-", var.image_id))
        error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
    }
}
```

There a many ways you can be creative with your terraform files, more information can be found in the documentaiton [Terraform Workspaces](https://www.terraform.io/docs/cloud/workspaces/index.html). 

### Workspaces

In a real world scenario we will be working in our respective *workspace*, typically these will be `PROD` and `DEV` enviroments. `workspaces` are most helpful by of course managaing states. In these states we can use it to dynamically change how a file can run such as tagging:

```json
resource "aws_instance" "example" {
  tags = {
    Name = "web - ${terraform.workspace}"
  }

  # ... other arguments
}
```

Type `terraform workspace` to see the appropiate commands to list,create,select, and delete workspaces


## 📚 Resources & Credits

* [Terraform Workspaces](https://www.terraform.io/docs/cli/workspaces/index.html)
* [Terraform States](https://www.terraform.io/docs/state/workspaces.html)
* [Terraform Variables & Structures](https://www.terraform.io/docs/configuration/variables.html)
* [Vault by Hashicorp](https://learn.hashicorp.com/vault)