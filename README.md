# PokemonTerraform

A modular Terraform project to deploy a simple AWS infrastructure tailored for a Pokémon-themed demo. This setup includes an EC2 instance, DynamoDB table, security groups, and a key pair.

## 📦 Project Structure

```
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
│   ├── dynamodb/
│   ├── ec2/
│   ├── key/
│   └── security_group/
```

## 🚀 Features

- Modularized design for reusability
- Creates an EC2 instance (e.g., for hosting a Pokémon app or API)
- Sets up a DynamoDB table (possibly for Pokémon data)
- Manages key pairs and security groups
- Uses `terraform.tfvars` for easy input customization

## 🛠️ Requirements

- Terraform v1.3+
- AWS CLI configured (`aws configure`)
- An AWS account with sufficient permissions (EC2, DynamoDB, IAM)

## 🔧 Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Review the execution plan

```bash
terraform plan
```

### 3. Apply the configuration

```bash
terraform apply
```

### 4. Destroy the infrastructure

```bash
terraform destroy
```

## 📄 Variables

Define custom values in `terraform.tfvars`:

```hcl
region         = "us-west-2"
instance_type  = "t2.micro"
table_name     = "pokemon_table"
```

More variables can be found in `variables.tf` in the root and module folders.

## 📤 Outputs

Outputs are defined in `outputs.tf` and include things like:

- EC2 instance public IP
- DynamoDB table name

## 📁 Modules

Each module has its own `main.tf`, `variables.tf`, and `outputs.tf`. They encapsulate logic for specific AWS resources.

## 🔐 Security

Make sure you don't commit your private key or sensitive `.tfvars` files.

## 📘 License

MIT