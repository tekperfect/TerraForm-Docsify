<!-- Lessons/01-Introduction -->
<!-- http://localhost:3000/#/Lessons/01-Introduction  -->
# 📜 Getting Started

## ⏱ Agenda

1. 🏆 Learning Objectives
1. 📖 Terraforms
1. ✍️ Practice
1. 📚 Resources & Credits

## 🏆 Learning Objectives

By the end of this, you'll be able to...

1. Navigate Terraform Documentation
1. Understand the basics of IaaC

## 📖 Terraform

### Why Terraform?

* Replication of infrastructure
* Management of said infrastructure
* Shift from a Dev to Prod environment
* Declarative

### What is Terraform

#### **First and foremost Terraform is an IaaC**

IaaC or Infrastructure as a Code, is the same as a programmable infrastructure. tl;dr IaaC are ways to manipulate and or create parts of infrastructure e.g. load balancers, security, and networks via a source code.

As an Iaac, Terraform is a DevOps tool to automate and manage the infrastructure of your product and the services that run within your product; However Terraform is main feature is an infrastructure provsioning tool.

> You can say it's the Docker of infrastructure, as they are both a declerative language [defining the desired end results ex. We want 5 servers with these set of perms]

### Installation

> The following instructions are for Unix compatiable systems like Ubuntu, otherwise follow [This](https://learn.hashicorp.com/tutorials/terraform/install-cli)

If you have a package manager like Brew I suggest you use it! Make sure you have AWS CLI as well!

```bash
brew install terraform
```

Verify the installation with

```bash
sudo terraform -v
```

After I will suggest to install the appropiate Terraform linter to your edtitor, I am using VScode, so I will use this [extenstion](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

We will working with v0.12+ compatible requirements, so make sure you have at least v0.12 of the Terraform CLI.

## ✍️ Practice

Look over the resource and documents to get a better understanding of IaaCs and Terraform.

## 📚 Resources & Credits

* [Terraform by HashiCorp](https://www.terraform.io/intro/index.html)
* [Intro to Terraform](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started)
* [Terraform Documentation](https://www.terraform.io/docs)
* [Techworld by Nana](https://www.youtube.com/watch?v=l5k1ai_GBDE&t=616s)
