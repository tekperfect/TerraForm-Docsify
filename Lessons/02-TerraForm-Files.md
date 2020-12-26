<!-- Lessons/02-TerraForm-Files -->
<!-- http://localhost:3000/#/Lessons/02-TerraForm-Files -->
# Cracking Terraform

## ⏱ Agenda

1. 🏆 Learning Objectives
1. 🅰️ Language & Syntax
1. ⌨️ CLI
1. ✍️ Practice
1. 📚 Resources & Credits
 
## 🏆 Learning Objectives

1. Creating a Basic Infrastructure with terraform
1. Find `provider` and associated documentation  
1. Creating `.tf*` files

## 🅰️ language

Terraform language is writin in haschicorp configuration language in `.tf` file, it is simmilar to a json format

Within every main `.tf` file or the file terraform builds off of has two main blocks: `Provider` and  `Rescource`. Each of these blocks are resposible for a specific declerative result of the terraform build. They will always follow this **syntax**

```json
<Block Type> "<Provider> or <Rescource Type>" "<Local Name>" {
    # Block body
    <IDENTIFIER> = <EXPRESSION> # Argument
}
```

### Provider

Terraform relies on plugins called "providers" and is essential to every terraform build. Providers can be thought up as libraries in traditional programing. Providers are denoted as such

```json
provider "aws" {
    region      = "us-west-1"
    access_key  = "123asd7682"
    secret_key  = "12378asdfs"
}   
```
Each infrastrucutre may have different needs, so `aws` could be part of your providers or not at all. A list of fully suported providers and supporting documentation are [here](https://registry.terraform.io/browse/providers)

### Resource

Rescource blocks build of off providers specifically their features. For `aws` we can be talking the instance e.g. VPC, Security Groups and Subnet. To state the `resource` needed from the `provider`, we state the `Block Type`: `resource` and for the `Resource Type` we state the desired feature from the provider we want to change or create

```json
resource "aws_instance" "web-server " {
  ami               = "ami-123123"
  instance_type     = "t2.micro" 
}
```
### MISC

Of course there are many other `Block Types`, but these are the main two we need to get started on a terraform and start a working ifrastructure, we will be working on blocks like `output` and `variable`. `output` is similar to a print statement in programing and `variable` is exactly what it sound like.


## ⌨️ CLI

Now that we know the basics of the terraform code, how do we `apply` our work and changes or even initialize our enviroment? That's where the terraform cli you installed comes in! Here are the three top commands you will use:


* `terraform plan` - `plan`, show the user what changes have been made to simmilar to `git diff` or `git status`


* `terraform apply` - `apply`, pushes the changes made in the `.tf` files to the infrastructure, just like `git push`. Terraform will automatically delete, add or change any rescource as mentioned int he file


* `terraform destroy` - `destory`, destorys the infrastructre you created with the `.tf` this is reccomended over manually dfestorying an instance


## ✍️ Practice




## 📚 Resources & Credits
* [Terraform AWS Register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Registry](https://registry.terraform.io/browse/providers)
* [Temporary Providers](https://www.terraform.io/docs/providers/index.html)
