# Terraform Modular Infrastructure

This project deploys a containerized application on AWS using a modular Terraform setup. Each infrastructure component is isolated into its own module for reusability, clarity, and best practices.

---

## 🚀 Deployment Workflow

1. **Pre-requisites**
   - ACM certificate must be manually created and validated (via Route 53).
   - Domain DNS should be configured before running workflow.

2. **GitHub Actions**
   - Triggered on `main` branch push or manual dispatch.
   - Performs the following:
     - Builds Docker image and pushes it to **Amazon ECR**
     - Injects `image_uri` and `acm_certificate_arn` into Terraform as `image.auto.tfvars`
     - Executes `terraform init`, `plan`, and (optionally) `apply` per environment (`dev`, `stage`, `prod`)


---

## ⚙️ Modules Overview

- **VPC**: Creates a custom VPC with subnets, route tables, etc.
- **IAM**: Manages IAM roles and policies required by ECS and other services.
- **S3**: Sets up S3 buckets for app or config storage.
- **ECS**: Defines ECS Cluster, Task Definitions, and Services.
- **ALB**: Creates Application Load Balancer and Target Groups.
- **CloudWatch**: Enables logging, monitoring, and alerting.
- **Provider**: Configures AWS provider and credentials (optional as a module).

> 📝 **Note**: For simplicity, this project uses a **single `main.tf`, `variables.tf`, and `outputs.tf`** file.  
> You can modularize these into separate files (e.g., `ecs.tf`, `network.tf`, etc.) for better separation and maintenance in large infrastructures.

---

## 🌍 Multi-Environment Support

This project supports **isolated deployments for different environments** using environment-specific variable files:

- `dev.tfvars`
- `stage.tfvars`
- `prod.tfvars`

Each environment uses:
- Separate subnets, tags, and naming conventions
- Different configurations for scaling, container image versions, etc.

This is achieved using a **matrix strategy** in GitHub Actions that loops over environments and injects the correct `.tfvars` during plan/apply.

---

## ✅ Key Features

- **🧹 Modularity**: Each component is isolated in a module, making the infrastructure reusable and easy to maintain.
- **📈 Scalability**: ECS Fargate and ALB enable scalable containerized deployments.
- **🛡 High Availability**: Multi-AZ deployments across subnets and load balancing ensure high uptime.
- **💸 Cost Efficiency**: Uses ECS Fargate (pay-as-you-go), and can auto-scale based on load to avoid overprovisioning.
- **🌐 DNS & SSL**: Integrates with Route 53 for domain management and ACM for pre-provisioned TLS certificates.

---

## 🐳 Sample Web App

A sample Dockerized website is included under the `app/` folder:

- `Dockerfile`: Defines app image
- `app/`: Contains sample static or Node.js/Next.js app

---

## 🔄 CI/CD Pipeline Summary

```bash
# GitHub Workflow Automates:
1. docker build -t <repo>:<sha>
2. docker push to Amazon ECR
3. auto-creates terraform/image.auto.tfvars
4. terraform plan -var-file=dev.tfvars
5. terraform apply -auto-approve (manual trigger only)

🛠 Usage
bash
Copy code

# Terraform Manual (for testing)
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -auto-approve -var-file="dev.tfvars"

---


## 🔐 GitHub Secrets Required

Secret Name	Description
AWS_ACCESS_KEY_ID	AWS access key
AWS_SECRET_ACCESS_KEY	AWS secret key
ECR_REPOSITORY	Full ECR repo URI (e.g., 1234…amazonaws.com/my-app)
ACM_CERTIFICATE_ARN	ARN of pre-provisioned ACM cert

📌 Notes
Use terraform/image.auto.tfvars only via workflow – do not version it.

Environment-specific configs are in: dev.tfvars, stage.tfvars, prod.tfvars

Always validate infrastructure before apply.

---

## 🧑‍💻 Author
Harshil Yogi

