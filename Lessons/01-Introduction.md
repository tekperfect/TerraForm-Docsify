<!-- Lessons/01-Introduction -->
# Getting Started

# ⏱ Agenda

1. 🏆 Learning Objectives
1. 
1. 📚 Resources & Credits
 
# 🏆 Learning Objectives

By the end of this, you'll be able to...

1. Navigate Terraform Documentation
1. Understand the basics of IaaC

# 📖 Terraform

## Why Terraform?

* replication of infrastructure
* managment of said infrastructure
* shift from a Dev to Prod enviroment
* Declerative

## What is Terraform
**First and fore most Terraform is an IaaC**

IaaC or Infrastructure as a Code, is the same as a programmable infrastructure. tl;dr IaaC are ways to  manipulate and or create parts of infrastructure e.g. load balancers, security, and networks via a source code

As an Iaac, Terraform is a DevOps tool to automate and manage the infrastructure of your product and the services that run within your product; However Terraform is main feature is an infrastructure provsioning tool.

> You can say it's the Docker of infrastructure, as they are both a declerative language [defining the desirted end results ex. We want 5 servers with these set of perms]


## Installation
> The following instruction are for Unix compatiable systems like Ubuntu, otherwise follow [This](https://learn.hashicorp.com/tutorials/terraform/install-cli)

If you have a package manager like brew I suggest you use it! make sure you have awscli as well!

```bash
brew install terraform
```

Verify the installation with

```bash
sudo terraform -help
```
# ✍️ Practice

Look over the rescourse and documents to get a better understanding of IaaCs and terraform

# 📚 Resources & Credits

* [Terraform by HashiCorp](https://www.terraform.io/intro/index.html)
* [Intro to Terraform](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started)
* [Terraform Documentation](https://www.terraform.io/docs)
* [Techworld by Nana](https://www.youtube.com/watch?v=l5k1ai_GBDE&t=616s)
