---

# Infrastructure as Code: Automating EC2 Instance Setup on AWS with Terraform

## AWS EC2 Automation with Terraform

Automate the deployment of multiple EC2 instances with custom security groups using Terraform on AWS.

---

## Introduction

Manual provisioning of cloud infrastructure can be error-prone, time-consuming, and difficult to replicate across environments. This project, **"Infrastructure as Code: Automating EC2 Instance Setup on AWS with Terraform"**, automates the provisioning of EC2 instances using **Terraform**, an open-source Infrastructure as Code (IaC) tool.

It enables users to define and deploy a consistent cloud environment with reusable, scalable configurations. This project provisions:

* **Three Ubuntu EC2 instances** (t2.micro)
* A **custom security group**
* Outputs the **public IPs** for further access and deployment

By automating the creation of:

* **Ubuntu EC2 instances**
* **Security group configurations**
* **EBS volumes (20GB)** for each instance

The configuration ensures repeatable, version-controlled infrastructure deployment with minimal manual intervention.

---

## Example of Main Configuration (from `main.tf`)

```hcl
resource "aws_instance" "ubuntu_instance" {
  count         = 3
  ami           = "ami-084568db4383264d4"  # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = "hello"  # SSH key
}
```

---

## Table of Contents

1. [Overview]
2. [Features]
3. [Technologies Used]
4. [Project Structure]
5. [Prerequisites]
6. [Setup Instructions]
7. [AWS Access Key & Secret Key Usage]
8. [Terraform Files Explained]
9. [Output Description]
10. [Conclusion]
11. [Contributing]
12. [License]

---

## 1. Overview

This project uses Terraform to:

* Provision **3 EC2 Ubuntu instances** on AWS.
* Attach a **custom security group** with defined inbound rules.
* Automatically output the **public IPs** of the instances.
* Showcase repeatable infrastructure deployment using **IaC** best practices.

---

## 2. Features

* **Automated EC2 Provisioning**: Deploys 3 Ubuntu 22.04 instances in `us-east-1`.
* **Custom Security Group**: Pre-configured with essential ports:

  * SSH (22), HTTP (80), HTTPS (443)
  * Custom ports: 8080, 5000, 6664
* **EBS Volumes**: 20GB `gp2` volumes attached to each instance.
* **Output Automation**: Displays public IPs after deployment.
* **Tagging**: Instances named systematically (Ubuntu-TF-1, Ubuntu-TF-2, etc.)
* **Public IP Output** for remote access.
* **Reusable Terraform Configs**.

---

## 3. Technologies Used

* **Infrastructure as Code**: Terraform
* **Cloud Provider**: AWS
* **Operating System**: Ubuntu 22.04 (on EC2)
* **Version Control**: Git & GitHub
* **OS Environment**: Fedora (Linux)

---

## 4. Project Structure

```bash
.
├── main.tf              # Core Terraform configuration
├── output.tf            # Outputs public IPs of instances
├── terraform.tfstate    # Terraform-managed state file (auto-generated)
├── terraform.tfstate.backup  # Backup of previous state
└── README.md            # Project documentation
```

### Diagram

```mermaid
graph TD
    A[Terraform Config] --> B[AWS Provider]
    B --> C[Default VPC]
    B --> D[Security Group]
    B --> E[EC2 Instances x3]
    D -->|Attached to| E
    E --> F[20GB EBS Volumes]

┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  EC2 Instance   │    │  EC2 Instance   │    │  EC2 Instance   │
│  Ubuntu-TF-1    │    │  Ubuntu-TF-2    │    │  Ubuntu-TF-3    │
│  - t2.micro     │    │  - t2.micro     │    │  - t2.micro     │
│  - 20GB EBS     │    │  - 20GB EBS     │    │  - 20GB EBS     │
└────────┬────────┘    └────────┬────────┘    └────────┬────────┘
         │                      │                      │
         └──────────┬───────────┘                      │
                    │                                  │
           ┌────────▼──────────┐             ┌─────────▼─────────┐
           │  Security Group   │             │  Default VPC      │
           │  - ubuntu-sg      │             │  (us-east-1)      │
           │  - Ports: 22,80,443 │           └───────────────────┘
           │  - 8080,5000,6664 │
           └───────────────────┘
```

---

## 5. Prerequisites

Ensure the following are installed and configured on your **Fedora Linux** machine:

* **Terraform**
* **AWS CLI**: `sudo dnf install awscli -y`
* **AWS Account** with:

  * Access Key
  * Secret Key
* **Key Pair** named `hello` created in AWS (used for SSH into EC2)

---

## 6. Setup Instructions

### Step 1: Configure AWS Credentials

Run the following command and provide the credentials when prompted:

```bash
aws configure
```

Enter:

* AWS Access Key ID
* AWS Secret Access Key
* Default region: `us-east-1`
* Default output format: `json`

### Step 2: Clone the Repository

```bash
git clone https://github.com/your-username/terraform-aws-ec2-setup.git
cd terraform-aws-ec2-setup
```

### Step 3: Initialize Terraform

```bash
terraform init
```

### Step 4: Apply Terraform Plan

```bash
terraform apply
```

#### Deployment Steps:

* **Initialize Terraform**: `terraform init`
* **Preview changes**: `terraform plan`
* **Apply configuration**: `terraform apply`
* **Destroy resources** (when done): `terraform destroy`

---

## 7. AWS Access Key & Secret Key Usage

These credentials allow Terraform to authenticate with your AWS account. They are securely stored in:

```bash
~/.aws/credentials
```

⚠️ Important: Copy and save these somewhere safe. You won’t be able to see the secret key again.

After that: Run aws configure in your terminal and paste them in.
Let me know if you want help creating a basic Terraform file to launch EC2 instances!

* The terminal asks for Access Key & Secret Key when you run:

aws configure

* This command is part of the AWS CLI, and it prompts you like this:

AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: us-east-1
Default output format [None]: json

 ->Troubleshooting
Common Issues
Error Message	Solution
Error: InvalidKeyPair.NotFound	Verify key pair exists in same region
Error: UnauthorizedOperation	Check IAM permissions for EC2/VPC
Error: InsufficientInstanceCapacity	Try different AZ or instance type
Debug Commands
bash

-Refresh state
terraform refresh

-Show current state
terraform show

- Validate configuration
terraform validate


---

## 8. Terraform Files Explained

### `main.tf`

* Launches 3 EC2 Ubuntu instances
* Creates a security group
* Uses the default VPC

### `output.tf`

Outputs the public IPs of the instances:

```hcl
output "instance_ips" {
  value = [for instance in aws_instance.ubuntu_instance : instance.public_ip]
}
```

---

## 9. Output Description

After running `terraform apply`, you’ll see the output like:

```bash
Outputs:

instance_ips = [
  "3.86.XXX.XX",
  "54.91.XXX.XX",
  "18.232.XXX.XX"
]
```

---

## 10. Conclusion

This project demonstrates the use of Infrastructure as Code (IaC) with Terraform to provision scalable and reproducible AWS resources. It simplifies cloud deployment, minimizes manual errors, and speeds up the setup of infrastructure environments — an essential skill for DevOps and Cloud Engineers.

---

## 11. Contributing

Contributions are welcome!
Fork the repo, make changes, and submit a pull request.

---

## 12. License

This project is licensed under the MIT License.
See the `LICENSE` file for details.

---
