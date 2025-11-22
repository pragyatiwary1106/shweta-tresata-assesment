# Azure Kubernetes Service (AKS) Terraform Infrastructure

This repository contains Terraform configuration for deploying Azure Kubernetes Service (AKS) infrastructure with auto-scaling capabilities.

## Architecture

The infrastructure is organized using a modular approach with the following components:

### Modules
- **Resource Group Module** (`modules/rg/`) - Creates Azure Resource Group
- **AKS Module** (`modules/aks/`) - Deploys AKS cluster with auto-scaling enabled

### Features
- **Auto-scaling**: Node pool automatically scales between min/max node counts
- **System-assigned identity**: Managed identity for AKS cluster
- **Environment-specific configurations**: Separate tfvars for dev and prod
- **Remote state management**: Azure Storage backend for Terraform state

## File Structure

```
terraform/
├── modules/
│   ├── aks/
│   │   ├── aks.tf          # AKS cluster resource
│   │   ├── variables.tf    # AKS module variables
│   │   └── output.tf       # AKS outputs (kubeconfig, certificates)
│   └── rg/
│       ├── rg.tf           # Resource group resource
│       ├── variables.tf    # RG module variables
│       └── output.tf       # RG outputs
├── environment/
│   ├── dev/
│   │   └── dev.tfvars      # Development environment variables
│   └── prod/
│       └── prod.tfvars     # Production environment variables
├── aks.tf                  # Main module calls
├── provider.tf             # Azure provider configuration
├── backend.tf              # Remote state configuration
├── variables.tf            # Root module variables
└── output.tf               # Root module outputs
```

## Prerequisites

- Azure CLI installed and authenticated
- Terraform >= 1.0
- Azure subscription with appropriate permissions
- Azure Storage Account for remote state (configured in backend.tf)

## Configuration

### Environment Variables
Set the following environment variable for backend authentication:
```bash
export ARM_ACCESS_KEY="your-storage-account-access-key"
```

### Key Configuration Files

**Dev Environment** (`environment/dev/dev.tfvars`):
- Resource Group: `dev-rg`
- AKS Cluster: `Akscluster-pragya`
- Location: `West Europe`
- VM Size: `Standard_B2s`
- Auto-scaling: 1-5 nodes

**Prod Environment** (`environment/prod/prod.tfvars`):
- Resource Group: `prod-rg`
- AKS Cluster: `Akscluster-prod-pragya`
- Location: `West Europe`
- VM Size: `Standard_D2_v2`

## Deployment

### Initialize Terraform
```bash
cd terraform
terraform init
```

### Plan Deployment
```bash
# For development
terraform plan -var-file="environment/dev/dev.tfvars"

# For production
terraform plan -var-file="environment/prod/prod.tfvars"
```

### Apply Configuration
```bash
# For development
terraform apply -var-file="environment/dev/dev.tfvars"

# For production
terraform apply -var-file="environment/prod/prod.tfvars"
```

## AKS Configuration

### Auto-scaling
- **Enabled**: Node pool automatically scales based on workload
- **Min Count**: 1 node (configurable)
- **Max Count**: 5 nodes (configurable)
- **Initial Count**: Set to min_count value

### Security
- **Identity**: System-assigned managed identity
- **Secrets**: No hardcoded credentials in code
- **Access**: Backend authentication via environment variables

## Outputs

The infrastructure provides the following outputs:
- **client_certificate**: AKS client certificate (sensitive)
- **kube_config**: Raw kubeconfig for cluster access (sensitive)

## Best Practices Implemented

- Modular architecture for reusability
- Environment-specific configurations
- Remote state management
- Auto-scaling for cost optimization
- Managed identity for security
- Sensitive output handling
- Proper resource tagging

## Usage Notes

1. Ensure Azure Storage Account exists before running terraform init
2. Set ARM_ACCESS_KEY environment variable for backend authentication
3. Review and customize tfvars files for your requirements
4. Use appropriate VM sizes for your workload requirements




<img width="1013" height="566" alt="image" src="https://github.com/user-attachments/assets/06772869-5ebb-46db-b4a8-ae105f355411" /># 🚀 Kubernetes Cluster Provisioning, Monitoring & Logging (Terraform + AKS + Prometheus + Grafana + Fluent Bit)

This project is a complete implementation of the assessment:

**“Provision a Kubernetes cluster using Terraform, configure networking policies, deploy monitoring using Prometheus/Grafana, deploy a DaemonSet logging/monitoring agent, create dashboards, alerts, and provide a detailed README explaining the design.”**

---

<img width="1013" height="566" alt="image" src="https://github.com/user-attachments/assets/0a781511-5a05-458e-972d-540261fee278" />

---

# 📌 Overview

This solution provisions:

✔ A Kubernetes (AKS) Cluster using **Terraform**  
✔ A modular Terraform structure supporting **dev** and **prod**  
✔ **Network Policies** for pod-level traffic control  
✔ Full Monitoring Stack:
   - Prometheus  
   - Alertmanager  
   - Grafana  
   - Node Exporter  
   - Kube-State-Metrics  
✔ Custom **Alert Rule (High CPU alert)** using PrometheusRule  
✔ A **DaemonSet Logging Agent (Fluent Bit)** running on every node  
✔ Grafana Dashboards (including the famous **Node Exporter Full** dashboard)  
✔ LoadBalancer exposure for Grafana & Prometheus  
✔ Step-by-step manual operational guide

The goal is to demonstrate both **Infrastructure as Code (IaC)** and **Observability** best practices.

---

# 🧩 Architecture

Below is the **high-level architecture**:

```mermaid
flowchart TD

A[TERRAFORM APPLY] --> B[Azure AKS Cluster]
B --> C[Kubernetes API Server]

subgraph Monitoring Namespace
    D[Prometheus Operator]
    E[Prometheus Server]
    F[Alertmanager]
    G[Grafana]
    H[Node Exporter DaemonSet]
    I[Kube-State-Metrics]
    J[Fluent Bit DaemonSet]
end

C --> D
D --> E
D --> F
E --> G
B --> H
B --> I
B --> J
