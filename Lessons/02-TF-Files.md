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

1. Creating a Basic Infrastructure with Terraform
1. Find `provider` and associated documentation  
1. Creating `.tf*` files

## 🅰️ Language

Terraform language is written in Haschicorp configuration language in `.tf` file, it is similar to a json format.

Every main `.tf` file builds off of two main blocks: `provider` and  `rescource`. Each of these blocks are responsible for a specific declarative result of the Terraform build. They will always follow this **syntax**.

```json
<Block Type> "<Provider> or <Rescource Type>" "<Local Name>" {
    # Block body
    <IDENTIFIER> = <EXPRESSION> # Argument
}
```

### Provider

Terraform relies on plugins called "providers," which are essential to every Terraform build. Providers can be thought of as libraries in traditional programming. Providers are denoted as such:

```json
provider "aws" {
    region      = "us-west-1"
    access_key  = "123asd7682"
    secret_key  = "12378asdfs"
}   
```

Each infrastrucutre may have different needs, so `aws` could be part of your providers or not at all. A list of fully suported providers and supporting documentation are [here](https://registry.terraform.io/browse/providers).

### Resource

Resource blocks build off of providers, specifically their features. For `aws`, we can be talking about the instance VPC, Security Groups, and Subnet. To state the `resource` needed from the `provider`, we state the `Block Type`: `resource` and for the `Resource Type` we state the desired feature from the provider we want to change or create, and the following is the local name within the code so you can reference it.

```json
resource "aws_instance" "web-server " {
  ami               = "ami-123123"
  instance_type     = "t2.micro" 
}
```

#### Modifying Resources

Modifying resources demonstrates the power Terraform has. If you want to delete a certain resource or even its tags, Terraform is smart enough to see the difference in changes and delete it. For example if you had: 

```json
resource "aws_instance" "web-server " {
  ami               = "ami-123123"
  instance_type     = "t2.micro"
  tags = {
    ...
  } 
}
```

If you removed the entirety of `tags` and then applied it with `terraform apply`, Terraform will delete everything modifying the instance and keep the instance.

### MISC

Of course, there are many other `Block Types`, but these are the main two we need to get started on a Terraform and start a working infrastructure. You will be working on blocks like `output` and `variable` on your own. But here is a short explanation on how `output` is similar to a print statement in programming while `variable` is a placeholder for data.

## ⌨️ CLI

Now that we know the basics of the Terraform code, how do we `apply` our work and changes or even initialize our enviroment? That's where the Terraform CLI you installed comes in! Here are the top four commands you will use:

* `terraform init` - `init`, intializes the current directory for Terraform development!

* `terraform plan` - `plan`, shows the user what changes have been made, similar to `git diff` or `git status`.

* `terraform apply` - `apply`, pushes the changes made in the `.tf` files to the infrastructure, just like `git push`. Terraform will automatically delete, add, or change any resource as mentioned in the file.

* `terraform destroy` - `destroy`, destroys the infrastructre you created with the `.tf`. This is reccomended over manually destroying an instance.

## ✍️ Practice

> Tip: Always look between your Terraform console and your AWS console to see the changes!

We will do the following:

* Initialize the directory
* Create a ec2 instance on AWS
* Assign it a name
* Output information related to the instance
  * Server ID
  * Server private IP
  * Assigned name

So we know from the AWS [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) that to connect to our aws provider, we need a region and our [aws credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

```json
provider "aws" {
    region      = "us-west-1"
    access_key  = "AKIAIOSFODNN7EXAMPLE"
    secret_key  = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
} 
```

Now we can't have our keys open—that's Devops 101, so how can we hide them?

<!-- tabs:start -->
### **Variables**

### Variables

Both methods would require us using variables, and in terraform, we use the `var.name` method to access variables, denoted as such:

```json
provider "aws" {
    region      = "us-west-1"
    access_key  =  var.access_key
    secret_key  =  var.secret_key
} 
```

#### Environment Variables `TF_VAR_name`

In this method we will create environment variables in the terminal. Terraform [prioritizes](https://www.terraform.io/docs/configuration/variables.html) environment variables over anything other method and must follow this pattern: `TF_VAR_name`

```bash
export TF_VAR_access_key=AKIAIOSFODNN7EXAMPLE
export TF_VAR_secret_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

Pros:

* Overwrite variables the user wants to change
* Zero possibility being track to source control
* Fast for a simple check

Cons:

* Only temporary
* Not suitable for long projects
* Lost if the terminal is closed

#### Using `.tfvars`

This method would require us to create a file name `secret.tfvars` and in the file, we can record our keys.

 **MAKE SURE TO ADD THE FILE TO THE GITIGNORE**.

```tf
access_key=AKIAIOSFODNN7EXAMPLE
secret_key=wJalrXUtnFEMI/K7MDENG/
```

Since the file does not have the default name, `terraform.tvfars`, we have to use the `-var-file=` flag.

```bash
terraform apply \
  -var-file="secret.tfvars"
```

Pros:

* Persistant
* Reproducible
* Can change easily

Cons:

* Can accidentally track

### **AWS Config**

### Config

This method is unique to the AWS `provider`, so be sure to read the provider documentation if they have any other way to handle secrets.

```json
provider "aws" {
  region           = "us-west-1"
  credentials_file = "~/.aws/creds"
}
```

Pros:

* Don't have to worry about accidentally tracking credentials
* Fast
* Persistent \ Don't have to reassign

Cons:

* Not easily reproducible with others
* Can't work with other credentials [Unless profiles are used]

<!-- tabs:end -->

After we specify the provider go ahead and run `terraform init`, so Terraform can download all the AWS plugins. Then run `terraform apply` to make sure the keys are correct. Then we will create an instance, so again, refer to the documentation. We know the rescource name is `aws_instance`, and we learn the required pieces of information needed here is the ami and instance_type. So let's go to the AWS console and go through the steps to create an [instance](https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:).

![Machine Image](../images/ami.png)

![Instance Type](../images/instance_type.png)

Now that we know both the `instance_type` and `ami`, let's apply it:

```json
resource "aws_instance" "web-server" {
  ami               = "ami-03130878b60947df3"
  instance_type     = "t2.micro" 
}
```

Now go ahead and complete the leftover objectives.

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
