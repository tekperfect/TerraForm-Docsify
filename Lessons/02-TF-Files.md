<!-- Lessons/02-TF-Files -->
<!-- http://localhost:3000/#/Lessons/02-TF-Files -->
# 🐣 Cracking Terraform

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

Within every main `.tf` file or the file terraform builds off of has two main blocks: `provider` and  `rescource`. Each of these blocks are resposible for a specific declerative result of the terraform build. They will always follow this **syntax**

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

Rescource blocks build of off providers specifically their features. For `aws` we can be talking the instance e.g. VPC, Security Groups and Subnet. To state the `resource` needed from the `provider`, we state the `Block Type`: `resource` and for the `Resource Type` we state the desired feature from the provider we want to change or create and the following is the local name within the code so you can refrence it.


```json
resource "aws_instance" "web-server " {
  ami               = "ami-123123"
  instance_type     = "t2.micro" 
}
```
#### Modifying Rescources

Modifying rescources demontrates the power Terraform has, if you want to delete a certain rescource or even a name, Terraform is smart enough to see the difference in changes and delete it. For example if you had: 

```json
resource "aws_instance" "web-server " {
  ami               = "ami-123123"
  instance_type     = "t2.micro"
  tags = {
    ...
  } 
}
```

And you removed all the entire of `tags` and `terraform apply`, terraform will delete everything and keep the instance.


### MISC

Of course there are many other `Block Types`, but these are the main two we need to get started on a terraform and start a working ifrastructure, we will be working on blocks like `output` and `variable`. `output` is similar to a print statement in programing and `variable` is exactly what it sound like.


## ⌨️ CLI

Now that we know the basics of the terraform code, how do we `apply` our work and changes or even initialize our enviroment? That's where the terraform cli you installed comes in! Here are the four top commands you will use:

* `terraform init` - `init`, intializes the current directory for terraform development!

* `terraform plan` - `plan`, show the user what changes have been made to simmilar to `git diff` or `git status`

* `terraform apply` - `apply`, pushes the changes made in the `.tf` files to the infrastructure, just like `git push`. Terraform will automatically delete, add or change any rescource as mentioned int he file

* `terraform destroy` - `destory`, destorys the infrastructre you created with the `.tf` this is reccomended over manually dfestorying an instance


## ✍️ Practice

> tip: Always look between your terraform console and your aws console to see the changes!

We will do the following:

* Initialize the directory
* Create a ec2 instance on AWS
* Assign it a name
* Output information related to the instance
  * Server id
  * Server private ip
  * Assigned name

So we know from the aws [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), to connect to our aws provider we need a region and our [aws credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

```json
provider "aws" {
    region      = "us-west-1"
    access_key  = "AKIAIOSFODNN7EXAMPLE"
    secret_key  = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
} 
```

Now we can't have our keys open, that's devops 101, so how can we hide them?


<!-- tabs:start -->
### **Variables**

### Variables
Both Method would require us using variables and in terraform, we use the `var.name` method to access variables, denoted as such:


```json
provider "aws" {
    region      = "us-west-1"
    access_key  =  var.access_key
    secret_key  =  var.secret_key
} 
```

#### Enviorment variables `TF_VAR_name`

This method we will create enviroment variables in the terminal. Terraform [prioritizes](https://www.terraform.io/docs/configuration/variables.html) enviroment variables over anything other method and must follow this pattern: `TF_VAR_name`

```bash
export TF_VAR_access_key=AKIAIOSFODNN7EXAMPLE
export TF_VAR_secret_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```
Pros:
* Overwrite variables you want to change
* Zero possibility being track to source control
* Fast for a simple check

Cons:
* Only temporary
* Not suitable for long projects
* Lost if you clost the terminal

#### Using `.tfvars`

This method would require us to create a file name `secret.tfvars` and in the file  we can record our keys.

 **MAKE SURE TO ADD THE FILE TO THE GITIGNORE**.


```tf
access_key=AKIAIOSFODNN7EXAMPLE
secret_key=wJalrXUtnFEMI/K7MDENG/
```

Since the file does not have the default name, `terraform.tvfars` we have to use the `-var-file=` flag

```bash
terraform apply \
  -var-file="secret.tfvars"
```

### **AWS config**

### Config

This method is unique to the aws `provider`, so be sure to read your provider documentation if they have any other way


```json
provider "aws" {
  region           = "us-west-1"
  credentials_file = "~/.aws/creds"
}
```
<!-- tabs:end -->

After we specify the provider go ahead and run `terraform init`, so terraform can download all the aws files. Then run `terraform apply` to make sure your keys are correct. Then we will create an instance, so again refer to the documentation we know the rescource name is `aws_instance` and we learn the required pieces of information needed here is the ami and instance_type, So lets go to the aws console and go through the steps to create an [instance](https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:)


![Machine Image](../images/ami.png)


![Instance Type](../images/instance_type.png)

Now that we know both the `instance_type` and `ami`, let's apply iy:

```json
resource "aws_instance" "web-server" {
  ami               = "ami-03130878b60947df3"
  instance_type     = "t2.micro" 
}
```
Now go ahead and complelete teh left over objectives on your own

### Hints

<details>
  <summary>Output</summary>

  Use the `output` block ex.:
  ```json
  output "name" {

  }
  ```
</details>

<details>
  <summary>What it should look like</summary>

  [folder](https://github.com/tekperfect)
  ### main.tf
  ```json

  provider "aws" {
    region      = "us-west-1"
    access_key  = var.access_key
    secret_key  = var.secret_key
  } 

  resource "aws_instance" "web-server" {
    ami               = "ami-00831fc7c1e3ddc60"
    instance_type     = "t2.micro"
    tags = {
      name = "web-server"
    }
  }

  output "server_private_ip" {
    value = aws_instance.web-server.private_ip
  }

  output "server_id" {
    value = aws_instance.web-server.id
  }

  output "server_name" {
    value = aws_instance.web-server.name
  } 


  ```
  ### secret.tfvars 
  ```json
  access_key=YOUR_KEY
  secret_key=YOUR_KEY
  ```
  
</details>



## 📚 Resources & Credits
* [Terraform AWS Register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Registry](https://registry.terraform.io/browse/providers)
* [Temporary Providers](https://www.terraform.io/docs/providers/index.html)